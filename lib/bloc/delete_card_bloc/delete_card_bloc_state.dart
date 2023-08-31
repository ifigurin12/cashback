part of 'delete_card_bloc_bloc.dart';

sealed class DeleteCardBlocState extends Equatable {
  const DeleteCardBlocState();
  
  @override
  List<Object> get props => [];
}

final class DeleteCardBlocInitial extends DeleteCardBlocState {}
final class DeleteCardBlocFailure extends DeleteCardBlocState {}
final class DeleteCardBlocSuccess extends DeleteCardBlocState {}
final class DeleteCardBlocWaiting extends DeleteCardBlocState {}
