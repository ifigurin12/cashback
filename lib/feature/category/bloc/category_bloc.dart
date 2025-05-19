import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/category/data/repository/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryCategory>? _categories;
  final CategoryRepository _repo;

  CategoryBloc(this._repo) : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(
        CategoryLoading(
          categories: _categories,
        ),
      );

      if (_categories != null) {
        _categories!.clear();
      } else {
        _categories = [];
      }

      final response = await _repo.getCategories(bankId: event.bankID);

      if (response.statusCode == 200) {
        _categories = response.body;
        emit(CategoryLoaded(categories: _categories!));
      } else {
        emit(
          CategoryError(
            message: response.body.toString(),
          ),
        );
      }
    });
  }
}
