import '../../model/user/user_model.dart';
import 'login_repository.dart';

class LoginMockImp extends LoginRepository{

  @override
  Future<UserModel> loginAuth(data) {
    // TODO: implement loginAuth
    throw UnimplementedError();
  }

}