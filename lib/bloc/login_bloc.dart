import 'package:bloc/bloc.dart';
import 'package:bloc_project/repository/auth/login_api_Imp.dart';
import 'package:bloc_project/repository/auth/login_repository.dart';
import 'package:bloc_project/utils/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginApiImp loginApiImp = LoginApiImp();
  LoginBloc() : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    if (kDebugMode) {
      print(event.email);
    }
    if (event.email.isNotEmpty) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    }
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    if (event.password.isNotEmpty) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    }
    emit(state.copyWith(passwords: event.password));
  }
  //{"email": "Monu8273@gmail.com", "password": "1234567"};

  Future<void> _loginApi(LoginApi event, Emitter<LoginStates> emit) async {
    // var data = json.encode({
    //   "email": "eve.holt@reqres.in",
    //   "password": "cityslicka", // ✅ correct password
    // });

    Map<String, dynamic> data = {
      "email": state.email,
      "password": state.passwords,
    };

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      final value = await loginApiImp.loginAuth(data);

      if (value.error.isNotEmpty) {
        emit(state.copyWith(
          message: value.error.toString(),
          postApiStatus: PostApiStatus.error,
        ));
      } else {
         emit(state.copyWith(
          message: value.token.toString(),
          postApiStatus: PostApiStatus.success,
        ));
      }
    } catch (error) {

      debugPrint("Error===>${error.toString()}");

       emit(state.copyWith(
        message: error.toString(),
        postApiStatus: PostApiStatus.error,
      ));
    }
  }

  // Future<void> _loginApi(LoginApi event, Emitter<LoginStates> emit) async {
  //   Map data = {"email": state.email, "password": state.passwords};

  //   emit(state.copyWith(postApiStatus: PostApiStatus.loading));

  //  await loginApiImp.loginAuthte(data);

  //   await loginApiImp.loginAuth(data).then((value) {
  //     if (value.error.isNotEmpty) {
  //       emit(state.copyWith(
  //           message: value.error.toString(),
  //           postApiStatus: PostApiStatus.error));
  //     } else {
  //       emit(state.copyWith(
  //           message: 'Login Successful', postApiStatus: PostApiStatus.success));
  //     }
  //   }).onError((error, stack) {
  //     emit(state.copyWith(
  //         message: error.toString(), postApiStatus: PostApiStatus.error));
  //   });
  // }
}
