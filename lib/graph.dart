import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  @override
  State<Graph> createState() => _GraphRedirect();
}

class _GraphRedirect extends State<Graph> {
  late ZoomPanBehavior _zoomcontroller;
  static const platform = MethodChannel("com.flutter.java/parse");
  final textfieldController = TextEditingController();
  List<ChartData> chartData = <ChartData>[];

  @override
  void dispose() {
    textfieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _zoomcontroller = ZoomPanBehavior(
        enablePinching: true,
        enableSelectionZooming: true,
        zoomMode: ZoomMode.xy,
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
          title: Text("Graph"),
          backgroundColor: Colors.black26,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.greenAccent,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SafeArea(
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
                      series: <ChartSeries<ChartData, double>>[
                        FastLineSeries<ChartData, double>(
                          animationDuration: 0,
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
                          dataLabelMapper: ((ChartData data, _) {
                            if (data.x == 0.0 || data.y == 0.0) {
                              return '(' +
                                  data.x.toString() +
                                  '|' +
                                  data.y.toString() +
                                  ')';
                            }
                            return "";
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
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
                              hintText: 'Enter a function',
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
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.close,
                                  color: Colors.grey.withOpacity(0.8),
                                  size: 20),
                              onPressed: () {
                                textfieldController.clear();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.greenAccent.withOpacity(0.8),
                                  size: 30),
                              onPressed: () {
                                Parser(textfieldController.text);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      const DefaultTextStyle(
                        textAlign: TextAlign.center,
                        child: Text("Accepted Operations on the Grapher:"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("Operation"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("Example"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("+, -, *, /"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("x+2"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("^"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("x^2"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("root_, log_"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("root_2(x), log_10(x)"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("ln"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("ln(x)"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("sin, cos, tan"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("sin(x)"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey,thickness: 0.5),
                      Row(
                        children: [
                          const DefaultTextStyle(
                            textAlign: TextAlign.left,
                            child: Text("arcsin, arccos, arctan"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          const DefaultTextStyle(
                            textAlign: TextAlign.right,
                            child: Text("arcsin(x)"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
    getList(value);
    // try {
    //   value = await platform.invokeMethod("Parser");
    // } on PlatformException catch (e) {
    //   value = "Failed: '${e.message}'";
    // }
    // print(value);
  }

  void getList(text) async {
    var channel = MethodChannel('com.flutter.java/parse');
    List<dynamic>? list =
        await channel.invokeListMethod<dynamic>('Parser', {"text": text});
    List<ChartData> chartData2 = <ChartData>[];
    for (var i in list!) {
      chartData2.add(ChartData(i[0], i[1]));
    }
    setState(() {
      chartData = chartData2;
    });
  }
// Future<List<ChartData>?> _getList() async {
//   List<ChartData>? chartData_test = await platform.invokeMethod('Parser');
//   return chartData_test;
// }
}

class ChartData {
  double x;
  double y;

  ChartData(this.x, this.y);
}
