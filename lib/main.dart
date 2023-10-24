import 'package:cashback_info/bloc/add_card_bloc/add_card_bloc_bloc.dart';
import 'package:cashback_info/bloc/delete_card_bloc/delete_card_bloc_bloc.dart';
import 'package:cashback_info/bloc/read_cards_bloc/read_cards_bloc_bloc.dart';
import 'package:cashback_info/bloc/update_card_bloc/update_card_bloc_bloc.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/ui/add_card_page.dart';
import 'package:cashback_info/ui/home_page.dart';
import 'package:cashback_info/ui/not_found_page.dart';
import 'package:cashback_info/ui/update_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
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
                    MultiBlocProvider(
                  providers: [
                    BlocProvider<ReadCardsBloc>(
                      create: (context) {
                        ReadCardsBloc readCardsBloc = ReadCardsBloc();
                        readCardsBloc.add(ReadCardList());
                        return readCardsBloc;
                      },
                    ),
                    BlocProvider<DeleteCardBloc>(
                      create: (context) {
                        DeleteCardBloc deleteCardsBloc = DeleteCardBloc();
                        return deleteCardsBloc;
                      },
                    ),
                  ],
                  child: HomePage(),
                ),
              );
            case UpdateCardPage.routeName:
              final card = settings.arguments as BankCard;
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BlocProvider(
                        create: (context) => UpdateCardBloc(),
                        child: UpdateCardPage(userCardToUpdate: card),
                      ));
            case AddCardPage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider<AddCardBloc>(
                        create: (context) => AddCardBloc(),
                        child: AddCardPage()),
              );
            case NotFoundPage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NotFoundPage(),
              );
          }
          return null;
        });
  }
}
