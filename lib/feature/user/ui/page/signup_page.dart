import 'package:cashback_info/feature/auth/ui/page/login_page.dart';
import 'package:cashback_info/feature/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Регистрация')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: loginController,
                decoration: InputDecoration(labelText: 'Login'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(
                    CreateUserEvent(
                      email: emailController.text,
                      login: loginController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                child: Text('Зарегестрироваться'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Text('Уже есть аккаунт? Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
