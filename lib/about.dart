import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
          title: Text("About"),
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "img/Calcotron_Logo_textless.png",
                          ),
                          Column(
                            children: const [
                              Text(
                                "Calcotron",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "a Team Aether service",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        "Version 1.2.6",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const DefaultTextStyle(
                    child: Text("Calcotron is a school project developed by Florian Körner, Jeff Hu, Tristan Losada, Ruben Osmanovic and Somya Rathee. We intended it to be an offline learning app about mathematics, physics and chemistry, used by students to study for these subjects. Calcotron contains a formula collection with detailed explanations and quizzes to prepare you for upcoming exams. It also provides you with in-built features such as a graphing-calculator for a visual representation of functions"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
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
}

class ImageDialogue extends StatelessWidget {
  const ImageDialogue({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.contain,
      ),
    );
  }
}
