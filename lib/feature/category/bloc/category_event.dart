part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {
  final int bankID;
  const GetCategoriesEvent(this.bankID);
}
