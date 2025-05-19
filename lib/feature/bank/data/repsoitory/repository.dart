import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class BankRepository {
  final Api _apiClint;

  BankRepository(this._apiClint);

  Future<Response<List<BankBank>>> getBanks() async {
    return await _apiClint.banksGet();
  }
}
