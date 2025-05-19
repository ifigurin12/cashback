// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCreateCardRequest _$ApiCreateCardRequestFromJson(
        Map<String, dynamic> json) =>
    ApiCreateCardRequest(
      bankId: (json['bank_id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ApiCreateCardRequestToJson(
        ApiCreateCardRequest instance) =>
    <String, dynamic>{
      'bank_id': instance.bankId,
      'title': instance.title,
    };

ApiCreateCardResponse _$ApiCreateCardResponseFromJson(
        Map<String, dynamic> json) =>
    ApiCreateCardResponse(
      cardId: json['card_id'] as String,
    );

Map<String, dynamic> _$ApiCreateCardResponseToJson(
        ApiCreateCardResponse instance) =>
    <String, dynamic>{
      'card_id': instance.cardId,
    };

ApiCreateCashbacksRequest _$ApiCreateCashbacksRequestFromJson(
        Map<String, dynamic> json) =>
    ApiCreateCashbacksRequest(
      cashbacks: (json['cashbacks'] as List<dynamic>?)
              ?.map((e) => CashbackCashback.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      categoryIds: (json['category_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApiCreateCashbacksRequestToJson(
        ApiCreateCashbacksRequest instance) =>
    <String, dynamic>{
      'cashbacks': instance.cashbacks.map((e) => e.toJson()).toList(),
      'category_ids': instance.categoryIds,
    };

ApiCreateFamilyInviteRequest _$ApiCreateFamilyInviteRequestFromJson(
        Map<String, dynamic> json) =>
    ApiCreateFamilyInviteRequest(
      inviteeId: json['invitee_id'] as String,
    );

Map<String, dynamic> _$ApiCreateFamilyInviteRequestToJson(
        ApiCreateFamilyInviteRequest instance) =>
    <String, dynamic>{
      'invitee_id': instance.inviteeId,
    };

ApiCreateFamilyRequest _$ApiCreateFamilyRequestFromJson(
        Map<String, dynamic> json) =>
    ApiCreateFamilyRequest(
      title: json['title'] as String,
    );

Map<String, dynamic> _$ApiCreateFamilyRequestToJson(
        ApiCreateFamilyRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

ApiListCardsResponse _$ApiListCardsResponseFromJson(
        Map<String, dynamic> json) =>
    ApiListCardsResponse(
      familyCards: (json['family_cards'] as List<dynamic>?)
              ?.map((e) => CardCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      userCards: (json['user_cards'] as List<dynamic>?)
              ?.map((e) => CardCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApiListCardsResponseToJson(
        ApiListCardsResponse instance) =>
    <String, dynamic>{
      'family_cards': instance.familyCards.map((e) => e.toJson()).toList(),
      'user_cards': instance.userCards.map((e) => e.toJson()).toList(),
    };

ApiUpdateCashbacksRequest _$ApiUpdateCashbacksRequestFromJson(
        Map<String, dynamic> json) =>
    ApiUpdateCashbacksRequest(
      cashbacks: (json['cashbacks'] as List<dynamic>?)
              ?.map((e) => CashbackCashback.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      categoryIds: (json['category_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApiUpdateCashbacksRequestToJson(
        ApiUpdateCashbacksRequest instance) =>
    <String, dynamic>{
      'cashbacks': instance.cashbacks.map((e) => e.toJson()).toList(),
      'category_ids': instance.categoryIds,
    };

BankBank _$BankBankFromJson(Map<String, dynamic> json) => BankBank(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$BankBankToJson(BankBank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CardCard _$CardCardFromJson(Map<String, dynamic> json) => CardCard(
      bank: json['bank'] == null
          ? null
          : BankBank.fromJson(json['bank'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryCategoryWithCashback.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as String,
      lastUpdatedAt: json['last_updated_at'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CardCardToJson(CardCard instance) => <String, dynamic>{
      if (instance.bank?.toJson() case final value?) 'bank': value,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'last_updated_at': instance.lastUpdatedAt,
      'title': instance.title,
    };

CashbackCashback _$CashbackCashbackFromJson(Map<String, dynamic> json) =>
    CashbackCashback(
      endDate: json['end_date'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      startDate: json['start_date'] as String?,
    );

Map<String, dynamic> _$CashbackCashbackToJson(CashbackCashback instance) =>
    <String, dynamic>{
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.limit case final value?) 'limit': value,
      'percentage': instance.percentage,
      if (instance.startDate case final value?) 'start_date': value,
    };

CategoryCategory _$CategoryCategoryFromJson(Map<String, dynamic> json) =>
    CategoryCategory(
      description: json['description'] as String?,
      id: json['id'] as String,
      mccCodes: (json['mcc_codes'] as List<dynamic>?)
              ?.map((e) => MccMCC.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      source: categorySourceFromJson(json['source']),
      title: json['title'] as String,
    );

Map<String, dynamic> _$CategoryCategoryToJson(CategoryCategory instance) =>
    <String, dynamic>{
      if (instance.description case final value?) 'description': value,
      'id': instance.id,
      'mcc_codes': instance.mccCodes.map((e) => e.toJson()).toList(),
      if (categorySourceToJson(instance.source) case final value?)
        'source': value,
      'title': instance.title,
    };

CategoryCategoryWithCashback _$CategoryCategoryWithCashbackFromJson(
        Map<String, dynamic> json) =>
    CategoryCategoryWithCashback(
      cashback:
          CashbackCashback.fromJson(json['cashback'] as Map<String, dynamic>),
      category:
          CategoryCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryCategoryWithCashbackToJson(
        CategoryCategoryWithCashback instance) =>
    <String, dynamic>{
      'cashback': instance.cashback.toJson(),
      'category': instance.category.toJson(),
    };

FamilyFamily _$FamilyFamilyFromJson(Map<String, dynamic> json) => FamilyFamily(
      id: json['id'] as String,
      leader: UserUser.fromJson(json['leader'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => UserUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      title: json['title'] as String,
    );

Map<String, dynamic> _$FamilyFamilyToJson(FamilyFamily instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leader': instance.leader.toJson(),
      'members': instance.members.map((e) => e.toJson()).toList(),
      'title': instance.title,
    };

InviteFamilyInvite _$InviteFamilyInviteFromJson(Map<String, dynamic> json) =>
    InviteFamilyInvite(
      family: FamilyFamily.fromJson(json['family'] as Map<String, dynamic>),
      id: json['id'] as String,
      user: UserUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteFamilyInviteToJson(InviteFamilyInvite instance) =>
    <String, dynamic>{
      'family': instance.family.toJson(),
      'id': instance.id,
      'user': instance.user.toJson(),
    };

MccMCC _$MccMCCFromJson(Map<String, dynamic> json) => MccMCC(
      description: json['description'] as String?,
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$MccMCCToJson(MccMCC instance) => <String, dynamic>{
      if (instance.description case final value?) 'description': value,
      'id': instance.id,
      'name': instance.name,
    };

RequestCreateUserRequest _$RequestCreateUserRequestFromJson(
        Map<String, dynamic> json) =>
    RequestCreateUserRequest(
      email: json['email'] as String,
      login: json['login'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$RequestCreateUserRequestToJson(
        RequestCreateUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'login': instance.login,
      'password': instance.password,
      if (instance.phone case final value?) 'phone': value,
    };

RequestEmailLoginRequest _$RequestEmailLoginRequestFromJson(
        Map<String, dynamic> json) =>
    RequestEmailLoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RequestEmailLoginRequestToJson(
        RequestEmailLoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UserToken _$UserTokenFromJson(Map<String, dynamic> json) => UserToken(
      expirationTime: json['expiration_time'] as String,
      token: json['token'] as String,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$UserTokenToJson(UserToken instance) => <String, dynamic>{
      'expiration_time': instance.expirationTime,
      'token': instance.token,
      'user_id': instance.userId,
    };

UserUser _$UserUserFromJson(Map<String, dynamic> json) => UserUser(
      email: json['email'] as String,
      id: json['id'] as String,
      login: json['login'] as String,
      phone: json['phone'] as String?,
      roleType: userRoleTypeFromJson(json['role_type']),
    );

Map<String, dynamic> _$UserUserToJson(UserUser instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'login': instance.login,
      if (instance.phone case final value?) 'phone': value,
      if (userRoleTypeToJson(instance.roleType) case final value?)
        'role_type': value,
    };
