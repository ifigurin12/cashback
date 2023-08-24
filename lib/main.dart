import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/ui/add_card_page.dart';
import 'package:cashback_info/ui/home_page.dart';
import 'package:cashback_info/ui/not_found_page.dart';
import 'package:cashback_info/ui/update_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashback_info/bloc/bank_card_bloc.dart';

import 'data_layer/models/cashback.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        initialRoute: HomePage.routeName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomePage(),
              );
            case UpdateCardPage.routeName:
              final arg = settings.arguments as BankCard;
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UpdateCardPage(userCardToUpdate: arg));
            case AddCardPage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider(
                  create: (context) => BankCardBloc(),
                  child: AddCardPage(),
                ),
              );
            case NotFoundPage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NotFoundPage(),
              );
          }
        });
  }
}
