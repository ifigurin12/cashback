part of 'read_cards_bloc_bloc.dart';

sealed class ReadCardsBlocEvent extends Equatable {
  const ReadCardsBlocEvent();

  @override
  List<Object> get props => [];
}

class ReadCardList extends ReadCardsBlocEvent {}

class ReadCardListWithFilter extends ReadCardsBlocEvent {
  final List<Cashback> tinkoffCashback;
  final List<Cashback> alphaCashback;

  ReadCardListWithFilter(
      {required this.tinkoffCashback, required this.alphaCashback});
  
  @override 
  List<Object> get props => [tinkoffCashback, alphaCashback];
}
