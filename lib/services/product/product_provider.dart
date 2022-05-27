import 'package:food_market/models/user.dart';
import 'package:food_market/services/services.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  Future<http.Response> getProducts() async {
    http.Client httpClient = http.Client();

    String token = await User.getToken() ?? "";

    http.Response res =
        await httpClient.get(Uri.parse("$baseUrl/products"), headers: {
      "Authorization": "Bearer $token",
    });
    return res;
  }
}
