part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {
  final List<CategoryCategory>? categories;

  const CategoryLoading({required this.categories});
}

final class CategoryLoaded extends CategoryState {
  final List<CategoryCategory> categories;

  const CategoryLoaded({required this.categories});
}

final class CategoryError extends CategoryState {
  final String message;

  const CategoryError({
    required this.message,
  });
}
