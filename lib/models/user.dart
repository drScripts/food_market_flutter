import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? address;
  final String? phoneNumber;
  final String? houseNumber;
  final String? city;
  final String? password;
  final String? profilePicture;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.houseNumber,
    this.city,
    this.address,
    this.password,
    this.profilePicture,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
    String? phoneNumber,
    String? houseNumber,
    String? city,
    String? password,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      houseNumber: houseNumber ?? this.houseNumber,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['profile']['address'],
      phoneNumber: json['profile']['phone_number'],
      houseNumber: json['profile']['house_number'],
      city: json['profile']['city'],
      password: null,
      profilePicture: json['profile']['profile_picture'],
    );
  }

  static Future<void> storeToken(String token) async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    await prefInstance.setString('usrtkn', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    return prefInstance.getString('usrtkn');
  }

  static Future<void> removeToken() async {
    SharedPreferences prefInstance = await SharedPreferences.getInstance();

    prefInstance.remove('usrtkn');
  }

  static User mock = const User(
    email: "nathanael.vd@gmail.com",
    name: "Nathanael Valentino Davis",
    id: 1,
    phoneNumber: "085720070080",
    houseNumber: "Ca no 15",
    address: "Komplek Permata Kopo, Desa Sayati, Kecamatan Margahayu",
    city: "Bandung",
  );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        houseNumber,
        city,
        address,
      ];
}
