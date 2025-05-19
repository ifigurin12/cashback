import 'package:cashback_info/feature/card/bloc/card_bloc.dart';
import 'package:cashback_info/feature/cashback/bloc/cashback_bloc.dart';
import 'package:cashback_info/feature/category/bloc/category_bloc.dart';
import 'package:cashback_info/feature/category/data/repository/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UpdateCashbackPage extends StatefulWidget {
  final String cardId;
  final int bankId;

  const UpdateCashbackPage(
      {super.key, required this.cardId, required this.bankId});

  @override
  _UpdateCashbackPageState createState() => _UpdateCashbackPageState();
}

class _UpdateCashbackPageState extends State<UpdateCashbackPage> {
  List<CategoryCategory> _categories = []; // Список категорий
  List<Map<String, dynamic>> _selectedCategoryIDsWithPercentage =
      []; // Список выбранных категорий с процентами

  void _addCategory() {
    setState(() {
      _selectedCategoryIDsWithPercentage.add({
        'id': null,
        'percentage': ''
      }); // Добавляем новую категорию с пустыми значениями
    });
  }

  void _removeCategory(int index) {
    setState(() {
      _selectedCategoryIDsWithPercentage
          .removeAt(index); // Удаляем категорию по индексу
    });
  }

  void _submit() {
    final List<CashbackCashback> cashbacks = [];
    final List<String> categoryIds = [];

    for (final category in _selectedCategoryIDsWithPercentage) {
      final cashbackPercentage = double.tryParse(category['percentage'] ?? '');
      if (cashbackPercentage != null) {
        cashbacks.add(CashbackCashback(
          percentage: cashbackPercentage,
        ));
        categoryIds.add(category['id'].id ?? '');
      }
    }
    BlocProvider.of<CashbackBloc>(context).add(
      UpdateCardCashback(
        cardId: widget.cardId,
        cashbacks: cashbacks,
        categoryIds: categoryIds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashbackBloc, CashbackState>(
      listener: (context, state) {
        if (state is CashbackSuccess) {
          BlocProvider.of<CardBloc>(context).add(GetCards());
          Navigator.of(context).pop();
        }
      },
      child: BlocProvider(
        create: (context) => CategoryBloc(GetIt.I<CategoryRepository>())
          ..add(GetCategoriesEvent(widget.bankId)),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoaded) {
              _categories =
                  state.categories; // Получаем список категорий из состояния
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Обновление категорий'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedCategoryIDsWithPercentage.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<CategoryCategory>(
                                      isExpanded:
                                          true, // Убедитесь, что DropdownButton занимает доступное пространство
                                      hint: Text('Выберите категорию'),
                                      value: _selectedCategoryIDsWithPercentage[
                                          index]['id'],
                                      onChanged: (CategoryCategory? newValue) {
                                        setState(() {
                                          _selectedCategoryIDsWithPercentage[
                                                  index]['id'] =
                                              newValue; // Обновляем ID выбранной категории
                                        });
                                      },
                                      items: _categories.map<
                                              DropdownMenuItem<
                                                  CategoryCategory>>(
                                          (CategoryCategory category) {
                                        return DropdownMenuItem<
                                            CategoryCategory>(
                                          value: category,
                                          child: Text(category
                                              .title), // Отображаем название категории
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Отступ между Dropdown и TextField
                                  Container(
                                    width:
                                        80, // Фиксированная ширина для TextField
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: '%',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCategoryIDsWithPercentage[
                                                  index]['percentage'] =
                                              value; // Обновляем процент
                                        });
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _removeCategory(
                                        index), // Удаляем категорию
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addCategory, // Добавляем новую категорию
                      child: Text('Добавить категорию'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text('Сохранить изменения'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
