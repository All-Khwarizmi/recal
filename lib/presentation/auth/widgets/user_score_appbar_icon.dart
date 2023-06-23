import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recal_mobile2/core/error/error.dart';
import 'package:recal_mobile2/domain/user/user_repository.dart';

import '../../../injection.dart';

class UserScoreAppBarIcon extends StatelessWidget {
  UserScoreAppBarIcon({
    super.key,
  });
  
  final userRepo = getIt<UserRepository>();

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return StreamBuilder(
        stream: userRepo
            .userScoreStream()
            .getOrElse(() => throw CustomError("Error UserScoreStream")),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 203, 76, 30),
                    child: Text(
                      '$data',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      'xp',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ]));
          } else {
            return const Text("0");
          }
        });
  }
}
