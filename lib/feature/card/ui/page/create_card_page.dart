import 'package:cashback_info/feature/bank/bloc/bank_bloc.dart';
import 'package:cashback_info/feature/bank/data/repsoitory/repository.dart';
import 'package:cashback_info/feature/card/bloc/card_bloc.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreateCardPage extends StatefulWidget {
  @override
  CreateCardPageState createState() => CreateCardPageState();
}

class CreateCardPageState extends State<CreateCardPage> {
  BankBank? selectedBank;
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardLoaded) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Создать карту'),
        ),
        body: BlocProvider(
          create: (context) => BankBloc(GetIt.I<BankRepository>())
            ..add(
              GetBanksEvent(),
            ),
          child: BlocBuilder<BankBloc, BankState>(
            builder: (context, state) {
              if (state is BankLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Название карты',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButton<BankBank>(
                        value: selectedBank,
                        hint: Text('Выберите банк'),
                        isExpanded: true,
                        items: state.banks.map((BankBank bank) {
                          return DropdownMenuItem<BankBank>(
                            value: bank,
                            child: Text(bank.name),
                          );
                        }).toList(),
                        onChanged: (BankBank? newValue) {
                          setState(() {
                            selectedBank = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Логика для создания карты
                            String title = titleController.text;
                            if (selectedBank != null && title.isNotEmpty) {
                              BlocProvider.of<CardBloc>(context).add(
                                CreateCard(
                                  title: title,
                                  bankId: selectedBank!.id,
                                ),
                              );
                            } else {
                              // Обработка ошибок, если поля не заполнены
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Пожалуйста, заполните все поля')),
                              );
                            }
                          },
                          child: Text('Создать'),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
