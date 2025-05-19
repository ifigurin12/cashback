import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class CashbackRepository {
  final Api _apiClint;

  CashbackRepository(this._apiClint);

  Future<Response<dynamic>> createCardsCashback({
    required String cardId,
    required List<CashbackCashback> cashbacks,
    required List<String> categoryIds,
    required String authHeader,
  }) async {
    return await _apiClint.cardsIdCashbackPost(
      id: cardId,
      request: ApiCreateCashbacksRequest(
        cashbacks: cashbacks,
        categoryIds: categoryIds,
      ),
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> updateCardsCashback({
    required String cardId,
    required List<CashbackCashback> cashbacks,
    required List<String> categoryIds,
    required String authHeader,
  }) async {
    return await _apiClint.cardsIdCashbackPut(
      id: cardId,
      request: ApiUpdateCashbacksRequest(
        cashbacks: cashbacks,
        categoryIds: categoryIds,
      ),
      authorization: authHeader,
    );
  }
}
