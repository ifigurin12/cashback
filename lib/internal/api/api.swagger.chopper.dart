// dart format width=80
//Generated code

part of 'api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Api extends Api {
  _$Api([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Api;

  @override
  Future<Response<List<BankBank>>> _banksGet() {
    final Uri $url = Uri.parse('/banks');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<BankBank>, BankBank>($request);
  }

  @override
  Future<Response<ApiListCardsResponse>> _cardsGet({String? authorization}) {
    final Uri $url = Uri.parse('/cards');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ApiListCardsResponse, ApiListCardsResponse>($request);
  }

  @override
  Future<Response<ApiCreateCardResponse>> _cardsPost({
    required ApiCreateCardRequest? request,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/cards');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ApiCreateCardResponse, ApiCreateCardResponse>($request);
  }

  @override
  Future<Response<dynamic>> _cardsIdDelete({
    required String? id,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/cards/${id}');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cardsIdCashbackPut({
    required String? id,
    required ApiUpdateCashbacksRequest? request,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/cards/${id}/cashback');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cardsIdCashbackPost({
    required String? id,
    required ApiCreateCashbacksRequest? request,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/cards/${id}/cashback');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CategoryCategory>>> _categoriesGet(
      {required int? bankId}) {
    final Uri $url = Uri.parse('/categories');
    final Map<String, dynamic> $params = <String, dynamic>{'bank-id': bankId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<CategoryCategory>, CategoryCategory>($request);
  }

  @override
  Future<Response<UserToken>> _emailLoginPost(
      {required RequestEmailLoginRequest? request}) {
    final Uri $url = Uri.parse('/email/login');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserToken, UserToken>($request);
  }

  @override
  Future<Response<FamilyFamily>> _familiesGet({
    String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families');
    final Map<String, dynamic> $params = <String, dynamic>{
      'family-id': familyId
    };
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<FamilyFamily, FamilyFamily>($request);
  }

  @override
  Future<Response<FamilyFamily>> _familiesPost({
    required ApiCreateFamilyRequest? request,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<FamilyFamily, FamilyFamily>($request);
  }

  @override
  Future<Response<List<InviteFamilyInvite>>> _familiesInvitesGet({
    String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/invites');
    final Map<String, dynamic> $params = <String, dynamic>{
      'family-id': familyId
    };
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<InviteFamilyInvite>, InviteFamilyInvite>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdDelete({
    required String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdInvitesPost({
    required ApiCreateFamilyInviteRequest? request,
    required String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}/invites');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdInvitesAcceptPost({
    required String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}/invites/accept');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdInvitesDeclineDelete({
    required String? familyId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}/invites/decline');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdInvitesInviteIdDelete({
    required String? familyId,
    required String? inviteId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}/invites/${inviteId}');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _familiesFamilyIdMembersMemberIdDelete({
    required String? familyId,
    required String? memberId,
    String? authorization,
  }) {
    final Uri $url = Uri.parse('/families/${familyId}/members/${memberId}');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersPost(
      {required RequestCreateUserRequest? user}) {
    final Uri $url = Uri.parse('/users');
    final $body = user;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserUser>> _usersIdGet({required String? id}) {
    final Uri $url = Uri.parse('/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUser, UserUser>($request);
  }
}
