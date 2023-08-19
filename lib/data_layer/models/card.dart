class Card {
  String bankName;
  List<int> cashbackCategoriesId = [];
  late DateTime lastUpdate;

  Card({required this.bankName})
  {
    lastUpdate = DateTime.now();
  }

  void getCashbackCategories(List<int> categoriesId) {
    categoriesId.forEach((element) => cashbackCategoriesId.add(element));
  }
}
