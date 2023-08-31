part of 'update_card_bloc_bloc.dart';

sealed class UpdateCardBlocState extends Equatable {
  const UpdateCardBlocState();
  
  @override
  List<Object> get props => [];
}

final class UpdateCardBlocInitial extends UpdateCardBlocState {}
final class UpdateCardBlocLoading extends UpdateCardBlocState {}
final class UpdateCardBlocSuccess extends UpdateCardBlocState {}
final class UpdateCardBlocFailure extends UpdateCardBlocState {}