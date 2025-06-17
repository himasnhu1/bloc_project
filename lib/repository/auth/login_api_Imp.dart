import 'package:bloc_project/data/network/network_services_dio.dart';
import 'package:bloc_project/model/user/user_model.dart';
import '../../data/network/network_api_http.dart';
import '../../utils/ApiString/api_url.dart';
import 'login_repository.dart';

class LoginApiImp implements LoginRepository {
  final networkApi = NetworkApiServiceHttp();
  final networkDio = NetworkApiService();

  @override
  Future<UserModel> loginAuth(data) async {
    // final json = await networkApi.postApiResponse(ApiString.baseUrl,data);

    final json = await networkDio.postApiResponse(ApiString.baseUrl, data);

    return UserModel.fromJson(json);
  }
}
