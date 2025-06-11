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
import 'package:cashback_info/feature/user/bloc/user_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            GetIt.I<AuthRepository>(),
            GetIt.I<UserRepository>(),
            GetIt.I<LocalStorageService>(),
          )..add(AuthCheck()),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            GetIt.I<UserRepository>(),
          ),
        ),
      ],
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
          CardPage(
            isFamilyCards: true,
          ),
          ProfilePage(
            user: widget.user,
            authBloc: widget.authBloc,
          ),
        ][_selectedIndex], // Отображаем выбранный виджет
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Карты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom),
              label: 'Семья',
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
        actions: [
          TextButton(
            onPressed: () {
              authBloc.add(AuthLogout());
            },
            child: const Text('Выйти', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Обо мне',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
            FamilyInvitationsWidget(
              invitations: ['Скворцовы'],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class FamilyInvitationsWidget extends StatelessWidget {
  final List<String> invitations;

  const FamilyInvitationsWidget({super.key, required this.invitations});

  @override
  Widget build(BuildContext context) {
    if (invitations.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Приглашения в семью',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...invitations.map((familyName) => Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.family_restroom, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(familyName,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // принять приглашение
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.redAccent),
                    onPressed: () {
                      // отклонить приглашение
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
