part of 'login_bloc.dart';

class LoginStates extends Equatable {
  const LoginStates({this.email = '',
    this.passwords = '',
    this.postApiStatus = PostApiStatus.initial,
    this.message=''
  });

  final String email;
  final String passwords;
  final PostApiStatus postApiStatus;
  final String message;

  LoginStates copyWith({String? email, String? passwords, PostApiStatus? postApiStatus, String? message}) {
    return LoginStates(
        email: email ?? this.email,
        passwords: passwords ?? this.passwords,
        postApiStatus: postApiStatus ?? this.postApiStatus,
        message:message ?? this.message
    );
  }

  @override
  List<Object> get props => [email, passwords,postApiStatus,message];
}
