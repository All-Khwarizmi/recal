import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/firebase_options.dart';
import 'package:recal_mobile2/injection.dart';
import 'package:recal_mobile2/presentation/core/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureInjection(Environment.prod);
  // await configureDependencies();

  runApp(AppWidget());
}
