import 'package:flutter/material.dart';
import '../../topic_list_tile/topic_list.dart';
import '../button_primary/button_primary.dart';
import '../main_title/main_title.dart';

class MyAppBody extends StatelessWidget {
  const MyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
      child: Wrap(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainTitle(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonPrimary("Classes"),
                  ButtonPrimary("Chapitres"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TopicsList(),
            )
          ],
        ),
      ]),
    );
  }
}
