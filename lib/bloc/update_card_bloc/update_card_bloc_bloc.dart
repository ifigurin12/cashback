import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:equatable/equatable.dart';

part 'update_card_bloc_event.dart';
part 'update_card_bloc_state.dart';

class UpdateCardBloc extends Bloc<UpdateCardBlocEvent, UpdateCardBlocState> {
  final dataBase = DBProvider.db;
  UpdateCardBloc() : super(UpdateCardBlocInitial()) {
    on<UpdateCardOnDb> (_onUpdateCardOnDb);
  }

  _onUpdateCardOnDb(UpdateCardOnDb event, Emitter<UpdateCardBlocState> emit) async {
    emit(UpdateCardBlocLoading());
    final countOfUpdate = await dataBase.updateCard(event.userCard);
    if (countOfUpdate == 1) 
    {
      emit(UpdateCardBlocSuccess());
    }
    else 
    {
      emit(UpdateCardBlocFailure());
    }
  }
}
