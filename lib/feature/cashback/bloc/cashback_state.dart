part of 'cashback_bloc.dart';

sealed class CashbackState extends Equatable {
  const CashbackState();

  @override
  List<Object> get props => [];
}

final class CashbackInitial extends CashbackState {}

final class CashbackLoading extends CashbackState {}

final class CashbackSuccess extends CashbackState {}

final class CashbackError extends CashbackState {
  final String message;
  const CashbackError({required this.message});
}
