part of '../services.dart';

class UserProvider {
  Future<http.Response> login(String email, String password) async {
    http.Client client = http.Client();

    String body = jsonEncode({
      "email": email,
      "password": password,
    });

    http.Response res = await client.post(
      Uri.parse("$baseUrl/users/login"),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    return res;
  }

  Future<http.StreamedResponse> register(User user, File file) async {
    Map<String, String> stringData = {
      "name": user.name,
      "email": user.email,
      "password": user.password ?? "",
      "home_number": user.houseNumber ?? "",
      'address': user.address ?? "",
      'city': user.city ?? "",
    };

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("profile", file.path);

    http.MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse("$baseUrl/users/register"))
          ..fields.addAll(stringData)
          ..files.add(multipartFile);

    http.StreamedResponse res = await request.send();

    return res;
  }

  Future<http.StreamedResponse> update(
    User user,
    String token,
    File? file,
  ) async {
    Map<String, String> stringData = {
      "name": user.name,
      'email': user.email,
      'house_number': user.houseNumber ?? "",
      'address': user.address ?? "",
      'city': user.city ?? "",
      'phone_number': user.phoneNumber.toString(),
    };

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    http.MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse('$baseUrl/users/profile?_method=PATCH'))
      ..fields.addAll(stringData);

    if (file != null) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('profile', file.path);
      request.files.add(multipartFile);
    }

    request.headers.addAll(headers);

    http.StreamedResponse res = await request.send();

    return res;
  }

  Future<http.Response> profile(String token) async {
    http.Client client = http.Client();
    http.Response res = await client.get(
      Uri.parse("$baseUrl/users/profile"),
      headers: {
        'Authorization': "Bearer $token",
      },
    );

    return res;
  }
}
