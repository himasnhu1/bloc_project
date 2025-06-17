part of 'login_bloc.dart';

class LoginStates extends Equatable {
  const LoginStates({this.email = '',
    this.passwords = '',
    this.postApiStatus = PostApiStatus.initial,
    this.message='',
    this.token=''
  });

  final String email;
  final String passwords;
  final PostApiStatus postApiStatus;
  final String message;
  final String token;

  LoginStates copyWith({String? email, String? passwords, PostApiStatus? postApiStatus, String? message,String? token}) {
    return LoginStates(
        email: email ?? this.email,
        passwords: passwords ?? this.passwords,
        postApiStatus: postApiStatus ?? this.postApiStatus,
        message:message ?? this.message,
        token:token ?? this.token);
  }

  @override
  List<Object> get props => [email, passwords,postApiStatus,message];
}
