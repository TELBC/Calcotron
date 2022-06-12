import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:calcotron/Database.dart';

class Redirect extends StatefulWidget {
  Redirect(
      {Key? key,
      required this.id,
      required this.images,
      required this.description,
      required this.title,
      required this.subject,
      required this.topics,
      required this.qna})
      : super(key: key);

  final int id;
  final List<Images> images;
  final List<Description> description;
  final List<Titles> title;
  final List<Subject> subject;
  final List<Topics> topics;
  final List<QnA> qna;

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  final textfieldController = TextEditingController();

  @override
  void dispose() {
    textfieldController.dispose();
    super.dispose();
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
          title: Text(widget.title[widget.id].title),
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
                  child: DefaultTextStyle(
                    child: Text(widget.description[widget.id].description1),
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => ImageDialogue(
                              image: widget.images[widget.id].image1,
                            ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(13.0),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 2,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(widget.images[widget.id].image1),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(5.0),
                //   padding: const EdgeInsets.all(13.0),
                //   decoration: BoxDecoration(
                //     color: Colors.black87,
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: DefaultTextStyle(
                //     child: Text(widget.text),
                //     style: const TextStyle(
                //       fontSize: 13.0,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text("Quiz", style: TextStyle(color: Colors.white)),
                      Container(
                        padding: const EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            DefaultTextStyle(
                              child: Text(
                                widget.qna[widget.id].question,
                              ),
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            TextField(
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
                                fontSize: 13.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
