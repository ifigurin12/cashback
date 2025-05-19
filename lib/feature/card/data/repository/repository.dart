import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class CardRepository {
  final Api _apiClint;

  CardRepository(this._apiClint);

  Future<Response<ApiListCardsResponse>> getCards({
    required String authHeader,
  }) async {
    return await _apiClint.cardsGet(
      authorization: authHeader,
    );
  }

  Future<Response<ApiCreateCardResponse>> createCard({
    required int bankId,
    required String title,
    required String authHeader,
  }) async {
    return await _apiClint.cardsPost(
      request: ApiCreateCardRequest(
        bankId: bankId,
        title: title,
      ),
      authorization: authHeader,
    );
  }

  Future<Response> deleteCard(
      {required String id, required String authHeader}) async {
    return await _apiClint.cardsIdDelete(
      id: id,
      authorization: authHeader,
    );
  }
}
