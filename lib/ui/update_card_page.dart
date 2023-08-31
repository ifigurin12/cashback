import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Cashback> categoriesOfCashback = [
  Cashback(id: 0, name: 'Авто'),
  Cashback(id: 1, name: 'АЗС'),
  Cashback(id: 2, name: 'Аренда авто'),
  Cashback(id: 3, name: 'Дом и ремонт'),
  Cashback(id: 4, name: 'Животные'),
  Cashback(id: 5, name: 'Здоровье'),
  Cashback(id: 6, name: 'Кафе и рестораны'),
  Cashback(id: 7, name: 'Книги'),
  Cashback(id: 8, name: 'Коммунальные услуги'),
  Cashback(id: 9, name: 'Красота'),
  Cashback(id: 10, name: 'Образование'),
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
List<String> listOfBank = ['Tinkoff Bank', 'Alpha Bank'];
List<String> countOfCategories = ['1', '2', '3', '4', '5', '6'];

class UpdateCardPage extends StatefulWidget {
  static const String routeName = '/updateCardPage';
  BankCard userCardToUpdate;

  UpdateCardPage({required this.userCardToUpdate});

  State<UpdateCardPage> createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
  late String _selectedCountOfCategory;
  List<Cashback> _selectedCategories = [];
  

  TextEditingController _cardNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late BankCard _userCard;

  @override
  void initState() {
    _selectedCategories = List.filled(
        widget.userCardToUpdate.cashbackCategories.length,
        categoriesOfCashback[0]);

    _userCard = widget.userCardToUpdate;
    _selectedCountOfCategory = _userCard.cashbackCategories.length.toString();

    _cardNameController.text = widget.userCardToUpdate.cardName;
    _selectedCategories = _userCard.cashbackCategories;
    super.initState();
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Обновление карты',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _cardNameController,
                    decoration: const InputDecoration(
                      hintText: 'Введите название карты',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста введите название карты';
                      }
                      return null;
                    }),
               
                 Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text('Выберите кол-во категорий:'),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
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
                            _selectedCategories = List.generate(
                                int.parse(_selectedCountOfCategory), (index) {
                              if (index < _selectedCategories.length) {
                                return _selectedCategories[index];
                              } else {
                                return categoriesOfCashback[0];
                              }
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    late List<DropdownButtonFormField<String>> menuList =
                        List.generate(
                      int.parse(_selectedCountOfCategory),
                      (index) => DropdownButtonFormField<String>(
                        validator: (value) {
                          bool isUnrepeat = true;
                          for (int i = 0;
                              i < _selectedCategories.length - 1;
                              i++)
                            // ignore: curly_braces_in_flow_control_structures
                            for (int j = i + 1;
                                j < _selectedCategories.length;
                                j++) {
                              if (_selectedCategories[i] ==
                                  _selectedCategories[j]) {
                                isUnrepeat = false;
                              }
                            }

                          if (!isUnrepeat) {
                            return 'Выберите разные категории из предложенных';
                          } else {
                            return null;
                          }
                        },
                        value: _selectedCategories[index].name,
                        items: categoriesOfCashback
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e.name,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategories[index] = categoriesOfCashback
                                .firstWhere((element) => element.name == value);
                          });
                        },
                      ),
                    );
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: menuList.length,
                      itemBuilder: (context, index) => menuList[index],
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _userCard = BankCard(
                        id: 0,
                        bankType: widget.userCardToUpdate.bankType,
                        cardName: _cardNameController.text,
                        lastUpdate: DateTime.now(),
                        cashbackCategories: _selectedCategories,
                      );
                      print(_userCard.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.green,
                          content: Text(
                            'Обновление карты выполнено успешно',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                      _formKey.currentState!.save();
                    }
                  },
                  child: Text('Обновить'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
