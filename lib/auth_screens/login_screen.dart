import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_authenticantion_bloc/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          Navigator.of(context).pushReplacementNamed('/main_screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Авторизация',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Электронная почта:',
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Пароль:',
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/register_screen');
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text('Вы не зарегистрированы?'),
                ),
              ),
              const SizedBox(height: 15),
              CupertinoButton(
                color: Colors.blue,
                child: Text(
                  'Войти',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        OnLoginButtonEvent(
                            email: _emailController.text,
                            password: _passwordController.text),
                      );
                },
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthBlocState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator.adaptive();
                  } else if (state is AuthFailure) {
                    return Center(
                      child: Text(
                        'Произошла ошибка',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
