import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:recal_mobile2/core/error/error.dart';
import 'package:recal_mobile2/domain/user/user_repository.dart';

import '../../../injection.dart';

class UserScoreAppBarIcon extends StatefulWidget {
  const UserScoreAppBarIcon({
    super.key,
  });

  @override
  State<UserScoreAppBarIcon> createState() => _UserScoreAppBarIconState();
}

class _UserScoreAppBarIconState extends State<UserScoreAppBarIcon> {
  double _opacity = 0.0;
  final userScoreStream = getIt<UserRepository>()
      .userScoreStream()
      .getOrElse(() => throw CustomError("Error UserScoreStream"));
  late Timer timer;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      timer = Timer(
        const Duration(seconds: 1),
        () {
          setState(() {
            _opacity = 1;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return StreamBuilder(
        stream: userScoreStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return AnimatedScale(
              scale: _opacity,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 3),
                            blurRadius: 20,
                            blurStyle: BlurStyle.inner,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 203, 76, 30),
                        child: Text(
                          '$data',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
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
                  ],
                ),
              ),
            );
          } else {
            return const Text("0");
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
