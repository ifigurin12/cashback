part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class GetCards extends CardEvent {}

class CreateCard extends CardEvent {
  final int bankId;
  final String title;

  const CreateCard({required this.bankId, required this.title});
}

class DeleteCard extends CardEvent {
  final String id;
  const DeleteCard({required this.id});
}
