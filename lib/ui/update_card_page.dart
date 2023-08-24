import 'package:cashback_info/data_layer/models/card.dart';
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
  'Рестораны',
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

class UpdateCardPage extends StatefulWidget {
  static const String routeName = '/updateCardPage';
  BankCard userCardToUpdate; 

  UpdateCardPage({required this.userCardToUpdate});

  State<UpdateCardPage> createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
  late String _selectedCountOfCategory;
  List<String> _selectedCategories = [];

  TextEditingController _cardNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late BankCard _userCard;

  @override
  void initState() {
    _selectedCategories = List.filled(
        widget.userCardToUpdate.cashbackCategories.length, categoriesOfCashback[0]);

    _userCard = widget.userCardToUpdate;
    _selectedCountOfCategory = _userCard.cashbackCategories.length.toString();
    
    _cardNameController.text = widget.userCardToUpdate.bankName;
    _selectedCategories = _userCard.cashbackCategories
                            .map((e) => e.name)
                            .toList();
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
                      return 'Пожалуйста введие название карты';
                    }
                    return null;
                  }
                ),
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
                            _selectedCategories = List.filled(
                                int.parse(_selectedCountOfCategory),
                                categoriesOfCashback[0]);
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
                          for (int i = 0; i < _selectedCategories.length - 1; i++)
                            // ignore: curly_braces_in_flow_control_structures
                            for (int j = i + 1; j < _selectedCategories.length; j++)
                            {
                              if (_selectedCategories[i] == _selectedCategories[j])  
                              {
                                isUnrepeat = false;
                              }
                            }
                          
                          if (!isUnrepeat)
                          {
                            return 'Выберите разные категории из предложенных';
                          }
                          else 
                          {
                            return null;
                          }
                        },
                        value: _selectedCategories[index],
                        items: categoriesOfCashback
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategories[index] = value!;
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
                        bankName: _cardNameController.text,
                        lastUpdate: DateTime.now(),
                        cashbackCategories: _selectedCategories
                            .map((e) => Cashback(name: e))
                            .toList(),
                      );
                      print(_userCard.toString());
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.green,
                          content: Text(
                            'Регистрация завершена успешно',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
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
