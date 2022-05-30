import 'package:flutter/material.dart';
import 'package:calcotron/redirect.dart';
import 'dart:core';
import 'Database.dart';

class Maths extends StatefulWidget {
  const Maths({Key? key}) : super(key: key);

  @override
  _MathsState createState() => _MathsState();
}

class _MathsState extends State<Maths> {
  late List<Images> images;
  late List<Description> description;
  late List<Titles> title;
  late List<Subject> subject;
  late List<Topics> topics;
  late List<QnA> qna;

  @override
  void initState() {
    super.initState();

    refreshDatabase();
  }

  void refreshDatabase() async {
    images = await Calcotron_Database.instance.readAllImages();
    description = await Calcotron_Database.instance.readAllDescription();
    title = await Calcotron_Database.instance.readAllTitle();
    subject = await Calcotron_Database.instance.readAllSubjects();
    topics = await Calcotron_Database.instance.readAllTopics();
    qna = await Calcotron_Database.instance.readAllQnAs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: RawScrollbar(
          thumbColor: Colors.white10,
          thickness: 6,
          radius: const Radius.circular(10),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.greenAccent,
              child: GridView.count(
                primary: true,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const DefaultTextStyle(
                        child: Text("test"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Redirect(
                          id: 1,
                          images: images,
                          description: description,
                          title: title,
                          subject: subject,
                          topics: topics,
                          qna: qna,
                        ),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// @override
//_MathsState createState() => _MathsState();
// }

// class _MathsState extends State<Maths> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black87,
//         body: RawScrollbar(
//           thumbColor: Colors.white10,
//           thickness: 6,
//           radius: const Radius.circular(10),
//           child: ScrollConfiguration(
//             behavior: const ScrollBehavior(),
//             child: GlowingOverscrollIndicator(
//               axisDirection: AxisDirection.down,
//               color: Colors.greenAccent,
//               child: GridView.count(
//                 primary: true,
//                 padding: const EdgeInsets.all(10),
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 crossAxisCount: 3,
//                 children: <Widget>[
//                   InkWell(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: const DefaultTextStyle(
//                         child: Text("test"),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const Redirect(
//                             title: "test1",
//                             text:
//                                 "This is a very long text in order to try out the clip function that works I think "
//                                 "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
//                       ));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
