import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/bank/data/repsoitory/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:equatable/equatable.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final BankRepository _repo;
  List<BankBank>? _banks;
  BankBloc(this._repo) : super(BankInitial()) {
    on<GetBanksEvent>((event, emit) async {
      emit(
        BankLoading(
          banks: _banks,
        ),
      );

      if (_banks != null) {
        _banks!.clear();
      } else {
        _banks = [];
      }

      final response = await _repo.getBanks();

      if (response.statusCode == 200) {
        _banks = response.body;
        emit(BankLoaded(banks: _banks!));
      } else {
        emit(
          BankError(
            message: response.body.toString(),
          ),
        );
      }
    });
  }
}
