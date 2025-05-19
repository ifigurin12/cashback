import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/cashback/data/repsoitory/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:equatable/equatable.dart';

part 'cashback_event.dart';
part 'cashback_state.dart';

class CashbackBloc extends Bloc<CashbackEvent, CashbackState> {
  final CashbackRepository _repo;
  final String _authHeader;

  CashbackBloc(this._repo, this._authHeader) : super(CashbackInitial()) {
    on<CreateCardCashback>((event, emit) async {
      emit(CashbackLoading());

      final response = await _repo.createCardsCashback(
        cardId: event.cardId,
        categoryIds: event.categoryIds,
        cashbacks: event.cashbacks,
        authHeader: _authHeader,
      );

      if (!response.isSuccessful) {
        emit(CashbackError(message: response.bodyString));
        return;
      }

      emit(CashbackSuccess());
    });

    on<UpdateCardCashback>((event, emit) async {
      emit(CashbackLoading());

      final response = await _repo.updateCardsCashback(
        cardId: event.cardId,
        categoryIds: event.categoryIds,
        cashbacks: event.cashbacks,
        authHeader: _authHeader,
      );

      if (!response.isSuccessful) {
        emit(CashbackError(message: response.bodyString));
        return;
      }

      emit(CashbackSuccess());
    });
  }
}
