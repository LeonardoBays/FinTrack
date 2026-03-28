import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR');

  final injector = await InjectorImpl.initializeDependencies();

  runApp(FinTrackApp(injector: injector));
}
