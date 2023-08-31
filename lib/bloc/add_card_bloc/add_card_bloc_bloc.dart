import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:equatable/equatable.dart';

part 'add_card_bloc_event.dart';
part 'add_card_bloc_state.dart';

class AddCardBloc extends Bloc<AddCardBlocEvent, AddCardBlocState> {
  final dataBase = DBProvider.db;
  AddCardBloc() : super(AddCardBlocInitial()) {
    on<AddCardToDb>(_onAddCard);
  }

  _onAddCard(AddCardBlocEvent event, Emitter<AddCardBlocState> emit) async {
    emit(AddCardBlocLoading());
    final id = await dataBase.insertCard(event.props[0] as BankCard);
    if (id == -1) {
      emit(AddCardBlocFailure());
    } else {
      emit(AddCardBlocSuccess());
    }
  }
}
