import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class FamilyRepository {
  final Api _apiClint;

  FamilyRepository(this._apiClint);

  Future<Response<FamilyFamily>> getFamily({
    required String? familyId,
    required String authHeader,
  }) async {
    return await _apiClint.familiesGet(
      familyId: familyId,
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> createFamily({
    required String title,
    required String authHeader,
  }) async {
    return await _apiClint.familiesPost(
      request: ApiCreateFamilyRequest(
        title: title,
      ),
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> deleteFamily({
    required String familyId,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdDelete(
      familyId: familyId,
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> deleteFamilyMember({
    required String familyId,
    required String memberID,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdMembersMemberIdDelete(
      familyId: familyId,
      memberId: memberID,
      authorization: authHeader,
    );
  }
}
