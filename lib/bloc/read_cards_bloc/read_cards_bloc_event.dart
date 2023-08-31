part of 'read_cards_bloc_bloc.dart';

sealed class ReadCardsBlocEvent extends Equatable {
  const ReadCardsBlocEvent();

  @override
  List<Object> get props => [];
}

class ReadCardList extends ReadCardsBlocEvent{}
