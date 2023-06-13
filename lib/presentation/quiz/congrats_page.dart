import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/presentation/quiz/quizz_state.dart';
import 'package:recal_mobile2/presentation/shared/error_screen.dart';
import 'package:recal_mobile2/presentation/shared/loading_screen.dart';

class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);

    /// TODO: Transform widget to a future builder to be able to do async http request (quizz done endpoint in quizz state)
    // Map<String, Map> rapport = state.quizzRapport();
    // print(rapport);
    //
    // print(scoreData);
    print('easeFactor in widget ');

    return FutureBuilder<Map<String, Map>>(
        future: state.quizzRapport(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (snapshot.hasData) {
            Map<String, Map> rapport = snapshot.data!;
            Map<String, dynamic> scoreData = state.scoreRapport;
            double score = scoreData.entries.first.value['score'];
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    score >= 5
                        ? Image.network(
                            "https://media.giphy.com/media/l4HodBpDmoMA5p9bG/giphy.gif")
                        : SizedBox(),
                    score >= 4 && score < 5
                        ? Image.network(
                            "https://media.giphy.com/media/7rj2ZgttvgomY/giphy.gif")
                        : SizedBox(),
                    score > 2.5 && score < 4
                        ? Image.network(
                            "https://media.giphy.com/media/QVgCZ7EsgfrB9GLcMa/giphy.gif")
                        : SizedBox(),
                    score < 2.5
                        ? Image.network(
                            "https://media.giphy.com/media/1jkV16ysq9vAFN2hYN/giphy.gif")
                        : SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(children: [
                        Text(
                          "Results",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        ...rapport.entries.map((val) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${val.value['index']}-",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${val.value['question']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                '${val.value["selectedAnswer"]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: val.value["selectedAnswer"] ==
                                          val.value["correctAnswer"]
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              val.value["selectedAnswer"] !=
                                      val.value["correctAnswer"]
                                  ? Text(
                                      "${val.value["correctAnswer"]}",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                      ),
                                    )
                                  : Text(
                                      '+ 1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }).toList()
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ErrorScreen();
          }
        });
  }
}
