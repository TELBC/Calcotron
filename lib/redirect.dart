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
  late ZoomPanBehavior _zoomcontroller;
  static const platform = MethodChannel("com.flutter.java/parse");
  final textfieldController = TextEditingController();
  final List<ChartData> chartData = <ChartData>[
    ChartData(-10, -11),
    ChartData(1, 20),
    ChartData(2, -10),
    ChartData(3, 5),
    ChartData(4, 1),
    ChartData(5, 7),
    ChartData(6, 3),
    ChartData(7, 4),
    ChartData(10, 10),
    ChartData(15, 13),
    ChartData(21, 20),
  ];

  @override
  void dispose() {
    textfieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _zoomcontroller = ZoomPanBehavior(
        // enablePinching: true,
        // enableSelectionZooming: true,
        // zoomMode: ZoomMode.xy,
        enablePanning: true,
        maximumZoomLevel: 0.4);
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
                    child: Text(widget.description[widget.id].description),
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
                              image: widget.images[widget.id].image,
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
                      image: DecorationImage(
                        image: AssetImage(widget.images[widget.id].image),
                        fit: BoxFit.contain,
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
                      SafeArea(
                        child: SfCartesianChart(
                          enableAxisAnimation: true,
                          zoomPanBehavior: _zoomcontroller,
                          plotAreaBorderWidth: 0,
                          primaryXAxis: NumericAxis(
                            crossesAt: 0,
                            labelRotation: 90,
                            visibleMinimum: -10,
                            visibleMaximum: 10,
                            axisLine:
                                const AxisLine(color: Colors.grey, width: 0.6),
                            majorGridLines: const MajorGridLines(
                                color: Colors.grey, width: 0.3),
                          ),
                          primaryYAxis: NumericAxis(
                            visibleMinimum: -10,
                            visibleMaximum: 10,
                            crossesAt: 0,
                            axisLine:
                                const AxisLine(color: Colors.grey, width: 0.6),
                            majorGridLines: const MajorGridLines(
                                color: Colors.grey, width: 0.3),
                          ),
                          series: <ChartSeries<ChartData, int>>[
                            FastLineSeries<ChartData, int>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              isVisible: true,
                              yAxisName: 'y',
                              xAxisName: 'x',
                              color: Colors.greenAccent,
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: Colors.white12, fontSize: 12)),
                              dataLabelMapper: (ChartData data, _) =>
                                  '(' +
                                  data.x.toString() +
                                  '|' +
                                  data.y.toString() +
                                  ')',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 13.0, right: 1.0, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'f(x) = ',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: textfieldController,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.greenAccent),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: IconButton(
                                icon: Icon(Icons.double_arrow,
                                    color: Colors.greenAccent.withOpacity(0.8),
                                    size: 30),
                                onPressed: () {
                                  Parser(textfieldController.text);
                                },
                              ),
                            ),
                          ],
                        ),
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

  void Parser(String value) async {
    try {
      value = await platform.invokeMethod("Parser");
    } on PlatformException catch (e) {
      value = "Failed: '${e.message}'";
    }
    print(value);
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int? x;
  final int? y;
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
