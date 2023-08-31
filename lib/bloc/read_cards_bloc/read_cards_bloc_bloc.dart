import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:equatable/equatable.dart';

part 'read_cards_bloc_event.dart';
part 'read_cards_bloc_state.dart';

class ReadCardsBloc extends Bloc<ReadCardsBlocEvent, ReadCardsBlocState> {
  final dataBase = DBProvider.db;
  ReadCardsBloc() : super(ReadCardsBlocInitial()) {
    on<ReadCardList>(_onGetCardList);
  }
   _onGetCardList(ReadCardsBlocEvent event, Emitter<ReadCardsBlocState> emit) async {
    emit(ReadCardsBlocLoading());
    final list = await dataBase.getCards();
    if (list.isEmpty) {
      emit(ReadCardsBlocEmpty());
    } 
    else if (list.isNotEmpty){
      emit(ReadCardsBlocSuccess(listCard: list));
    }
    else {
      emit(ReadCardsBlocFailure());
    }
  }
}
