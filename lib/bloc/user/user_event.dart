part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class Login extends UserEvent {
  final String email;
  final String password;

  const Login({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class Logout extends UserEvent {
  @override
  List<Object?> get props => [];
}

class Register extends UserEvent {
  final User user;
  final File file;

  const Register({required this.user, required this.file});

  @override
  List<Object?> get props => [user];
}

class CheckCredential extends UserEvent {
  @override
  List<Object?> get props => [];
}

class Update extends UserEvent {
  final User user;
  final File? file;

  const Update({required this.user, this.file});
}
