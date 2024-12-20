import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_authenticantion_bloc/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'authentication_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'http://91.108.243.38:8000',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzMzNjA1MjAwLAogICJleHAiOiAxODkxMzcxNjAwCn0.qD36HQGhHGcwd4DhojficJmPFuSeG5rQufe-LVTT90A',
  );
  final SupabaseClient supabase = Supabase.instance.client;

  runApp(
    MultiProvider(
      providers: [
        Provider<SupabaseClient>.value(
          value: supabase,
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(supabase)
            ..add(
              OnStartEvent(),
            ),
        )
      ],
      child: AuthenticationApp(),
    ),
  );
}
