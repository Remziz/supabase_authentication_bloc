import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_authenticantion_bloc/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Provider.of<SupabaseClient>(context);

    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login_screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Выйти',
            color: Colors.white,
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogOut());
            },
          ),
          title: Text(
            'Личный кабинет',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Твоя почта:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                supabase.auth.currentUser!.email.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
