import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:food_market/models/user.dart';
import 'package:food_market/services/services.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<Login>(login);

    on<Register>(register);

    on<Logout>(((event, emit) async {
      User.removeToken();
      await Future.delayed(const Duration(seconds: 3));
      emit(UserInitial());
    }));

    on<CheckCredential>(checkCredential);

    on<Update>(updateProfile);
  }

  Future<void> updateProfile(Update event, Emitter emit) async {
    emit(UserLoading());
    String token = await User.getToken() ?? "";

    UserProvider userProvider = UserProvider();

    http.StreamedResponse res =
        await userProvider.update(event.user, token, event.file);

    dynamic bodyResponse = jsonDecode(await res.stream.bytesToString());

    if (res.statusCode == 201) {
      User user = User.fromJson(bodyResponse['data']);

      emit(UserLoaded(user: user));
    } else {
      emit(UserFailed(message: bodyResponse['meta']['message']));
      await Future.delayed(const Duration(seconds: 1));
      emit(UserLoaded(user: event.user));
    }
  }

  Future<void> checkCredential(
      CheckCredential event, Emitter<UserState> emit) async {
    emit(UserLoading());
    String token = await User.getToken() ?? "";
    UserProvider userProvider = UserProvider();

    http.Response res = await userProvider.profile(token);
    if (res.statusCode == 200) {
      dynamic responseBody = jsonDecode(res.body);

      User user = User.fromJson(responseBody['data']);

      emit(UserLoaded(user: user));
    } else {
      emit(UserInitial());
    }
  }

  Future<void> register(Register event, Emitter<UserState> emit) async {
    emit(UserLoading());
    User user = event.user;

    UserProvider userProvider = UserProvider();

    http.StreamedResponse res = await userProvider.register(user, event.file);
    dynamic bodyResponse = jsonDecode(await res.stream.bytesToString());

    if (res.statusCode == 201) {
      User user = User.fromJson(bodyResponse['data']['user']);
      await User.storeToken(bodyResponse['data']['token']);

      emit(UserLoaded(user: user));
    } else {
      emit(UserFailed(message: bodyResponse['meta']['message']));
    }
  }

  Future<void> login(Login event, Emitter<UserState> emit) async {
    emit(UserLoading());
    String email = event.email;
    String password = event.password;

    UserProvider userProvider = UserProvider();

    http.Response res = await userProvider.login(email, password);
    dynamic bodyresponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      User user = User.fromJson(bodyresponse['data']['user']);
      await User.storeToken(bodyresponse['data']['token']);
      emit(UserLoaded(user: user));
    } else {
      emit(UserFailed(message: bodyresponse['meta']['message']));
    }
  }
}
