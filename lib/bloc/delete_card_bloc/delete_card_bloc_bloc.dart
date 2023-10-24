import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:equatable/equatable.dart';

part 'delete_card_bloc_event.dart';
part 'delete_card_bloc_state.dart';

class DeleteCardBloc extends Bloc<DeleteCardBlocEvent, DeleteCardBlocState> {
  final dataBase = DBProvider.db;
  DeleteCardBloc() : super(DeleteCardBlocInitial()) {
    on<DeleteCardFromDb> (_onDeleteCard);
  }

  _onDeleteCard(DeleteCardFromDb event, Emitter<DeleteCardBlocState> emit) async {
    emit(DeleteCardBlocWaiting());
    final result = await dataBase.deleteCard(event.props[0] as BankCard);
    if (result == 1) 
    {
      emit(DeleteCardBlocSuccess());
    }
    else {
     emit(DeleteCardBlocFailure());
    }
  } 
}
