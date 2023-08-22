import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> categoriesOfCashback = [
  'Авто',
  'АЗС',
  'Аренда авто',
  'Дом и ремонт',
  'Животные',
  'Здоровье',
  'Кафе и рестораны',
  'Книги',
  'Коммунальные услуги',
  'Красота',
  'Образование',
  'Одежда и обувь',
  'Путешествия',
  'Развлечения',
  'Связь, интернет и ТВ',
  'Спортивные товары',
  'Супермаркеты',
  'Такси',
  'Техника',
  'Транспорт',
  'Фастфуд',
  'Цветы',
  'Цифровые товары',
  'Ювелирные изделия',
];
List<String> countOfCategories = ['1', '2', '3', '4', '5', '6'];

class AddCardPage extends StatefulWidget {
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String _selectedCategory = categoriesOfCashback[3];
  String _selectedCountOfCategory = countOfCategories[3];
  List<String> _selectedCategories = [];
  TextEditingController _cardNameController = TextEditingController();
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавление карты',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _cardNameController,
                  decoration: const InputDecoration(
                    hintText: 'Введите название карты',
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text('Выберите кол-во категорий:'),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        value: _selectedCountOfCategory,
                        items: countOfCategories
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountOfCategory = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: int.parse(_selectedCountOfCategory),
                  itemBuilder: (context, index) {
                    DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      value: _selectedCountOfCategory,
                      items: countOfCategories
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountOfCategory = value!;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
