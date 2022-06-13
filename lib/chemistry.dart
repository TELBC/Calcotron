import 'package:flutter/material.dart';
import 'package:calcotron/redirect.dart';
import 'dart:core';
import 'Database.dart';

class Chemistry extends StatefulWidget {
  const Chemistry({
    Key? key,
    required this.images,
    required this.description,
    required this.title,
    required this.subject,
    required this.topics,
    required this.qna,
  }) : super(key: key);

  final List<Images> images;
  final List<Description> description;
  final List<Titles> title;
  final List<Subject> subject;
  final List<Topics> topics;
  final List<QnA> qna;

  @override
  _ChemistryState createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {
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
              child: GridView.builder(
                  primary: true,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 10),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    index+=16;
                    return InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: DefaultTextStyle(
                          child: Text(widget.title[index].title),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => Redirect(
                            id: index,
                            images: widget.images,
                            description: widget.description,
                            title: widget.title,
                            subject: widget.subject,
                            topics: widget.topics,
                            qna: widget.qna,
                          ),
                        ));
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
