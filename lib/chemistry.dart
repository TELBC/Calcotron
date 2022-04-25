import 'package:flutter/material.dart';

class Chemistry extends StatefulWidget {
  const Chemistry({Key? key}) : super(key: key);

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
                        builder: (context) => ItemPage1(title: "test2", text: "yes2",),
                      ));
                    },
                  ),
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
                        builder: (context) => ItemPage1(title: "test2", text: "yes2",),
                      ));
                    },
                  ),
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
                        builder: (context) => ItemPage1(title: "test2", text: "yes2",),
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


class ItemPage1 extends StatefulWidget {
  const ItemPage1({Key? key, required this.title, required this.text}) : super(key: key);
  final String title;
  final String text;
  @override
  State<ItemPage1> createState() => _ItemPage1State();
}

class _ItemPage1State extends State<ItemPage1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
      ),

      body: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(right: 13.0),
              child: Text(
                widget.text,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
