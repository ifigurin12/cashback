import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/models/card.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


part 'bank_card_event.dart';
part 'bank_card_state.dart';

class BankCardBloc extends Bloc<BankCardEvent, BankCardState> {
  BankCardBloc() : super(BankCardInitial()) {
    on<BankCardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
