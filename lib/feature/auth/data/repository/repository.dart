import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class AuthRepository {
  final Api _apiClint;

  AuthRepository(this._apiClint);

  Future<Response<UserToken>> loggedIn({
    required String email,
    required String password,
  }) async {
    return await _apiClint.emailLoginPost(
      request: RequestEmailLoginRequest(
        email: email,
        password: password,
      ),
    );
  }
}
