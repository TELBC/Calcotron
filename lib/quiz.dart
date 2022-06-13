import 'dart:math';

import 'package:calcotron/Database.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  Quiz({Key? key, required this.qna}) : super(key: key);

  final List<QnA> qna;

  @override
  State<Quiz> createState() => _QuizRedirect();
}

class _QuizRedirect extends State<Quiz> {
  final textfieldController = TextEditingController();
  int id = 0;
  int lastId = 0;
  String outcome = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black12,
        ),
        scaffoldBackgroundColor: Colors.white10,
        hintColor: Colors.white38,
        textTheme: Theme.of(context).textTheme.copyWith(
              headline6: const TextStyle(color: Colors.white, fontSize: 18),
            ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent)),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.greenAccent,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          title: Text("Quiz"),
          backgroundColor: Colors.black26,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.greenAccent,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      DefaultTextStyle(
                        child: Text(
                          widget.qna[id].question,
                        ),
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward_ios),
                          Flexible(
                            child: TextField(
                              controller: textfieldController,
                              decoration: const InputDecoration(
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.greenAccent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.greenAccent),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: Colors.greenAccent,
                            onPressed: () {
                              shuffle(textfieldController.text
                                  .toString()
                                  .toLowerCase());
                              textfieldController.text = "";
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: outcome!="" ? Colors.black87 : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    outcome,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: (() {
                        if (outcome == "correct")
                          return Colors.greenAccent;
                        else if (outcome
                            .contains("false, the correct answer is"))
                          return Colors.red;
                        else
                          return Colors.white;
                      }()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void shuffle(String s) {
    setState(() {
      //HERE IMPLEMENT THE COMPARISON
      if (s == widget.qna[id].answer) {
        outcome = "correct";
        print("correct");
      } else {
        outcome = "false, the correct answer is: " + widget.qna[id].answer;
        print("false, the correct answer is: " + widget.qna[id].answer);
      }

      var r = new Random();
      lastId = id;
      id = r.nextInt(10);
      if (id == lastId) {
        id = r.nextInt(10);
      }
    });
  }
}
