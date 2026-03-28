import 'package:fintrack/presentation/screens/dashboard/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_theme.dart';
import 'core/injection.dart';
import 'core/routes.dart';

class FinTrackApp extends StatelessWidget {
  const FinTrackApp({super.key, required this.injector});

  final Injector injector;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.getIt.get<TransactionBloc>(),
      child: MaterialApp(
        title: 'FinTrack',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        theme: AppTheme.darkTheme,
        onGenerateRoute: (settings) => Routes.router(settings, injector),
      ),
    );
  }
}
