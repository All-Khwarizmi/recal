import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import '../shared/theme.dart';
import 'body.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold({
    super.key,
    required this.recalTheme,
  });

  final RecalTheme recalTheme;
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
            print(snapshot.data!["userId"]);
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Recal",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                    actions: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 203, 76, 30),
                              child: Text(
                                '${snapshot.data!['userScore']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
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
                          ])),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 203, 76, 30),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                FirestoreService().updateUserScore(
                                    30); //appState.createTopicSync("whatever sync");
                                /* showModalBottomSheet(
                                    context: context,
                                    builder: ((context) {
                                      return FormInModal();
                                    }));
                                print("Add"); */
                              },
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 203, 76, 30),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.arrowRightFromBracket,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                //appState.createTopicSync("whatever sync");
                                AuthService().signOut();
                                print("Signout");
                              },
                            ),
                          )),
                    ]),
                body: MyAppBody());
          } else {
            return Scaffold();
          }
        });
  }
}
