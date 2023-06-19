import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScoreAppBarIcon extends StatelessWidget {
  UserScoreAppBarIcon({
    super.key,
  });
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _user = FirebaseFirestore
      .instance
      .collection('users')
      .doc(
          "elgQ5rs8zki3kpBuy0-nNz:APA91bGatiFTI_lnYlTrwXwS1liRfTCwEDzZY47_4SjlhMw40sTik8KQro9wQl4woDK1ZTOgCzAobwzBuao3CsoQuyEsPtc138MxopK6tJRAUtg2-nASekevY1_jQV0TzidMU6cEFIB-")
      .snapshots();
      

  @override
  Widget build(BuildContext context) {
    
    ScaffoldMessenger.of(context).clearSnackBars();
    return StreamBuilder(
        stream: _user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Stack(children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 203, 76, 30),
                    child: Text(
                      '${data!['userScore']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Positioned(
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
            return Text("0");
          }
        });
  }
}
