part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserFailed extends UserState {
  final String message;

  UserFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserLoading extends UserState {
  UserLoading();

  @override
  List<Object?> get props => [];
}
