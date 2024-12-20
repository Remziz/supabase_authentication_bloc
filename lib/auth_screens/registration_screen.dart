import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_authenticantion_bloc/bloc/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is SuccessullyRegister) {
          Navigator.of(context).pushReplacementNamed('/main_screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            tooltip: 'Назад',
          ),
          title: Text(
            'Регистрация',
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
              const SizedBox(height: 15),
              CupertinoButton(
                color: Colors.blue,
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        OnRegisterButtonEvent(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                },
              ),
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
