import 'package:equatable/equatable.dart';

class Cashback extends Equatable {
  final int id;
  final String name;

  const Cashback({required this.id, required this.name});

  factory Cashback.fromJson(Map<String, dynamic> json) {
    final id = json['category_id'];
    final name = json['category_name'];
    return Cashback(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    final jsonMap = <String, dynamic>{};
    jsonMap['category_id'] = id;
    jsonMap['category_name'] = name;
    return jsonMap;
  }

  static List<Cashback> alphaCategoriesOfCashback = [
    const Cashback(
      id: 0,
      name: 'Авто',
    ),
    Cashback(
      id: 1,
      name: 'АЗС',
    ),
    Cashback(
      id: 2,
      name: 'Аренда авто',
    ),
    Cashback(
      id: 3,
      name: 'Дом и ремонт',
    ),
    Cashback(
      id: 4,
      name: 'Животные',
    ),
    Cashback(
      id: 5,
      name: 'Здоровье',
    ),
    Cashback(id: 6, name: 'Кафе и рестораны'),
    Cashback(
      id: 7,
      name: 'Книги',
    ),
    Cashback(
      id: 8,
      name: 'Коммунальные услуги',
    ),
    Cashback(
      id: 9,
      name: 'Красота',
    ),
    Cashback(
      id: 10,
      name: 'Образование',
    ),
    Cashback(id: 11, name: 'Одежда и обувь'),
    Cashback(id: 12, name: 'Путешествия'),
    Cashback(id: 13, name: 'Развлечения'),
    Cashback(id: 14, name: 'Связь, интернет и ТВ'),
    Cashback(id: 15, name: 'Спортивные товары'),
    Cashback(id: 16, name: 'Супермаркеты'),
    Cashback(id: 17, name: 'Такси'),
    Cashback(id: 18, name: 'Техника'),
    Cashback(id: 19, name: 'Транспорт'),
    Cashback(id: 20, name: 'Фастфуд'),
    Cashback(id: 21, name: 'Цветы'),
    Cashback(id: 22, name: 'Цифровые товары'),
    Cashback(id: 23, name: 'Ювелирные изделия'),
  ];

  static List<Cashback> tinkoffCategoriesOfCashback = [
    Cashback(id: 0, name: 'Duty Free'),
    Cashback(id: 1, name: 'Авиабилеты'),
    Cashback(id: 2, name: 'Автоуслуги'),
    Cashback(id: 3, name: 'Аптеки'),
    Cashback(id: 4, name: 'Аренда авто'),
    Cashback(id: 5, name: 'Детские товары'),
    Cashback(id: 6, name: 'Дом, ремонт'),
    Cashback(id: 7, name: 'Ж/д билеты'),
    Cashback(id: 8, name: 'Животные'),
    Cashback(id: 9, name: 'Искусство'),
    Cashback(id: 10, name: 'Канцтовары'),
    Cashback(id: 11, name: 'Каршеринг'),
    Cashback(id: 12, name: 'Кино'),
    Cashback(id: 13, name: 'Книги'),
    Cashback(id: 14, name: 'Косметика'),
    Cashback(id: 15, name: 'Красота'),
    Cashback(id: 16, name: 'Местный транспорт'),
    Cashback(id: 17, name: 'Музыка'),
    Cashback(id: 18, name: 'Образование'),
    Cashback(id: 19, name: 'Одежда, обувь'),
    Cashback(id: 20, name: 'Платные дороги'),
    Cashback(id: 21, name: 'Развлечения'),
    Cashback(id: 22, name: 'Рестораны'),
    Cashback(id: 23, name: 'Спорттовары'),
    Cashback(id: 24, name: 'Сувениры'),
    Cashback(id: 25, name: 'Супермаркеты'),
    Cashback(id: 26, name: 'Такси'),
    Cashback(id: 27, name: 'Топливо'),
    Cashback(id: 28, name: 'Транспорт'),
    Cashback(id: 29, name: 'Фаст Фуд'),
    Cashback(id: 30, name: 'Фото, Видео'),
    Cashback(id: 31, name: 'Цветы'),
    Cashback(id: 32, name: 'Электроника и техника'),
  ];

  @override
  List<Object?> get props => [id, name];
}
