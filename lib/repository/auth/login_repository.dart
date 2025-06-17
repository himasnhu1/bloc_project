import '../../model/user/user_model.dart';

abstract class  LoginRepository {
  Future<UserModel> loginAuth(dynamic data);
}