part of 'cashback_bloc.dart';

sealed class CashbackEvent extends Equatable {
  const CashbackEvent();

  @override
  List<Object> get props => [];
}

class CreateCardCashback extends CashbackEvent {
  final String cardId;
  final List<CashbackCashback> cashbacks;
  final List<String> categoryIds;

  const CreateCardCashback({
    required this.cardId,
    required this.cashbacks,
    required this.categoryIds,
  });
}

class UpdateCardCashback extends CashbackEvent {
  final String cardId;
  final List<CashbackCashback> cashbacks;
  final List<String> categoryIds;

  const UpdateCardCashback({
    required this.cardId,
    required this.cashbacks,
    required this.categoryIds,
  });
}
