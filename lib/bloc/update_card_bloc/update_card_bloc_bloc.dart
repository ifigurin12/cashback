import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_card_bloc_event.dart';
part 'update_card_bloc_state.dart';

class UpdateCardBlocBloc extends Bloc<UpdateCardBlocEvent, UpdateCardBlocState> {
  UpdateCardBlocBloc() : super(UpdateCardBlocInitial()) {
    on<UpdateCardBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
