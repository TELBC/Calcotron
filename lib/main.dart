import 'package:flutter/material.dart';
import 'package:calcotron/physics.dart';
import 'package:calcotron/chemistry.dart';
import 'package:calcotron/maths.dart';
import 'package:calcotron/about.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Database.dart';
import 'searchtab.dart';

//if you want to push do:
//git commit -am "insert commit description"
//git push -u origin branchname
//afterwards git push will remember and only git push will work

List<String> searchedmethods = [];
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
Future<void> getfromST() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  searchedmethods=await prefs.getStringList("searched")!;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcotron v1.2.6',
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("img/Calcotron_Logo_textless.png"),
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
                  // SizedBox(height: 3),
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
          nextScreen: const MyHomePage(),
          splashTransition: SplashTransition.fadeTransition,
          centered: true,
          backgroundColor: Colors.black87),
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
    getfromST();
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
    Images testImage1 = const Images(image: "img/Calcotron_Logo.png", id: 0);
    Images testImage2 = const Images(image: "img/Calcotron_Logo.png", id: 1);
    Images testImage3 =
        const Images(image: "img/Calcotron_Logo_textless.png", id: 2);

    //DESCRIPTION
    Description description1 =
        const Description(description: "example text text example1");
    Description description2 =
        const Description(description: "example text text example2");
    Description description3 =
        const Description(description: "example text text example3");

    //SUBJECT
    //id = 0 (Physics); id = 1 (Maths); id = 2 (Chemistry)
    Subject subject1 = const Subject(subject: "Physics");
    Subject subject2 = const Subject(subject: "Maths");
    Subject subject3 = const Subject(subject: "Chemistry");

    //TOPICS
    Topics topic1 = const Topics(SID: 0, topic: "Optics");
    Topics topic2 = const Topics(SID: 1, topic: "Integrals");
    Topics topic3 = const Topics(SID: 2, topic: "Plastics");

    //QNA
    QnA question1 = const QnA(
        question: "What is the speed of light",
        answer: "299 792 458",
        topicID: 0);
    QnA question2 = const QnA(
        question: "What is the integral of x^2?", answer: "x^3/3", topicID: 1);
    QnA question3 = const QnA(
        question: "What is the integral of x^2?", answer: "x^3/3", topicID: 2);

    /*
    ADDING DATA: await Calcotron_Database.instance.create"WHAT"(/INSERT THE VAR/)
    UPDATING and DELETING: await Calcotron_Database.instance.delete/WHAT YOU WANT/
    for TESTING: print(await Calcotron_Database.instance.readAll/WHAT/());
     */

    //ADD DATA HERE
    // THE CAST IS HERE SO THAT THE DATA IS NOT ADDED CONSTANTLY EVERYTIME THE APP IS LOADED

    if (images.isEmpty) {
      await Calcotron_Database.instance.createImage(testImage1);
      await Calcotron_Database.instance.createImage(testImage2);
      await Calcotron_Database.instance.createImage(testImage3);
    }
    if (description.isEmpty) {
      await Calcotron_Database.instance.createDescription(description1);
      await Calcotron_Database.instance.createDescription(description2);
      await Calcotron_Database.instance.createDescription(description3);
    }
    if (title.isEmpty) {
      await Calcotron_Database.instance.createTitle(title1);
      await Calcotron_Database.instance.createTitle(title2);
      await Calcotron_Database.instance.createTitle(title3);
    }
    if (subject.isEmpty) {
      await Calcotron_Database.instance.createSubject(subject1);
      await Calcotron_Database.instance.createSubject(subject2);
      await Calcotron_Database.instance.createSubject(subject3);
    }
    if (topics.isEmpty) {
      await Calcotron_Database.instance.createTopics(topic1);
      await Calcotron_Database.instance.createTopics(topic2);
      await Calcotron_Database.instance.createTopics(topic3);
    }
    if (qna.isEmpty) {
      await Calcotron_Database.instance.createQnA(question1);
      await Calcotron_Database.instance.createQnA(question2);
      await Calcotron_Database.instance.createQnA(question3);
    }
    //REFRESH DATA AFTER INSERTING
    images = await Calcotron_Database.instance.readAllImages();
    description = await Calcotron_Database.instance.readAllDescription();
    title = await Calcotron_Database.instance.readAllTitle();
    subject = await Calcotron_Database.instance.readAllSubjects();
    topics = await Calcotron_Database.instance.readAllTopics();
    qna = await Calcotron_Database.instance.readAllQnAs();
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
                    context, MaterialPageRoute(builder: (context) => const About()));
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
              onPressed: () async {
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

enum MenuItem { About, Quiz }
