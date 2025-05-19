import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class FamilyInviteRepository {
  final Api _apiClint;

  FamilyInviteRepository(this._apiClint);

  Future<Response<List<InviteFamilyInvite>>> getFamilyInvites({
    required String? familyId,
    required String authHeader,
  }) async {
    return await _apiClint.familiesInvitesGet(
      familyId: familyId,
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> createFamilyInvite({
    required String familyId,
    required String inviteeID,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdInvitesPost(
      familyId: familyId,
      request: ApiCreateFamilyInviteRequest(
        inviteeId: inviteeID,
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

  Future<Response<dynamic>> acceptInvite({
    required String familyId,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdInvitesAcceptPost(
      familyId: familyId,
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> declineInvite({
    required String familyId,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdInvitesDeclineDelete(
      familyId: familyId,
      authorization: authHeader,
    );
  }

  Future<Response<dynamic>> deleteFamilyInvite({
    required String familyId,
    required String inviteID,
    required String authHeader,
  }) async {
    return await _apiClint.familiesFamilyIdInvitesInviteIdDelete(
      familyId: familyId,
      inviteId: inviteID,
      authorization: authHeader,
    );
  }
}
