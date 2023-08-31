import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_card_bloc_event.dart';
part 'delete_card_bloc_state.dart';

class DeleteCardBloc extends Bloc<DeleteCardBlocEvent, DeleteCardBlocState> {
  DeleteCardBloc() : super(DeleteCardBlocInitial()) {
    on<DeleteCardBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
