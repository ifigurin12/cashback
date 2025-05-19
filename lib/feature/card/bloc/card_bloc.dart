import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/card/data/repository/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:equatable/equatable.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _repo;
  final String _authHeader;
  List<CardCard>? _userCards;
  List<CardCard>? _familyCards;

  CardBloc(this._repo, this._authHeader) : super(CardInitial()) {
    on<GetCards>(
      (event, emit) async {
        emit(CardLoading(userCards: _userCards, familyCards: _familyCards));

        final response = await _repo.getCards(authHeader: _authHeader);

        if (response.isSuccessful) {
          _userCards = response.body?.userCards ?? [];
          _familyCards = response.body?.familyCards ?? [];
          emit(CardLoaded(userCards: _userCards!, familyCards: _familyCards!));
        } else {
          final message = response.body.toString();
          emit(CardError(
            message: message,
          ));
        }
      },
    );
    on<CreateCard>(
      (event, emit) async {
        emit(CardLoading(userCards: _userCards, familyCards: _familyCards));

        final response = await _repo.createCard(
          bankId: event.bankId,
          title: event.title,
          authHeader: _authHeader,
        );

        if (response.isSuccessful) {
          add(GetCards());
        } else {
          final message = response.body.toString();
          emit(CardError(message: message));
        }
      },
    );
    on<DeleteCard>(
      (event, emit) async {
        emit(CardLoading(userCards: _userCards, familyCards: _familyCards));

        final response = await _repo.deleteCard(
          id: event.id,
          authHeader: _authHeader,
        );

        if (response.isSuccessful) {
          add(GetCards());
        } else {
          final message = response.body.toString();
          emit(CardError(message: message));
        }
      },
    );
  }
}
