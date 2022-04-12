import 'package:flutter/material.dart';
import 'package:calcotron/physics.dart';
import 'package:calcotron/chemistry.dart';
import 'package:calcotron/maths.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcotron v0.1',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController _tabController;
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: _selectedIndex);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.black87,
        title: const Text("Calcotron"),
        centerTitle: true,
        leading: PopupMenuButton<MenuItem>(
          icon: const Icon(Icons.menu),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color: Colors.greenAccent,
              width: 2,
            ),
          ),
          iconSize: 28,
          color: Colors.black87,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: MenuItem.Maths,
              child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white), child: Text("Maths")),
            ),
            const PopupMenuItem(
              value: MenuItem.Physics,
              child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Text("Physics")),
            ),
            const PopupMenuItem(
              value: MenuItem.Chemistry,
              child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Text("Chemistry")),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Search",
            icon: const Icon(Icons.search),
            iconSize: 28,
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchBar(),
              );
            },
          ),
        ],
        bottom: TabBar(
          indicatorWeight: 5,
          indicatorColor: Colors.greenAccent,
          tabs: const <Widget>[
            Tab(
              text: 'Physics',
              icon: Icon(Icons.brightness_5_sharp),
            ),
            Tab(
              text: 'Chemistry',
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              text: 'Maths',
              icon: Icon(Icons.analytics),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: const <Widget>[Physics(), Chemistry(), Maths()],
        controller: _tabController,
      ),
    );
  }
}

class MySearchBar extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
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
    );
  }

  List<String> searchedmethods = [
    'Linear Functions',
    'Polynomials',
    'Equations',
    'Something else 0',
    'Something else 1',
    'Something else 2',
    'Something else 3',
    'Something else 4',
    'Something else 5'
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.keyboard_backspace),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            }),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> methods = searchedmethods.where((searchedmethods) {
      final result = searchedmethods.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return ListView.builder(
        itemCount: methods.length,
        itemBuilder: (context, index) {
          final method = methods[index];
          return Card(
            color: Colors.black87,
            child: ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  setState(() {
                    methods.remove(method);
                  });
                },
              ),
              title: DefaultTextStyle(
                style: const TextStyle(fontSize: 15, color: Colors.white),
                child: Text(method),
              ),
              onTap: () {
                query = method;
                showResults(context);
                //go to page here
              },
            ),
          );
        },
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64),
        // This is where we show the actual page
      ),
    );
  }
}

enum MenuItem { Maths, Physics, Chemistry }
