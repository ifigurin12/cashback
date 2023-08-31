part of 'update_card_bloc_bloc.dart';

sealed class UpdateCardBlocState extends Equatable {
  const UpdateCardBlocState();
  
  @override
  List<Object> get props => [];
}

final class UpdateCardBlocInitial extends UpdateCardBlocState {}
