import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class UserRepository {
  final Api _apiClint;

  UserRepository(this._apiClint);

  Future<Response<UserUser>> getUser({
    required String id,
  }) async {
    return await _apiClint.usersIdGet(
      id: id,
    );
  }

  Future<Response<dynamic>> createUser({
    required String email,
    required String login,
    required String password,
  }) async {
    return await _apiClint.usersPost(
      user: RequestCreateUserRequest(
        email: email,
        login: login,
        password: password,
      ),
    );
  }
}
