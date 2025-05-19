import 'package:cashback_info/feature/auth/bloc/auth_bloc.dart';
import 'package:cashback_info/feature/auth/data/repository/repository.dart';
import 'package:cashback_info/feature/auth/ui/page/login_page.dart';
import 'package:cashback_info/feature/bank/data/repsoitory/repository.dart';
import 'package:cashback_info/feature/card/bloc/card_bloc.dart';
import 'package:cashback_info/feature/card/data/repository/repository.dart';
import 'package:cashback_info/feature/cashback/bloc/cashback_bloc.dart';
import 'package:cashback_info/feature/cashback/data/repsoitory/repository.dart';
import 'package:cashback_info/feature/category/bloc/category_bloc.dart';
import 'package:cashback_info/feature/category/data/repository/repository.dart';
import 'package:cashback_info/feature/family/data/repository/repository.dart';
import 'package:cashback_info/feature/family_invites/data/repository/repsoitory.dart';
import 'package:cashback_info/feature/user/data/repository/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:cashback_info/internal/service/local_storage.dart';
import 'package:cashback_info/feature/card/ui/page/card_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupDI();

  runApp(MyApp());
}

void setupDI() {
  final getIt = GetIt.I;
  final api = Api.create(
    baseUrl: Uri.parse('http://10.0.2.2:8080/'),
  );
  getIt.registerSingleton<LocalStorageService>(LocalStorageService());
  getIt.registerSingleton<CashbackRepository>(CashbackRepository(api));
  getIt.registerSingleton<CategoryRepository>(CategoryRepository(api));
  getIt.registerSingleton<BankRepository>(BankRepository(api));
  getIt.registerSingleton<AuthRepository>(AuthRepository(api));
  getIt.registerSingleton<CardRepository>(CardRepository(api));
  getIt.registerSingleton<FamilyRepository>(FamilyRepository(api));
  getIt.registerSingleton<FamilyInviteRepository>(FamilyInviteRepository(api));
  getIt.registerSingleton<UserRepository>(UserRepository(api));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              GetIt.I<AuthRepository>(),
              GetIt.I<UserRepository>(),
              GetIt.I<LocalStorageService>(),
            )..add(AuthCheck()),
          ),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) => state is LoggedOut
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                )
              : null,
          builder: (context, state) {
            if (state is AuthLoading) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is LoggedIn) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => CardBloc(
                      GetIt.I<CardRepository>(),
                      state.authHeader,
                    )..add(GetCards()),
                  ),
                  BlocProvider(
                    create: (context) => CashbackBloc(
                      GetIt.I<CashbackRepository>(),
                      state.authHeader,
                    ),
                  ),
                ],
                child: CardPage(),
              );
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
