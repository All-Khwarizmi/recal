import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/shared/temp_scaffold.dart';
import 'package:recal_mobile2/home/app_bar.dart';

import '../services/local_notifications/notification_service.dart';
import '../providers/firestore_state/fire_state.dart';
import '../shared/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.setup();

    const recalTheme = RecalTheme();

    var fireState = context.watch<FireState>();
    return HomeScaffold(
      recalTheme: recalTheme,
      fireState: fireState,
      service: service,
    );
  }
}
