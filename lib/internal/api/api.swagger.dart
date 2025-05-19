// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'api.enums.swagger.dart' as enums;
export 'api.enums.swagger.dart';

part 'api.swagger.chopper.dart';
part 'api.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Api extends ChopperService {
  static Api create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Api(client);
    }

    final newClient = ChopperClient(
        services: [_$Api()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Api(newClient);
  }

  ///Получение списка банков
  Future<chopper.Response<List<BankBank>>> banksGet() {
    generatedMapping.putIfAbsent(BankBank, () => BankBank.fromJsonFactory);

    return _banksGet();
  }

  ///Получение списка банков
  @Get(path: '/banks')
  Future<chopper.Response<List<BankBank>>> _banksGet();

  ///Список карт пользователя
  Future<chopper.Response<ApiListCardsResponse>> cardsGet(
      {dynamic authorization}) {
    generatedMapping.putIfAbsent(
        ApiListCardsResponse, () => ApiListCardsResponse.fromJsonFactory);

    return _cardsGet(authorization: authorization?.toString());
  }

  ///Список карт пользователя
  @Get(path: '/cards')
  Future<chopper.Response<ApiListCardsResponse>> _cardsGet(
      {@Header('Authorization') String? authorization});

  ///Создает новую карту	пользователя
  ///@param request Create Card Request
  Future<chopper.Response<ApiCreateCardResponse>> cardsPost({
    required ApiCreateCardRequest? request,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(
        ApiCreateCardRequest, () => ApiCreateCardRequest.fromJsonFactory);
    generatedMapping.putIfAbsent(
        ApiCreateCardResponse, () => ApiCreateCardResponse.fromJsonFactory);

    return _cardsPost(
        request: request, authorization: authorization?.toString());
  }

  ///Создает новую карту	пользователя
  ///@param request Create Card Request
  @Post(path: '/cards')
  Future<chopper.Response<ApiCreateCardResponse>> _cardsPost({
    @Body() required ApiCreateCardRequest? request,
    @Header('Authorization') String? authorization,
  });

  ///Удалить карту по ID
  ///@param id Card ID
  Future<chopper.Response> cardsIdDelete({
    required String? id,
    dynamic authorization,
  }) {
    return _cardsIdDelete(id: id, authorization: authorization?.toString());
  }

  ///Удалить карту по ID
  ///@param id Card ID
  @Delete(path: '/cards/{id}')
  Future<chopper.Response> _cardsIdDelete({
    @Path('id') required String? id,
    @Header('Authorization') String? authorization,
  });

  ///Обновление категорий для карты по ID
  ///@param id Card ID
  ///@param request Create Cashbacks Request
  Future<chopper.Response> cardsIdCashbackPut({
    required String? id,
    required ApiUpdateCashbacksRequest? request,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(ApiUpdateCashbacksRequest,
        () => ApiUpdateCashbacksRequest.fromJsonFactory);

    return _cardsIdCashbackPut(
        id: id, request: request, authorization: authorization?.toString());
  }

  ///Обновление категорий для карты по ID
  ///@param id Card ID
  ///@param request Create Cashbacks Request
  @Put(path: '/cards/{id}/cashback')
  Future<chopper.Response> _cardsIdCashbackPut({
    @Path('id') required String? id,
    @Body() required ApiUpdateCashbacksRequest? request,
    @Header('Authorization') String? authorization,
  });

  ///Создание категорий для карты по ID
  ///@param id Card ID
  ///@param request Create Cashbacks Request
  Future<chopper.Response> cardsIdCashbackPost({
    required String? id,
    required ApiCreateCashbacksRequest? request,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(ApiCreateCashbacksRequest,
        () => ApiCreateCashbacksRequest.fromJsonFactory);

    return _cardsIdCashbackPost(
        id: id, request: request, authorization: authorization?.toString());
  }

  ///Создание категорий для карты по ID
  ///@param id Card ID
  ///@param request Create Cashbacks Request
  @Post(path: '/cards/{id}/cashback')
  Future<chopper.Response> _cardsIdCashbackPost({
    @Path('id') required String? id,
    @Body() required ApiCreateCashbacksRequest? request,
    @Header('Authorization') String? authorization,
  });

  ///Получение списка категорий
  ///@param bank-id Bank ID
  Future<chopper.Response<List<CategoryCategory>>> categoriesGet(
      {required int? bankId}) {
    generatedMapping.putIfAbsent(
        CategoryCategory, () => CategoryCategory.fromJsonFactory);

    return _categoriesGet(bankId: bankId);
  }

  ///Получение списка категорий
  ///@param bank-id Bank ID
  @Get(path: '/categories')
  Future<chopper.Response<List<CategoryCategory>>> _categoriesGet(
      {@Query('bank-id') required int? bankId});

  ///Аутентификация пользователя по электронной почте
  ///@param request Email and password
  Future<chopper.Response<UserToken>> emailLoginPost(
      {required RequestEmailLoginRequest? request}) {
    generatedMapping.putIfAbsent(RequestEmailLoginRequest,
        () => RequestEmailLoginRequest.fromJsonFactory);
    generatedMapping.putIfAbsent(UserToken, () => UserToken.fromJsonFactory);

    return _emailLoginPost(request: request);
  }

  ///Аутентификация пользователя по электронной почте
  ///@param request Email and password
  @Post(path: '/email/login')
  Future<chopper.Response<UserToken>> _emailLoginPost(
      {@Body() required RequestEmailLoginRequest? request});

  ///Получение семьи
  ///@param family-id Family ID
  Future<chopper.Response<FamilyFamily>> familiesGet({
    String? familyId,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(
        FamilyFamily, () => FamilyFamily.fromJsonFactory);

    return _familiesGet(
        familyId: familyId, authorization: authorization?.toString());
  }

  ///Получение семьи
  ///@param family-id Family ID
  @Get(path: '/families')
  Future<chopper.Response<FamilyFamily>> _familiesGet({
    @Query('family-id') String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Создание семьи
  ///@param request Create family Request body
  Future<chopper.Response<FamilyFamily>> familiesPost({
    required ApiCreateFamilyRequest? request,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(
        ApiCreateFamilyRequest, () => ApiCreateFamilyRequest.fromJsonFactory);
    generatedMapping.putIfAbsent(
        FamilyFamily, () => FamilyFamily.fromJsonFactory);

    return _familiesPost(
        request: request, authorization: authorization?.toString());
  }

  ///Создание семьи
  ///@param request Create family Request body
  @Post(path: '/families')
  Future<chopper.Response<FamilyFamily>> _familiesPost({
    @Body() required ApiCreateFamilyRequest? request,
    @Header('Authorization') String? authorization,
  });

  ///Получение приглашений
  ///@param family-id Family ID
  Future<chopper.Response<List<InviteFamilyInvite>>> familiesInvitesGet({
    String? familyId,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(
        InviteFamilyInvite, () => InviteFamilyInvite.fromJsonFactory);

    return _familiesInvitesGet(
        familyId: familyId, authorization: authorization?.toString());
  }

  ///Получение приглашений
  ///@param family-id Family ID
  @Get(path: '/families/invites')
  Future<chopper.Response<List<InviteFamilyInvite>>> _familiesInvitesGet({
    @Query('family-id') String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Удаление семьи
  ///@param family-id Family ID
  Future<chopper.Response> familiesFamilyIdDelete({
    required String? familyId,
    dynamic authorization,
  }) {
    return _familiesFamilyIdDelete(
        familyId: familyId, authorization: authorization?.toString());
  }

  ///Удаление семьи
  ///@param family-id Family ID
  @Delete(path: '/families/{family-id}')
  Future<chopper.Response> _familiesFamilyIdDelete({
    @Path('family-id') required String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Создание приглашения в семью
  ///@param request Request body
  ///@param family-id Family ID
  Future<chopper.Response> familiesFamilyIdInvitesPost({
    required ApiCreateFamilyInviteRequest? request,
    required String? familyId,
    dynamic authorization,
  }) {
    generatedMapping.putIfAbsent(ApiCreateFamilyInviteRequest,
        () => ApiCreateFamilyInviteRequest.fromJsonFactory);

    return _familiesFamilyIdInvitesPost(
        request: request,
        familyId: familyId,
        authorization: authorization?.toString());
  }

  ///Создание приглашения в семью
  ///@param request Request body
  ///@param family-id Family ID
  @Post(path: '/families/{family-id}/invites')
  Future<chopper.Response> _familiesFamilyIdInvitesPost({
    @Body() required ApiCreateFamilyInviteRequest? request,
    @Path('family-id') required String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Принятие приглашения
  ///@param family-id Family ID
  Future<chopper.Response> familiesFamilyIdInvitesAcceptPost({
    required String? familyId,
    dynamic authorization,
  }) {
    return _familiesFamilyIdInvitesAcceptPost(
        familyId: familyId, authorization: authorization?.toString());
  }

  ///Принятие приглашения
  ///@param family-id Family ID
  @Post(
    path: '/families/{family-id}/invites/accept',
    optionalBody: true,
  )
  Future<chopper.Response> _familiesFamilyIdInvitesAcceptPost({
    @Path('family-id') required String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Отклонение приглашения
  ///@param family-id Family ID
  Future<chopper.Response> familiesFamilyIdInvitesDeclineDelete({
    required String? familyId,
    dynamic authorization,
  }) {
    return _familiesFamilyIdInvitesDeclineDelete(
        familyId: familyId, authorization: authorization?.toString());
  }

  ///Отклонение приглашения
  ///@param family-id Family ID
  @Delete(path: '/families/{family-id}/invites/decline')
  Future<chopper.Response> _familiesFamilyIdInvitesDeclineDelete({
    @Path('family-id') required String? familyId,
    @Header('Authorization') String? authorization,
  });

  ///Удаление приглашения
  ///@param family-id Family ID
  ///@param invite-id Invite ID
  Future<chopper.Response> familiesFamilyIdInvitesInviteIdDelete({
    required String? familyId,
    required String? inviteId,
    dynamic authorization,
  }) {
    return _familiesFamilyIdInvitesInviteIdDelete(
        familyId: familyId,
        inviteId: inviteId,
        authorization: authorization?.toString());
  }

  ///Удаление приглашения
  ///@param family-id Family ID
  ///@param invite-id Invite ID
  @Delete(path: '/families/{family-id}/invites/{invite-id}')
  Future<chopper.Response> _familiesFamilyIdInvitesInviteIdDelete({
    @Path('family-id') required String? familyId,
    @Path('invite-id') required String? inviteId,
    @Header('Authorization') String? authorization,
  });

  ///Удаление члена семьи
  ///@param family-id Family ID
  ///@param member-id Member ID
  Future<chopper.Response> familiesFamilyIdMembersMemberIdDelete({
    required String? familyId,
    required String? memberId,
    dynamic authorization,
  }) {
    return _familiesFamilyIdMembersMemberIdDelete(
        familyId: familyId,
        memberId: memberId,
        authorization: authorization?.toString());
  }

  ///Удаление члена семьи
  ///@param family-id Family ID
  ///@param member-id Member ID
  @Delete(path: '/families/{family-id}/members/{member-id}')
  Future<chopper.Response> _familiesFamilyIdMembersMemberIdDelete({
    @Path('family-id') required String? familyId,
    @Path('member-id') required String? memberId,
    @Header('Authorization') String? authorization,
  });

  ///Создание нового пользователя
  ///@param user User data
  Future<chopper.Response> usersPost(
      {required RequestCreateUserRequest? user}) {
    generatedMapping.putIfAbsent(RequestCreateUserRequest,
        () => RequestCreateUserRequest.fromJsonFactory);

    return _usersPost(user: user);
  }

  ///Создание нового пользователя
  ///@param user User data
  @Post(path: '/users')
  Future<chopper.Response> _usersPost(
      {@Body() required RequestCreateUserRequest? user});

  ///Получение пользователя по ID
  ///@param id User ID
  Future<chopper.Response<UserUser>> usersIdGet({required String? id}) {
    generatedMapping.putIfAbsent(UserUser, () => UserUser.fromJsonFactory);

    return _usersIdGet(id: id);
  }

  ///Получение пользователя по ID
  ///@param id User ID
  @Get(path: '/users/{id}')
  Future<chopper.Response<UserUser>> _usersIdGet(
      {@Path('id') required String? id});
}

@JsonSerializable(explicitToJson: true)
class ApiCreateCardRequest {
  const ApiCreateCardRequest({
    required this.bankId,
    required this.title,
  });

  factory ApiCreateCardRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateCardRequestFromJson(json);

  static const toJsonFactory = _$ApiCreateCardRequestToJson;
  Map<String, dynamic> toJson() => _$ApiCreateCardRequestToJson(this);

  @JsonKey(name: 'bank_id', includeIfNull: false)
  final int bankId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$ApiCreateCardRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiCreateCardRequest &&
            (identical(other.bankId, bankId) ||
                const DeepCollectionEquality().equals(other.bankId, bankId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bankId) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $ApiCreateCardRequestExtension on ApiCreateCardRequest {
  ApiCreateCardRequest copyWith({int? bankId, String? title}) {
    return ApiCreateCardRequest(
        bankId: bankId ?? this.bankId, title: title ?? this.title);
  }

  ApiCreateCardRequest copyWithWrapped(
      {Wrapped<int>? bankId, Wrapped<String>? title}) {
    return ApiCreateCardRequest(
        bankId: (bankId != null ? bankId.value : this.bankId),
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiCreateCardResponse {
  const ApiCreateCardResponse({
    required this.cardId,
  });

  factory ApiCreateCardResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateCardResponseFromJson(json);

  static const toJsonFactory = _$ApiCreateCardResponseToJson;
  Map<String, dynamic> toJson() => _$ApiCreateCardResponseToJson(this);

  @JsonKey(name: 'card_id', includeIfNull: false)
  final String cardId;
  static const fromJsonFactory = _$ApiCreateCardResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiCreateCardResponse &&
            (identical(other.cardId, cardId) ||
                const DeepCollectionEquality().equals(other.cardId, cardId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cardId) ^ runtimeType.hashCode;
}

extension $ApiCreateCardResponseExtension on ApiCreateCardResponse {
  ApiCreateCardResponse copyWith({String? cardId}) {
    return ApiCreateCardResponse(cardId: cardId ?? this.cardId);
  }

  ApiCreateCardResponse copyWithWrapped({Wrapped<String>? cardId}) {
    return ApiCreateCardResponse(
        cardId: (cardId != null ? cardId.value : this.cardId));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiCreateCashbacksRequest {
  const ApiCreateCashbacksRequest({
    required this.cashbacks,
    required this.categoryIds,
  });

  factory ApiCreateCashbacksRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateCashbacksRequestFromJson(json);

  static const toJsonFactory = _$ApiCreateCashbacksRequestToJson;
  Map<String, dynamic> toJson() => _$ApiCreateCashbacksRequestToJson(this);

  @JsonKey(
      name: 'cashbacks',
      includeIfNull: false,
      defaultValue: <CashbackCashback>[])
  final List<CashbackCashback> cashbacks;
  @JsonKey(name: 'category_ids', includeIfNull: false, defaultValue: <String>[])
  final List<String> categoryIds;
  static const fromJsonFactory = _$ApiCreateCashbacksRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiCreateCashbacksRequest &&
            (identical(other.cashbacks, cashbacks) ||
                const DeepCollectionEquality()
                    .equals(other.cashbacks, cashbacks)) &&
            (identical(other.categoryIds, categoryIds) ||
                const DeepCollectionEquality()
                    .equals(other.categoryIds, categoryIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cashbacks) ^
      const DeepCollectionEquality().hash(categoryIds) ^
      runtimeType.hashCode;
}

extension $ApiCreateCashbacksRequestExtension on ApiCreateCashbacksRequest {
  ApiCreateCashbacksRequest copyWith(
      {List<CashbackCashback>? cashbacks, List<String>? categoryIds}) {
    return ApiCreateCashbacksRequest(
        cashbacks: cashbacks ?? this.cashbacks,
        categoryIds: categoryIds ?? this.categoryIds);
  }

  ApiCreateCashbacksRequest copyWithWrapped(
      {Wrapped<List<CashbackCashback>>? cashbacks,
      Wrapped<List<String>>? categoryIds}) {
    return ApiCreateCashbacksRequest(
        cashbacks: (cashbacks != null ? cashbacks.value : this.cashbacks),
        categoryIds:
            (categoryIds != null ? categoryIds.value : this.categoryIds));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiCreateFamilyInviteRequest {
  const ApiCreateFamilyInviteRequest({
    required this.inviteeId,
  });

  factory ApiCreateFamilyInviteRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateFamilyInviteRequestFromJson(json);

  static const toJsonFactory = _$ApiCreateFamilyInviteRequestToJson;
  Map<String, dynamic> toJson() => _$ApiCreateFamilyInviteRequestToJson(this);

  @JsonKey(name: 'invitee_id', includeIfNull: false)
  final String inviteeId;
  static const fromJsonFactory = _$ApiCreateFamilyInviteRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiCreateFamilyInviteRequest &&
            (identical(other.inviteeId, inviteeId) ||
                const DeepCollectionEquality()
                    .equals(other.inviteeId, inviteeId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(inviteeId) ^ runtimeType.hashCode;
}

extension $ApiCreateFamilyInviteRequestExtension
    on ApiCreateFamilyInviteRequest {
  ApiCreateFamilyInviteRequest copyWith({String? inviteeId}) {
    return ApiCreateFamilyInviteRequest(inviteeId: inviteeId ?? this.inviteeId);
  }

  ApiCreateFamilyInviteRequest copyWithWrapped({Wrapped<String>? inviteeId}) {
    return ApiCreateFamilyInviteRequest(
        inviteeId: (inviteeId != null ? inviteeId.value : this.inviteeId));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiCreateFamilyRequest {
  const ApiCreateFamilyRequest({
    required this.title,
  });

  factory ApiCreateFamilyRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateFamilyRequestFromJson(json);

  static const toJsonFactory = _$ApiCreateFamilyRequestToJson;
  Map<String, dynamic> toJson() => _$ApiCreateFamilyRequestToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$ApiCreateFamilyRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiCreateFamilyRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^ runtimeType.hashCode;
}

extension $ApiCreateFamilyRequestExtension on ApiCreateFamilyRequest {
  ApiCreateFamilyRequest copyWith({String? title}) {
    return ApiCreateFamilyRequest(title: title ?? this.title);
  }

  ApiCreateFamilyRequest copyWithWrapped({Wrapped<String>? title}) {
    return ApiCreateFamilyRequest(
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiListCardsResponse {
  const ApiListCardsResponse({
    required this.familyCards,
    required this.userCards,
  });

  factory ApiListCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiListCardsResponseFromJson(json);

  static const toJsonFactory = _$ApiListCardsResponseToJson;
  Map<String, dynamic> toJson() => _$ApiListCardsResponseToJson(this);

  @JsonKey(
      name: 'family_cards', includeIfNull: false, defaultValue: <CardCard>[])
  final List<CardCard> familyCards;
  @JsonKey(name: 'user_cards', includeIfNull: false, defaultValue: <CardCard>[])
  final List<CardCard> userCards;
  static const fromJsonFactory = _$ApiListCardsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiListCardsResponse &&
            (identical(other.familyCards, familyCards) ||
                const DeepCollectionEquality()
                    .equals(other.familyCards, familyCards)) &&
            (identical(other.userCards, userCards) ||
                const DeepCollectionEquality()
                    .equals(other.userCards, userCards)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(familyCards) ^
      const DeepCollectionEquality().hash(userCards) ^
      runtimeType.hashCode;
}

extension $ApiListCardsResponseExtension on ApiListCardsResponse {
  ApiListCardsResponse copyWith(
      {List<CardCard>? familyCards, List<CardCard>? userCards}) {
    return ApiListCardsResponse(
        familyCards: familyCards ?? this.familyCards,
        userCards: userCards ?? this.userCards);
  }

  ApiListCardsResponse copyWithWrapped(
      {Wrapped<List<CardCard>>? familyCards,
      Wrapped<List<CardCard>>? userCards}) {
    return ApiListCardsResponse(
        familyCards:
            (familyCards != null ? familyCards.value : this.familyCards),
        userCards: (userCards != null ? userCards.value : this.userCards));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiUpdateCashbacksRequest {
  const ApiUpdateCashbacksRequest({
    required this.cashbacks,
    required this.categoryIds,
  });

  factory ApiUpdateCashbacksRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiUpdateCashbacksRequestFromJson(json);

  static const toJsonFactory = _$ApiUpdateCashbacksRequestToJson;
  Map<String, dynamic> toJson() => _$ApiUpdateCashbacksRequestToJson(this);

  @JsonKey(
      name: 'cashbacks',
      includeIfNull: false,
      defaultValue: <CashbackCashback>[])
  final List<CashbackCashback> cashbacks;
  @JsonKey(name: 'category_ids', includeIfNull: false, defaultValue: <String>[])
  final List<String> categoryIds;
  static const fromJsonFactory = _$ApiUpdateCashbacksRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiUpdateCashbacksRequest &&
            (identical(other.cashbacks, cashbacks) ||
                const DeepCollectionEquality()
                    .equals(other.cashbacks, cashbacks)) &&
            (identical(other.categoryIds, categoryIds) ||
                const DeepCollectionEquality()
                    .equals(other.categoryIds, categoryIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cashbacks) ^
      const DeepCollectionEquality().hash(categoryIds) ^
      runtimeType.hashCode;
}

extension $ApiUpdateCashbacksRequestExtension on ApiUpdateCashbacksRequest {
  ApiUpdateCashbacksRequest copyWith(
      {List<CashbackCashback>? cashbacks, List<String>? categoryIds}) {
    return ApiUpdateCashbacksRequest(
        cashbacks: cashbacks ?? this.cashbacks,
        categoryIds: categoryIds ?? this.categoryIds);
  }

  ApiUpdateCashbacksRequest copyWithWrapped(
      {Wrapped<List<CashbackCashback>>? cashbacks,
      Wrapped<List<String>>? categoryIds}) {
    return ApiUpdateCashbacksRequest(
        cashbacks: (cashbacks != null ? cashbacks.value : this.cashbacks),
        categoryIds:
            (categoryIds != null ? categoryIds.value : this.categoryIds));
  }
}

@JsonSerializable(explicitToJson: true)
class BankBank {
  const BankBank({
    required this.id,
    required this.name,
  });

  factory BankBank.fromJson(Map<String, dynamic> json) =>
      _$BankBankFromJson(json);

  static const toJsonFactory = _$BankBankToJson;
  Map<String, dynamic> toJson() => _$BankBankToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$BankBankFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BankBank &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $BankBankExtension on BankBank {
  BankBank copyWith({int? id, String? name}) {
    return BankBank(id: id ?? this.id, name: name ?? this.name);
  }

  BankBank copyWithWrapped({Wrapped<int>? id, Wrapped<String>? name}) {
    return BankBank(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class CardCard {
  const CardCard({
    this.bank,
    required this.categories,
    required this.id,
    required this.lastUpdatedAt,
    required this.title,
  });

  factory CardCard.fromJson(Map<String, dynamic> json) =>
      _$CardCardFromJson(json);

  static const toJsonFactory = _$CardCardToJson;
  Map<String, dynamic> toJson() => _$CardCardToJson(this);

  @JsonKey(name: 'bank', includeIfNull: false)
  final BankBank? bank;
  @JsonKey(
      name: 'categories',
      includeIfNull: false,
      defaultValue: <CategoryCategoryWithCashback>[])
  final List<CategoryCategoryWithCashback> categories;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'last_updated_at', includeIfNull: false)
  final String lastUpdatedAt;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$CardCardFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CardCard &&
            (identical(other.bank, bank) ||
                const DeepCollectionEquality().equals(other.bank, bank)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdatedAt, lastUpdatedAt)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bank) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(lastUpdatedAt) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $CardCardExtension on CardCard {
  CardCard copyWith(
      {BankBank? bank,
      List<CategoryCategoryWithCashback>? categories,
      String? id,
      String? lastUpdatedAt,
      String? title}) {
    return CardCard(
        bank: bank ?? this.bank,
        categories: categories ?? this.categories,
        id: id ?? this.id,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        title: title ?? this.title);
  }

  CardCard copyWithWrapped(
      {Wrapped<BankBank?>? bank,
      Wrapped<List<CategoryCategoryWithCashback>>? categories,
      Wrapped<String>? id,
      Wrapped<String>? lastUpdatedAt,
      Wrapped<String>? title}) {
    return CardCard(
        bank: (bank != null ? bank.value : this.bank),
        categories: (categories != null ? categories.value : this.categories),
        id: (id != null ? id.value : this.id),
        lastUpdatedAt:
            (lastUpdatedAt != null ? lastUpdatedAt.value : this.lastUpdatedAt),
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class CashbackCashback {
  const CashbackCashback({
    this.endDate,
    this.limit,
    required this.percentage,
    this.startDate,
  });

  factory CashbackCashback.fromJson(Map<String, dynamic> json) =>
      _$CashbackCashbackFromJson(json);

  static const toJsonFactory = _$CashbackCashbackToJson;
  Map<String, dynamic> toJson() => _$CashbackCashbackToJson(this);

  @JsonKey(name: 'end_date', includeIfNull: false)
  final String? endDate;
  @JsonKey(name: 'limit', includeIfNull: false)
  final int? limit;
  @JsonKey(name: 'percentage', includeIfNull: false)
  final double percentage;
  @JsonKey(name: 'start_date', includeIfNull: false)
  final String? startDate;
  static const fromJsonFactory = _$CashbackCashbackFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CashbackCashback &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.percentage, percentage) ||
                const DeepCollectionEquality()
                    .equals(other.percentage, percentage)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(percentage) ^
      const DeepCollectionEquality().hash(startDate) ^
      runtimeType.hashCode;
}

extension $CashbackCashbackExtension on CashbackCashback {
  CashbackCashback copyWith(
      {String? endDate, int? limit, double? percentage, String? startDate}) {
    return CashbackCashback(
        endDate: endDate ?? this.endDate,
        limit: limit ?? this.limit,
        percentage: percentage ?? this.percentage,
        startDate: startDate ?? this.startDate);
  }

  CashbackCashback copyWithWrapped(
      {Wrapped<String?>? endDate,
      Wrapped<int?>? limit,
      Wrapped<double>? percentage,
      Wrapped<String?>? startDate}) {
    return CashbackCashback(
        endDate: (endDate != null ? endDate.value : this.endDate),
        limit: (limit != null ? limit.value : this.limit),
        percentage: (percentage != null ? percentage.value : this.percentage),
        startDate: (startDate != null ? startDate.value : this.startDate));
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryCategory {
  const CategoryCategory({
    this.description,
    required this.id,
    required this.mccCodes,
    required this.source,
    required this.title,
  });

  factory CategoryCategory.fromJson(Map<String, dynamic> json) =>
      _$CategoryCategoryFromJson(json);

  static const toJsonFactory = _$CategoryCategoryToJson;
  Map<String, dynamic> toJson() => _$CategoryCategoryToJson(this);

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'mcc_codes', includeIfNull: false, defaultValue: <MccMCC>[])
  final List<MccMCC> mccCodes;
  @JsonKey(
    name: 'source',
    includeIfNull: false,
    toJson: categorySourceToJson,
    fromJson: categorySourceFromJson,
  )
  final enums.CategorySource source;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$CategoryCategoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoryCategory &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mccCodes, mccCodes) ||
                const DeepCollectionEquality()
                    .equals(other.mccCodes, mccCodes)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mccCodes) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $CategoryCategoryExtension on CategoryCategory {
  CategoryCategory copyWith(
      {String? description,
      String? id,
      List<MccMCC>? mccCodes,
      enums.CategorySource? source,
      String? title}) {
    return CategoryCategory(
        description: description ?? this.description,
        id: id ?? this.id,
        mccCodes: mccCodes ?? this.mccCodes,
        source: source ?? this.source,
        title: title ?? this.title);
  }

  CategoryCategory copyWithWrapped(
      {Wrapped<String?>? description,
      Wrapped<String>? id,
      Wrapped<List<MccMCC>>? mccCodes,
      Wrapped<enums.CategorySource>? source,
      Wrapped<String>? title}) {
    return CategoryCategory(
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        mccCodes: (mccCodes != null ? mccCodes.value : this.mccCodes),
        source: (source != null ? source.value : this.source),
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryCategoryWithCashback {
  const CategoryCategoryWithCashback({
    required this.cashback,
    required this.category,
  });

  factory CategoryCategoryWithCashback.fromJson(Map<String, dynamic> json) =>
      _$CategoryCategoryWithCashbackFromJson(json);

  static const toJsonFactory = _$CategoryCategoryWithCashbackToJson;
  Map<String, dynamic> toJson() => _$CategoryCategoryWithCashbackToJson(this);

  @JsonKey(name: 'cashback', includeIfNull: false)
  final CashbackCashback cashback;
  @JsonKey(name: 'category', includeIfNull: false)
  final CategoryCategory category;
  static const fromJsonFactory = _$CategoryCategoryWithCashbackFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoryCategoryWithCashback &&
            (identical(other.cashback, cashback) ||
                const DeepCollectionEquality()
                    .equals(other.cashback, cashback)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cashback) ^
      const DeepCollectionEquality().hash(category) ^
      runtimeType.hashCode;
}

extension $CategoryCategoryWithCashbackExtension
    on CategoryCategoryWithCashback {
  CategoryCategoryWithCashback copyWith(
      {CashbackCashback? cashback, CategoryCategory? category}) {
    return CategoryCategoryWithCashback(
        cashback: cashback ?? this.cashback,
        category: category ?? this.category);
  }

  CategoryCategoryWithCashback copyWithWrapped(
      {Wrapped<CashbackCashback>? cashback,
      Wrapped<CategoryCategory>? category}) {
    return CategoryCategoryWithCashback(
        cashback: (cashback != null ? cashback.value : this.cashback),
        category: (category != null ? category.value : this.category));
  }
}

@JsonSerializable(explicitToJson: true)
class FamilyFamily {
  const FamilyFamily({
    required this.id,
    required this.leader,
    required this.members,
    required this.title,
  });

  factory FamilyFamily.fromJson(Map<String, dynamic> json) =>
      _$FamilyFamilyFromJson(json);

  static const toJsonFactory = _$FamilyFamilyToJson;
  Map<String, dynamic> toJson() => _$FamilyFamilyToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'leader', includeIfNull: false)
  final UserUser leader;
  @JsonKey(name: 'members', includeIfNull: false, defaultValue: <UserUser>[])
  final List<UserUser> members;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$FamilyFamilyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FamilyFamily &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.leader, leader) ||
                const DeepCollectionEquality().equals(other.leader, leader)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality()
                    .equals(other.members, members)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(leader) ^
      const DeepCollectionEquality().hash(members) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $FamilyFamilyExtension on FamilyFamily {
  FamilyFamily copyWith(
      {String? id, UserUser? leader, List<UserUser>? members, String? title}) {
    return FamilyFamily(
        id: id ?? this.id,
        leader: leader ?? this.leader,
        members: members ?? this.members,
        title: title ?? this.title);
  }

  FamilyFamily copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<UserUser>? leader,
      Wrapped<List<UserUser>>? members,
      Wrapped<String>? title}) {
    return FamilyFamily(
        id: (id != null ? id.value : this.id),
        leader: (leader != null ? leader.value : this.leader),
        members: (members != null ? members.value : this.members),
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class InviteFamilyInvite {
  const InviteFamilyInvite({
    required this.family,
    required this.id,
    required this.user,
  });

  factory InviteFamilyInvite.fromJson(Map<String, dynamic> json) =>
      _$InviteFamilyInviteFromJson(json);

  static const toJsonFactory = _$InviteFamilyInviteToJson;
  Map<String, dynamic> toJson() => _$InviteFamilyInviteToJson(this);

  @JsonKey(name: 'family', includeIfNull: false)
  final FamilyFamily family;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'user', includeIfNull: false)
  final UserUser user;
  static const fromJsonFactory = _$InviteFamilyInviteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InviteFamilyInvite &&
            (identical(other.family, family) ||
                const DeepCollectionEquality().equals(other.family, family)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(family) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $InviteFamilyInviteExtension on InviteFamilyInvite {
  InviteFamilyInvite copyWith(
      {FamilyFamily? family, String? id, UserUser? user}) {
    return InviteFamilyInvite(
        family: family ?? this.family,
        id: id ?? this.id,
        user: user ?? this.user);
  }

  InviteFamilyInvite copyWithWrapped(
      {Wrapped<FamilyFamily>? family,
      Wrapped<String>? id,
      Wrapped<UserUser>? user}) {
    return InviteFamilyInvite(
        family: (family != null ? family.value : this.family),
        id: (id != null ? id.value : this.id),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class MccMCC {
  const MccMCC({
    this.description,
    required this.id,
    required this.name,
  });

  factory MccMCC.fromJson(Map<String, dynamic> json) => _$MccMCCFromJson(json);

  static const toJsonFactory = _$MccMCCToJson;
  Map<String, dynamic> toJson() => _$MccMCCToJson(this);

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'id', includeIfNull: false)
  final int id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$MccMCCFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MccMCC &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $MccMCCExtension on MccMCC {
  MccMCC copyWith({String? description, int? id, String? name}) {
    return MccMCC(
        description: description ?? this.description,
        id: id ?? this.id,
        name: name ?? this.name);
  }

  MccMCC copyWithWrapped(
      {Wrapped<String?>? description,
      Wrapped<int>? id,
      Wrapped<String>? name}) {
    return MccMCC(
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class RequestCreateUserRequest {
  const RequestCreateUserRequest({
    required this.email,
    required this.login,
    required this.password,
    this.phone,
  });

  factory RequestCreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestCreateUserRequestFromJson(json);

  static const toJsonFactory = _$RequestCreateUserRequestToJson;
  Map<String, dynamic> toJson() => _$RequestCreateUserRequestToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'login', includeIfNull: false)
  final String login;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  @JsonKey(name: 'phone', includeIfNull: false)
  final String? phone;
  static const fromJsonFactory = _$RequestCreateUserRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestCreateUserRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $RequestCreateUserRequestExtension on RequestCreateUserRequest {
  RequestCreateUserRequest copyWith(
      {String? email, String? login, String? password, String? phone}) {
    return RequestCreateUserRequest(
        email: email ?? this.email,
        login: login ?? this.login,
        password: password ?? this.password,
        phone: phone ?? this.phone);
  }

  RequestCreateUserRequest copyWithWrapped(
      {Wrapped<String>? email,
      Wrapped<String>? login,
      Wrapped<String>? password,
      Wrapped<String?>? phone}) {
    return RequestCreateUserRequest(
        email: (email != null ? email.value : this.email),
        login: (login != null ? login.value : this.login),
        password: (password != null ? password.value : this.password),
        phone: (phone != null ? phone.value : this.phone));
  }
}

@JsonSerializable(explicitToJson: true)
class RequestEmailLoginRequest {
  const RequestEmailLoginRequest({
    required this.email,
    required this.password,
  });

  factory RequestEmailLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestEmailLoginRequestFromJson(json);

  static const toJsonFactory = _$RequestEmailLoginRequestToJson;
  Map<String, dynamic> toJson() => _$RequestEmailLoginRequestToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  static const fromJsonFactory = _$RequestEmailLoginRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestEmailLoginRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $RequestEmailLoginRequestExtension on RequestEmailLoginRequest {
  RequestEmailLoginRequest copyWith({String? email, String? password}) {
    return RequestEmailLoginRequest(
        email: email ?? this.email, password: password ?? this.password);
  }

  RequestEmailLoginRequest copyWithWrapped(
      {Wrapped<String>? email, Wrapped<String>? password}) {
    return RequestEmailLoginRequest(
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class UserToken {
  const UserToken({
    required this.expirationTime,
    required this.token,
    required this.userId,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);

  static const toJsonFactory = _$UserTokenToJson;
  Map<String, dynamic> toJson() => _$UserTokenToJson(this);

  @JsonKey(name: 'expiration_time', includeIfNull: false)
  final String expirationTime;
  @JsonKey(name: 'token', includeIfNull: false)
  final String token;
  @JsonKey(name: 'user_id', includeIfNull: false)
  final String userId;
  static const fromJsonFactory = _$UserTokenFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserToken &&
            (identical(other.expirationTime, expirationTime) ||
                const DeepCollectionEquality()
                    .equals(other.expirationTime, expirationTime)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(expirationTime) ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $UserTokenExtension on UserToken {
  UserToken copyWith({String? expirationTime, String? token, String? userId}) {
    return UserToken(
        expirationTime: expirationTime ?? this.expirationTime,
        token: token ?? this.token,
        userId: userId ?? this.userId);
  }

  UserToken copyWithWrapped(
      {Wrapped<String>? expirationTime,
      Wrapped<String>? token,
      Wrapped<String>? userId}) {
    return UserToken(
        expirationTime: (expirationTime != null
            ? expirationTime.value
            : this.expirationTime),
        token: (token != null ? token.value : this.token),
        userId: (userId != null ? userId.value : this.userId));
  }
}

@JsonSerializable(explicitToJson: true)
class UserUser {
  const UserUser({
    required this.email,
    required this.id,
    required this.login,
    this.phone,
    required this.roleType,
  });

  factory UserUser.fromJson(Map<String, dynamic> json) =>
      _$UserUserFromJson(json);

  static const toJsonFactory = _$UserUserToJson;
  Map<String, dynamic> toJson() => _$UserUserToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'login', includeIfNull: false)
  final String login;
  @JsonKey(name: 'phone', includeIfNull: false)
  final String? phone;
  @JsonKey(
    name: 'role_type',
    includeIfNull: false,
    toJson: userRoleTypeToJson,
    fromJson: userRoleTypeFromJson,
  )
  final enums.UserRoleType roleType;
  static const fromJsonFactory = _$UserUserFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUser &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.roleType, roleType) ||
                const DeepCollectionEquality()
                    .equals(other.roleType, roleType)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(roleType) ^
      runtimeType.hashCode;
}

extension $UserUserExtension on UserUser {
  UserUser copyWith(
      {String? email,
      String? id,
      String? login,
      String? phone,
      enums.UserRoleType? roleType}) {
    return UserUser(
        email: email ?? this.email,
        id: id ?? this.id,
        login: login ?? this.login,
        phone: phone ?? this.phone,
        roleType: roleType ?? this.roleType);
  }

  UserUser copyWithWrapped(
      {Wrapped<String>? email,
      Wrapped<String>? id,
      Wrapped<String>? login,
      Wrapped<String?>? phone,
      Wrapped<enums.UserRoleType>? roleType}) {
    return UserUser(
        email: (email != null ? email.value : this.email),
        id: (id != null ? id.value : this.id),
        login: (login != null ? login.value : this.login),
        phone: (phone != null ? phone.value : this.phone),
        roleType: (roleType != null ? roleType.value : this.roleType));
  }
}

String? categorySourceNullableToJson(enums.CategorySource? categorySource) {
  return categorySource?.value;
}

String? categorySourceToJson(enums.CategorySource categorySource) {
  return categorySource.value;
}

enums.CategorySource categorySourceFromJson(
  Object? categorySource, [
  enums.CategorySource? defaultValue,
]) {
  return enums.CategorySource.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          categorySource?.toString().toLowerCase()) ??
      defaultValue ??
      enums.CategorySource.swaggerGeneratedUnknown;
}

enums.CategorySource? categorySourceNullableFromJson(
  Object? categorySource, [
  enums.CategorySource? defaultValue,
]) {
  if (categorySource == null) {
    return null;
  }
  return enums.CategorySource.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          categorySource.toString().toLowerCase()) ??
      defaultValue;
}

String categorySourceExplodedListToJson(
    List<enums.CategorySource>? categorySource) {
  return categorySource?.map((e) => e.value!).join(',') ?? '';
}

List<String> categorySourceListToJson(
    List<enums.CategorySource>? categorySource) {
  if (categorySource == null) {
    return [];
  }

  return categorySource.map((e) => e.value!).toList();
}

List<enums.CategorySource> categorySourceListFromJson(
  List? categorySource, [
  List<enums.CategorySource>? defaultValue,
]) {
  if (categorySource == null) {
    return defaultValue ?? [];
  }

  return categorySource
      .map((e) => categorySourceFromJson(e.toString()))
      .toList();
}

List<enums.CategorySource>? categorySourceNullableListFromJson(
  List? categorySource, [
  List<enums.CategorySource>? defaultValue,
]) {
  if (categorySource == null) {
    return defaultValue;
  }

  return categorySource
      .map((e) => categorySourceFromJson(e.toString()))
      .toList();
}

String? userRoleTypeNullableToJson(enums.UserRoleType? userRoleType) {
  return userRoleType?.value;
}

String? userRoleTypeToJson(enums.UserRoleType userRoleType) {
  return userRoleType.value;
}

enums.UserRoleType userRoleTypeFromJson(
  Object? userRoleType, [
  enums.UserRoleType? defaultValue,
]) {
  return enums.UserRoleType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          userRoleType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.UserRoleType.swaggerGeneratedUnknown;
}

enums.UserRoleType? userRoleTypeNullableFromJson(
  Object? userRoleType, [
  enums.UserRoleType? defaultValue,
]) {
  if (userRoleType == null) {
    return null;
  }
  return enums.UserRoleType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          userRoleType.toString().toLowerCase()) ??
      defaultValue;
}

String userRoleTypeExplodedListToJson(List<enums.UserRoleType>? userRoleType) {
  return userRoleType?.map((e) => e.value!).join(',') ?? '';
}

List<String> userRoleTypeListToJson(List<enums.UserRoleType>? userRoleType) {
  if (userRoleType == null) {
    return [];
  }

  return userRoleType.map((e) => e.value!).toList();
}

List<enums.UserRoleType> userRoleTypeListFromJson(
  List? userRoleType, [
  List<enums.UserRoleType>? defaultValue,
]) {
  if (userRoleType == null) {
    return defaultValue ?? [];
  }

  return userRoleType.map((e) => userRoleTypeFromJson(e.toString())).toList();
}

List<enums.UserRoleType>? userRoleTypeNullableListFromJson(
  List? userRoleType, [
  List<enums.UserRoleType>? defaultValue,
]) {
  if (userRoleType == null) {
    return defaultValue;
  }

  return userRoleType.map((e) => userRoleTypeFromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
