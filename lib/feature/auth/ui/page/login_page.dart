import 'package:cashback_info/feature/auth/bloc/auth_bloc.dart';
import 'package:cashback_info/feature/user/ui/page/signup_page.dart';
import 'package:cashback_info/feature/card/ui/page/card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CardPage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Войти')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthLogin(
                          emailController.text,
                          passwordController.text,
                        ),
                      );
                    },
                    child: Text('Вход'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Нет аккаунта? Зарегистрироваться',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
