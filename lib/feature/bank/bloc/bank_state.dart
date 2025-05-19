part of 'bank_bloc.dart';

sealed class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

final class BankInitial extends BankState {}

final class BankLoading extends BankState {
  final List<BankBank>? banks;
  const BankLoading({required this.banks});
}

final class BankLoaded extends BankState {
  final List<BankBank> banks;
  const BankLoaded({required this.banks});
}

final class BankError extends BankState {
  final String message;
  const BankError({required this.message});
}
