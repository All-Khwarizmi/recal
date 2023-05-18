import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/app_bar.dart';

import '../services/local_notifications/notification_service.dart';
import '../shared/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.setup();

    const recalTheme = RecalTheme();

    
    return HomeScaffold(
      recalTheme: recalTheme,
      service: service,
    );
  }
}
