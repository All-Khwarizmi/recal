import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/injection.dart';
import 'package:recal_mobile2/presentation/core/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);

  runApp(AppWidget());
}
