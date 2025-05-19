part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {
  final List<CardCard>? userCards;
  final List<CardCard>? familyCards;

  const CardLoading({required this.userCards, required this.familyCards});
}

final class CardLoaded extends CardState {
  final List<CardCard> userCards;
  final List<CardCard>? familyCards;

  const CardLoaded({required this.userCards, required this.familyCards});
}

final class CardError extends CardState {
  final String message;
  const CardError({
    required this.message,
  });
}
