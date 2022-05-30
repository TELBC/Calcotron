import 'package:flutter/material.dart';
import 'package:calcotron/physics.dart';
import 'package:calcotron/chemistry.dart';
import 'package:calcotron/maths.dart';
import 'package:calcotron/about.dart';
import 'package:flutter/services.dart';

import 'Database.dart';

//if you want to push do:
//git commit -am "insert commit description"
//git push -u origin branchname
//afterwards git push will remember and only git push will work
List<String> searchedmethods = [
  'Linear Functions',
  'Polynomials',
  'Equations',
];
List<String> existingmethods = [
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

  @override
  void dispose() {
    Calcotron_Database.instance.close();

    super.dispose();
  }

  /*
  * INSERT DATA HERE AND CREATE THE VARs
  * */
  void refreshDatabase() async {

    // GET ITEMS TO LIST HERE
    images = await Calcotron_Database.instance.readAllImages();
    description = await Calcotron_Database.instance.readAllDescription();
    title = await Calcotron_Database.instance.readAllTitle();
    subject = await Calcotron_Database.instance.readAllSubjects();
    topics = await Calcotron_Database.instance.readAllTopics();
    qna = await Calcotron_Database.instance.readAllQnAs();

    // CREATE THE VARIABLES HERE

    //TITLES
    Titles title1 = const Titles(title: "Optics");
    Titles title2 = const Titles(title: "Integrals");
    Titles title3 = const Titles(title: "ChemTEST");

    //IMAGES
    Images testImage1 = const Images(image: "../img/Calcotron_Logo.png");
    Images testImage2 = const Images(image: "");

    //DESCRIPTION
    Description description1 = const Description(description: "example text text example");
    Description description2 = const Description(description: "example text text example");
    // Description description3 = const Description(description: "example text text example");

    //SUBJECT
    //id = 0 (Physics); id = 1 (Maths); id = 2 (Chemistry)
    Subject subject1 = const Subject(subject: "Physics");
    Subject subject2 = const Subject(subject: "Maths");
    Subject subject3 = const Subject(subject: "Chemistry");

    //TOPICS
    Topics topic1 = const Topics(SID: 0, topic: "Optics");
    Topics topic2 = const Topics(SID: 1, topic: "Integrals");
    Topics topic3 = const Topics(SID: 2, topic: "Integrals");

    //QNA
    QnA question1 = const QnA(question: "What is the speed of light", answer: "299 792 458", topicID: 0);
    QnA question2 = const QnA(question: "What is the integral of x^2?", answer: "x^3/3", topicID: 1);
    // QnA question3 = const QnA(question: "What is the integral of x^2?", answer: "x^3/3", topicID: 2);

    /*
    ADDING DATA: await Calcotron_Database.instance.create"WHAT"(/INSERT THE VAR/)
    UPDATING and DELETING: await Calcotron_Database.instance.delete/WHAT YOU WANT/
    for TESTING: print(await Calcotron_Database.instance.readAll/WHAT/());
     */

    //ADD DATA HERE
    // THE CAST IS HERE SO THAT THE DATA IS NOT ADDED CONSTANTLY EVERYTIME THE APP IS LOADED

    if(images.isEmpty) {
      await Calcotron_Database.instance.createImage(testImage1);
      await Calcotron_Database.instance.createImage(testImage2);
      // await Calcotron_Database.instance.createImage(testImage3);
    }


    if(description.isEmpty) {

      await Calcotron_Database.instance.createDescription(description1);
      await Calcotron_Database.instance.createDescription(description2);
      // await Calcotron_Database.instance.createDescription(description3);
    }

    if(title.isEmpty) {
      await Calcotron_Database.instance.createTitle(title1);
      await Calcotron_Database.instance.createTitle(title2);
      await Calcotron_Database.instance.createTitle(title3);
    }

    if(subject.isEmpty) {
      await Calcotron_Database.instance.createSubject(subject1);
      await Calcotron_Database.instance.createSubject(subject2);
      await Calcotron_Database.instance.createSubject(subject3);
    }

    if(topics.isEmpty) {
      await Calcotron_Database.instance.createTopics(topic1);
      await Calcotron_Database.instance.createTopics(topic2);
      await Calcotron_Database.instance.createTopics(topic3);
    }

    if(qna.isEmpty) {
      await Calcotron_Database.instance.createQnA(question1);
      await Calcotron_Database.instance.createQnA(question2);
      // await Calcotron_Database.instance.createQnA(question3);
    }



    //REFRESH DATA AFTER INSERTING
    images = await Calcotron_Database.instance.readAllImages();
    description = await Calcotron_Database.instance.readAllDescription();
    title = await Calcotron_Database.instance.readAllTitle();
    subject = await Calcotron_Database.instance.readAllSubjects();
    topics = await Calcotron_Database.instance.readAllTopics();
    qna = await Calcotron_Database.instance.readAllQnAs();

    print(title[0].title);
    print(images[1].image);
  }

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: Colors.black87,
          title: const Text("Calcotron"),
          centerTitle: true,
          leading: PopupMenuButton<MenuItem>(
            onSelected: (result) {
              if (result == MenuItem.About) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              }
            },
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
                value: MenuItem.About,
                child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Text("About")),

              ),
              const PopupMenuItem(
                value: MenuItem.Quiz,
                child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white), child: Text("Quiz")),
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

  List<String> change_methods(List<String> history, List<String> all) {
    if (query.isEmpty) {
      return history;
    } else {
      List<String> methods = all.where((all) {
        final result = all.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      }).toList();
      return methods;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> _methods = change_methods(searchedmethods, existingmethods);

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
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
              child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: _methods.length,
                itemBuilder: (context, index) {
                  final method = _methods[index];
                  return Card(
                    color: Colors.black87,
                    child: ListTile(
                      title: DefaultTextStyle(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        child: Text(method),
                      ),
                      onTap: () {
                        if (!searchedmethods.contains(method))
                          searchedmethods.add(method);
                        query = method;
                        showResults(context);
                      },
                      trailing: query.isNotEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white54),
                              onPressed: () {
                                setState(() {
                                  searchedmethods.remove(method);
                                  _methods.remove(method);
                                });
                              },
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
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

enum MenuItem { About, Quiz }
