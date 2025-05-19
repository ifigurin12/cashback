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
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        GetIt.I<AuthRepository>(),
        GetIt.I<UserRepository>(),
        GetIt.I<LocalStorageService>(),
      )..add(AuthCheck()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is LoggedIn) {
              return HomePage(
                authHeader: state.authHeader,
                user: state.user,
                authBloc: BlocProvider.of<AuthBloc>(context),
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

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;
  final String authHeader;
  final UserUser user;
  const HomePage(
      {super.key,
      required this.authHeader,
      required this.user,
      required this.authBloc});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardBloc(
            GetIt.I<CardRepository>(),
            widget.authHeader,
          )..add(GetCards()),
        ),
        BlocProvider(
          create: (context) => CashbackBloc(
            GetIt.I<CashbackRepository>(),
            widget.authHeader,
          ),
        )
      ],
      child: Scaffold(
        body: [
          CardPage(),
          ProfilePage(
            user: widget.user,
            authBloc: widget.authBloc,
          ),
        ][_selectedIndex], // Отображаем выбранный виджет
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Карты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final AuthBloc authBloc;
  final UserUser user;

  const ProfilePage({
    super.key,
    required this.user,
    required this.authBloc,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Никнейм'),
              subtitle: Text(user.login),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(user.email),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                authBloc.add(AuthLogout());
              },
              child: const Text('Выйти', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
