import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:chopper/chopper.dart';

class CategoryRepository {
  final Api _apiClint;

  CategoryRepository(this._apiClint);

  Future<Response<List<CategoryCategory>>> getCategories({
    required int bankId,
  }) async {
    return await _apiClint.categoriesGet(
      bankId: bankId,
    );
  }
}
