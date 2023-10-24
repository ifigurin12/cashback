part of 'read_cards_bloc_bloc.dart';

sealed class ReadCardsBlocState extends Equatable {
  const ReadCardsBlocState();
  
  @override
  List<Object> get props => [];
}

final class ReadCardsBlocInitial extends ReadCardsBlocState {}

final class ReadCardsBlocLoading extends ReadCardsBlocState {}

final class ReadCardsBlocSuccess extends ReadCardsBlocState {
  final List<BankCard> listCard;

  const ReadCardsBlocSuccess({required this.listCard});
  @override
  List<Object> get props => [listCard];
}

final class ReadCardsBlocEmpty extends ReadCardsBlocState {}

final class ReadCardsBlocFailure extends ReadCardsBlocState {}
