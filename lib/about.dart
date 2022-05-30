import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(
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
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const DefaultTextStyle(
                    child: Text("whatever"),
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