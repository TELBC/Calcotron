import 'dart:async';
import 'package:calcotron/graph.dart';
import 'package:calcotron/quiz.dart';
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
  "Mechanics",
  "Thermodynamics",
  "Optics",
  "Electromagnetism",
  "Relativity",
  "Quantum Mechanics",
  "Sets",
  "Vectors & Matrices",
  "Quadratic Equations",
  "Planes",
  "Trignometry",
  "Integration",
  "Differentiation",
  "Statistics",
  "Probability",
  "Series and Sequences",
  "Acids, Bases",
  "Electrochemistry",
  "Organic Chemistry",
  "Inorganic Chemistry",
  "Periodic Table",
  "Thermochemistry",
  "Physical Chemistry",
  "Biochemistry"
];

void main() {
  runApp(const MyApp());
}

Future<void> getfromST() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  searchedmethods = await prefs.getStringList("searched")!;
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
          nextScreen: MyHomePage(),
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
  int _selectedIndex = 1;
  late List<Images> images = [];
  late List<Description> description = [];
  late List<Titles> title = [];
  late List<Subject> subject = [];
  late List<Topics> topics = [];
  late List<QnA> qna = [];

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
    //Pysics
    Titles title1 = const Titles(title: "Mechanics");
    Titles title2 = const Titles(title: "Thermodynamics");
    Titles title3 = const Titles(title: "Optics");
    Titles title4 = const Titles(title: "Electromagnetism");
    Titles title5 = const Titles(title: "Relativity");
    Titles title6 = const Titles(title: "Quantum Mechanics");

    //Maths
    Titles title7 = const Titles(title: "Sets");
    Titles title8 = const Titles(title: "Vectors & Matrices");
    Titles title9 = const Titles(title: "Quadratic Equations");
    Titles title10 = const Titles(title: "Planes");
    Titles title11 = const Titles(title: "Trignometry");
    Titles title12 = const Titles(title: "Integration");
    Titles title13 = const Titles(title: "Differentiation");
    Titles title14 = const Titles(title: "Statistics");
    Titles title15 = const Titles(title: "Probability");
    Titles title16 = const Titles(title: "Series and Sequences");

    //Chemistry
    Titles title17 = const Titles(title: "Acids, Bases");
    Titles title18 = const Titles(title: "Electrochemistry");
    Titles title19 = const Titles(title: "Organic Chemistry");
    Titles title20 = const Titles(title: "Inorganic Chemistry");
    Titles title21 = const Titles(title: "Periodic Table");
    Titles title22 = const Titles(title: "Thermochemistry");
    Titles title23 = const Titles(title: "Physical Chemistry");
    Titles title24 = const Titles(title: "Biochemistry");

    //IMAGES
    //Physics
    Images image1 = const Images(
        image1:
            "img/formula_imgs/Physics/Classical Mechanics/01Acceleration.png");
    Images image2 = const Images(
        image1: "img/formula_imgs/Physics/Themodynamics/01Enthalpy.png");
    Images image3 =
        const Images(image1: "img/formula_imgs/Physics/Optics/01Optics.png");
    Images image4 = const Images(
        image1: "img/formula_imgs/Physics/ElectroMagn/01Electromag.png");
    Images image5 = const Images(
        image1: "img/formula_imgs/Physics/Relativity/01Relativity.png");
    Images image6 =
        const Images(image1: "img/formula_imgs/Physics/Quantum/01Quantum.png");

    //Maths
    Images image7 =
        const Images(image1: "img/formula_imgs/Maths/Sets/01ImpFormula.png");
    Images image8 = const Images(
        image1: "img/formula_imgs/Maths/Vector&Matrices/Magnitude.png");
    Images image9 = const Images(
        image1: "img/formula_imgs/Maths/QuadEqu/01QuadraticEqu.png");
    Images image10 =
        const Images(image1: "img/formula_imgs/Maths/Trig/01Trig.png");
    Images image11 =
        const Images(image1: "img/formula_imgs/Maths/Integration/01Integr.png");
    Images image12 = const Images(
        image1: "img/formula_imgs/Maths/Differentiation/01Dif.png");
    Images image13 = const Images(
        image1: "img/formula_imgs/Maths/Statistics/01Statistics.png");
    Images image14 =
        const Images(image1: "img/formula_imgs/Maths/Probab/01Probab.png");
    Images image15 =
        const Images(image1: "img/formula_imgs/Maths/SeriesSequ/01Series.png");

    //Chemistry
    Images image16 = const Images(
        image1: "img/formula_imgs/Chemistry/AcidsBases/AcidsBaseEquation.png");
    Images image17 = const Images(
        image1: "img/formula_imgs/Chemistry/ElectroChem/01Electrochem.png");
    Images image18 =
        const Images(image1: "img/formula_imgs/Chemistry/OrgChem/01OrgCh.png");
    Images image19 = const Images(
        image1: "img/formula_imgs/Chemistry/Inorganic/01Inorg.png");
    Images image20 = const Images(
        image1: "img/formula_imgs/Chemistry/PeriodicTable/01PerTab.png");
    Images image21 = const Images(
        image1: "img/formula_imgs/Chemistry/ThermoChem/01ThermalChem.png");
    Images image22 = const Images(
        image1: "img/formula_imgs/Chemistry/PhysicalChem/01PhysicalChem.png");
    Images image23 = const Images(
        image1: "img/formula_imgs/Chemistry/BioChem/01BioChem.png");
    Images image24 = const Images(
        image1: "img/formula_imgs/Chemistry/ThermoChem/01ThermalChem.png");

    //DESCRIPTION

    //Physics
    Description description1 = const Description(
        description1:
            "Is defined as  the rate at which velocity changes with time, in terms of both speed and direction",
        description2:
            "acceleration, rate at which velocity changes with time, in terms of both speed and direction. A point or an object moving in a straight line is accelerated if it speeds up or slows down.");
    Description description2 = const Description(
        description1:
            "H = Enthaply, E = internal energy, P = pressure, V = volume",
        description2:
            "Enthalpy, a property of a thermodynamic system, is the sum of the system's internal energy and the product of its pressure and volume. It is a state function used in many measurements in chemical, biological, and physical systems at a constant pressure, which is conveniently provided by the large ambient atmosphere");
    Description description3 = const Description(
        description1:
            "Refractive index is calculated by speed of light divided by phase velocity of light",
        description2:
            "In optics, the refractive index of an optical medium is a dimensionless number that gives the indication of the light bending ability of that medium. The refractive index determines how much the path of light is bent, or refracted, when entering a material.");
    Description description4 = const Description(
        description1:
            "γ is electromagnetic wave propagation, α is the attenuation of  the wave,β is its phase shift Electromagnetism is a branch of physics involving the study of the electromagnetic force, a type of physical interaction that occurs between electrically charged particles");
    Description description5 = const Description(
        description1:
            "T= time measured by observer. T0 time measured bu third party, v = velocity, c = speed of light",
        description2:
            "The theory of relativity usually encompasses two interrelated theories by Albert Einstein: special relativity and general relativity, proposed and published in 1905 and 1915, respectively. Special relativity applies to all physical phenomena in the absence of gravity");
    Description description6 = const Description(
        description1:
            "Planck’s formula, Energy of one photon where h = 6.626 X 10-34",
        description2:
            "Quantum mechanics is a fundamental theory in physics that provides a description of the physical properties of nature at the scale of atoms and subatomic particles. It is the foundation of all quantum physics including quantum chemistry, quantum field theory, quantum technology, and quantum information science");

    //Maths
    Description description7 = const Description(
        description1: "These are the most important formulae in maths",
        description2:
            "A set is the mathematical model for a collection of different things; a set contains elements or members, which can be mathematical objects of any kind: numbers, symbols, points in space, lines, other geometrical shapes, variables, or even other sets.");
    Description description8 = const Description(
        description1: "Formula to find the magnitude of a vector in 2D space",
        description2:
            "A vector is a list of numbers (can be in a row or column), A matrix is an array of numbers (one or more rows, one or more columns). The magnitude (length) of a vector is a scalar, equal to the square root of the sum of the squares of its elements. This is a special case of the fact that the Euclidean distance between two points in n-space is the square root of the sum of the squares of the element-wise differences.");
    Description description9 = const Description(
        description1:
            "a,b,c = known numbers where a is not 0, x = unknown In algebra, a quadratic equation is any equation that can be rearranged in standard form as ax^{2}+bx+c=0 where x represents an unknown, and a, b, and c represent known numbers, where a ≠ 0. If a = 0, then the equation is linear, not quadratic, as there is no ax^2 term.");
    Description description10 = const Description(
        description1:
            "The Cosine Rule says that the square of the length of any side of a given triangle is equal to the sum of the squares of the length of the other sides minus twice the product of the other two sides multiplied by the cosine of angle included between them.");
    Description description11 = const Description(
        description1: "u=u(x) dv= variable dv v =v(x) du= variable du",
        description2:
            "In mathematics, an integral assigns numbers to functions in a way that describes displacement, area, volume, and other concepts that arise by combining infinitesimal data. The process of finding integrals is called integration. The fundamental use of integration is as a continuous version of summing. But, paradoxically, often integrals are computed by viewing integration as essentially an inverse operation to differentiation. (That fact is the so-called Fundamental Theorem of Calculus.)");
    Description description12 = const Description(
        description1: "differentiation of sinx is cosx",
        description2:
            "In mathematics, the derivative of a function of a real variable measures the sensitivity to change of the function value with respect to a change in its argument. Derivatives are a fundamental tool of calculus.");
    Description description13 = const Description(
        description1:
            "xi = frequency of elements  of particular type N=total frequency",
        description2:
            "Statistics is the discipline that concerns the collection, organization, analysis, interpretation, and presentation of data. In applying statistics to a scientific, industrial, or social problem, it is conventional to begin with a statistical population or a statistical model to be studied.");
    Description description14 = const Description(
        description1: "n= # outcomes in A N=# outcomes in Sample Space",
        description2:
            "Probability is about estimating or calculating how likely or 'probable' something is to happen. The chance of an event happening can be described in words, for example 'certain', 'impossible' or 'likely'. In maths, probabilities are always written as fractions , decimals or percentages with values between 0 and 1.");
    Description description15 = const Description(
        description1:
            ".n = number of terms being added, a1= first time, an = last / nth term",
        description2:
            "In mathematics, a sequence is a list of objects (or events) which have been ordered in a sequential fashion; such that each member either comes before, or after, every other member. More formally, a sequence is a function with a domain equal to the set of positive integers. A series is a sum of a sequence of terms.");

    //Chemistry
    Description description16 = const Description(
        description1:
            "acid–base reaction, a type of chemical process typified by the exchange of one or more hydrogen ions, H+. An acid–base reaction is a chemical reaction that occurs between an acid and a base. It can be used to determine pH.",
        description2:
            "An acid is any hydrogen-containing substance that is capable of donating a proton (hydrogen ion) to another substance. A base is a molecule or ion able to accept a hydrogen ion from an acid. Acidic substances are usually identified by their sour taste.");
    Description description17 = const Description(
        description1: "The energy cell is negative plus positive charges ",
        description2:
            "Cations are positively-charged ions (atoms or groups of atoms that have more protons than electrons due to having lost one or more electrons). Anions are negatively-charged ions (meaning they have more electrons than protons due to having gained one or more electrons)");
    Description description18 = const Description(
        description1:
            "methane! Organic chemistry is the study of the structure, properties, composition, reactions, and preparation of carbon-containing compounds. Most organic compounds contain carbon and hydrogen, but they may also include any number of other elements (e.g., nitrogen, oxygen, halogens, phosphorus, silicon, sulfur).",
        description2:
            "Organic chemistry is important because it is the study of life and all of the chemical reactions related to life. Several careers apply an understanding of organic chemistry, such as doctors, veterinarians, dentists, pharmacologists, chemical engineers, and chemists.");
    Description description19 = const Description(
        description1: "Common Names: Sodium oxide",
        description2:
            "In chemistry, an inorganic compound is typically a chemical compound that lacks carbon–hydrogen bonds, that is, a compound that is not an organic compound. However, the distinction is not clearly defined; authorities have differing views on the subject. Inorganic chemistry is concerned with the properties and behavior of inorganic compounds, which include metals, minerals, and organometallic compounds.");
    Description description20 = const Description(
        description1: "Image of Periodic Table",
        description2:
            "In chemistry, an inorganic compound is typically a chemical compound that lacks carbon–hydrogen bonds, that is, a compound that is not an organic compound. However, the distinction is not clearly defined; authorities have differing views on the subject. Inorganic chemistry is concerned with the properties and behavior of inorganic compounds, which include metals, minerals, and organometallic compounds.");
    Description description21 = const Description(
        description1: "Image of Periodic Table",
        description2:
            "The periodic table, also known as the periodic table of the elements, is a tabular display of the chemical elements. It is widely used in chemistry, physics, and other sciences, and is generally seen as an icon of chemistry. The periodic table of chemical elements, often called the periodic table, organizes all discovered chemical elements in rows (called periods) and columns (called groups) according to increasing atomic number.");
    Description description22 = const Description(
        description1:
            "Q = heat, enthalpy, m = mass, c = specific heat, delta T= final-initial temperature",
        description2:
            "Thermochemistry is the study of the heat energy which is associated with chemical reactions and/or phase changes such as melting and boiling. A reaction may release or absorb energy, and a phase change may do the same");
    Description description23 = const Description(
        description1: "U is internal energy, q is heat, w is work",
        description2:
            "Physical Chemistry is the study of macroscopic, and particulate phenomena in chemical systems in terms of the principles, practices, and concepts of physics such as motion, energy, force, time, thermodynamics, quantum chemistry, statistical mechanics, analytical dynamics and chemical equilibria. Physical chemistry is the branch of chemistry that deals with the physical structure of chemical compounds, the way they react with other matter and the bonds that hold their atoms together. An example of physical chemistry is nitric acid eating through wood.");
    Description description24 = const Description(
        description1: "Water(H2O)- inorganic  75% of all cell’s mass",
        description2:
            "Biochemistry is the branch of science that explores the chemical processes within and related to living organisms. It is a laboratory based science that brings together biology and chemistry. By using chemical knowledge and techniques, biochemists can understand and solve essential biological problems.");

    //SUBJECT
    //id = 0 (Physics); id = 1 (Maths); id = 2 (Chemistry)
    Subject subject1 = const Subject(subject: "Physics"); //id=0
    Subject subject2 = const Subject(subject: "Maths"); //id=1
    Subject subject3 = const Subject(subject: "Chemistry"); //id=2

    //TOPICS
    Topics topic1 =
        const Topics(SID: 0, topic: "Classical Mechanics"); //Physics
    Topics topic2 = const Topics(SID: 0, topic: "Thermodynamics"); //Physics
    Topics topic3 = const Topics(SID: 0, topic: "Optics"); //Physics
    Topics topic4 = const Topics(SID: 0, topic: "Electromagnetism"); //Physics
    Topics topic5 = const Topics(SID: 0, topic: "Relativity"); //Physics
    Topics topic6 = const Topics(SID: 0, topic: "Quantum Mechanics"); //Physics

    Topics topic7 = const Topics(SID: 1, topic: "Sets"); //Maths
    Topics topic8 = const Topics(SID: 1, topic: "Vectors & Matrices"); //Maths
    Topics topic9 = const Topics(SID: 1, topic: "Quadratic Equations"); //Maths
    Topics topic10 = const Topics(SID: 1, topic: "Planes"); //Maths
    Topics topic11 = const Topics(SID: 1, topic: "Trignometry"); //Maths
    Topics topic12 = const Topics(SID: 1, topic: "Integration"); //Maths
    Topics topic13 = const Topics(SID: 1, topic: "Differentiation"); //Maths
    Topics topic14 = const Topics(SID: 1, topic: "Statistics"); //Maths
    Topics topic15 = const Topics(SID: 1, topic: "Probability"); //Maths
    Topics topic16 =
        const Topics(SID: 1, topic: "Series and Sequences"); //Maths

    Topics topic17 = const Topics(SID: 2, topic: "Acids, Bases"); //Chemistry
    Topics topic18 =
        const Topics(SID: 2, topic: "Electrochemistry"); //Chemistry
    Topics topic19 =
        const Topics(SID: 2, topic: "Organic Chemistry"); //Chemistry
    Topics topic20 =
        const Topics(SID: 2, topic: "Inorganic Chemistry"); //Chemistry
    Topics topic21 = const Topics(SID: 2, topic: "Periodic Table"); //Chemistry
    Topics topic22 = const Topics(SID: 2, topic: "Thermochemistry"); //Chemistry
    Topics topic23 =
        const Topics(SID: 2, topic: "Physical Chemistry"); //Chemistry
    Topics topic24 = const Topics(SID: 2, topic: "Biochemistry"); //Chemistry

    //QNA
    //Phyaics questions
    QnA question1 = const QnA(
        question:
            "What is the acceleration if the velocity is 5m/s and time is 2 seconds?",
        answer: "2.5",
        topicID: 0);
    QnA question2 = const QnA(
        question: "True or False. Entropy of a system is always increasing. ",
        answer: "true",
        topicID: 1);
    QnA question3 = const QnA(
        question: "The angle of incidence is equal to the angle of r....",
        answer: "reflection",
        topicID: 2);
    QnA question4 = const QnA(
        question:
            "Find the wavelength of a wave travelling at 20m/s at frequency 5Hz.",
        answer: "4m",
        topicID: 3);
    QnA question5 = const QnA(
        question:
            "Type the formulae of Energy  is equal to mass times the speed of light squared.",
        answer: "E = mc ^ 2",
        topicID: 4);
    QnA question6 = const QnA(
        question: "Discrete natural unit or packet of energy is known as",
        answer: "Quantum",
        topicID: 5);

    //Mathe
    QnA question7 = const QnA(
        question: "n(A – B) + n(A ∩ B ) =", answer: "n(A)", topicID: 6);
    QnA question8 = const QnA(
        question:
            "If A and B are two vectors and θ is the angle between them, then A x B =",
        answer: "|A| |B| Sin θ",
        topicID: 7);
    QnA question9 = const QnA(
        question: "How many zeroes can a quadratic equation have?",
        answer: "2",
        topicID: 8);
    QnA question10 = const QnA(
        question: "Sine law states that",
        answer: "a/sinA=b/sinB=c/sinC",
        topicID: 9);
    QnA question11 =
        const QnA(question: "∫cf(x) dx =", answer: "c∫f(x) dx", topicID: 10);
    QnA question12 = const QnA(
        question: "What is the integral of x^2?", answer: "x^3/3", topicID: 10);
    QnA question13 = const QnA(
        question: "The derivative of a constant is", answer: "0", topicID: 11);
    QnA question14 = const QnA(
        question: "In statistics we often deal with probability dis…..",
        answer: "distributions",
        topicID: 12);
    QnA question15 = const QnA(
        question: "The complement of P(A) is", answer: "1-P(A)", topicID: 13);

    //Chemistry
    QnA question16 = const QnA(
        question: "What ist the ph value of the strongest possible acid?",
        answer: "1",
        topicID: 14);
    QnA question17 = const QnA(
        question:
            "Hydrogen gas is not liberated when the following metal is added to dil. HCl.",
        answer: "ag",
        topicID: 15);
    QnA question18 = const QnA(
        question:
            "Which of the mentioned can be used as an explosive and a fertilizer?",
        answer: "Ammonium Nitrate",
        topicID: 16);
    QnA question19 = const QnA(
        question: "How many elements are in the period table?",
        answer: "118",
        topicID: 17);
    QnA question20 = const QnA(
        question:
            "If the enthalpy change is negative, what kind of reaction has occurred?",
        answer: "Exothermic reaction",
        topicID: 18);
    QnA question21 = const QnA(
        question:
            "Which factor does not affect the speed of chemical reaction (P,V,T,Catalyst)",
        answer: "v",
        topicID: 19);
    QnA question22 = const QnA(
        question:
            "Which of these elements is NOT a constituent of Carbohydrates? (C,H,O,N)",
        answer: "N",
        topicID: 20);

    /*
    ADDING DATA: await Calcotron_Database.instance.create"WHAT"(/INSERT THE VAR/)
    UPDATING and DELETING: await Calcotron_Database.instance.delete/WHAT YOU WANT/
    for TESTING: print(await Calcotron_Database.instance.readAll/WHAT/());
     */

    //ADD DATA HEREa
    // THE CAST IS HERE SO THAT THE DATA IS NOT ADDED CONSTANTLY EVERYTIME THE APP IS LOADED

    //ADD DATA HERE
    // THE CAST IS HERE SO THAT THE DATA IS NOT ADDED CONSTANTLY EVERYTIME THE APP IS LOADED

    if (images.isEmpty) {
      await Calcotron_Database.instance.createImage(image1);
      await Calcotron_Database.instance.createImage(image2);
      await Calcotron_Database.instance.createImage(image3);
      await Calcotron_Database.instance.createImage(image4);
      await Calcotron_Database.instance.createImage(image5);
      await Calcotron_Database.instance.createImage(image6);
      await Calcotron_Database.instance.createImage(image7);
      await Calcotron_Database.instance.createImage(image8);
      await Calcotron_Database.instance.createImage(image9);
      await Calcotron_Database.instance.createImage(image10);
      await Calcotron_Database.instance.createImage(image10);
      await Calcotron_Database.instance.createImage(image11);
      await Calcotron_Database.instance.createImage(image12);
      await Calcotron_Database.instance.createImage(image13);
      await Calcotron_Database.instance.createImage(image14);
      await Calcotron_Database.instance.createImage(image15);
      await Calcotron_Database.instance.createImage(image16);
      await Calcotron_Database.instance.createImage(image17);
      await Calcotron_Database.instance.createImage(image18);
      await Calcotron_Database.instance.createImage(image19);
      await Calcotron_Database.instance.createImage(image20);
      await Calcotron_Database.instance.createImage(image21);
      await Calcotron_Database.instance.createImage(image22);
      await Calcotron_Database.instance.createImage(image23);
      await Calcotron_Database.instance.createImage(image24);
    }
    if (description.isEmpty) {
      await Calcotron_Database.instance.createDescription(description1);
      await Calcotron_Database.instance.createDescription(description2);
      await Calcotron_Database.instance.createDescription(description3);
      await Calcotron_Database.instance.createDescription(description4);
      await Calcotron_Database.instance.createDescription(description5);
      await Calcotron_Database.instance.createDescription(description6);
      await Calcotron_Database.instance.createDescription(description7);
      await Calcotron_Database.instance.createDescription(description8);
      await Calcotron_Database.instance.createDescription(description9);
      await Calcotron_Database.instance.createDescription(description10);
      await Calcotron_Database.instance.createDescription(description10);
      await Calcotron_Database.instance.createDescription(description11);
      await Calcotron_Database.instance.createDescription(description12);
      await Calcotron_Database.instance.createDescription(description13);
      await Calcotron_Database.instance.createDescription(description14);
      await Calcotron_Database.instance.createDescription(description15);
      await Calcotron_Database.instance.createDescription(description16);
      await Calcotron_Database.instance.createDescription(description17);
      await Calcotron_Database.instance.createDescription(description18);
      await Calcotron_Database.instance.createDescription(description19);
      await Calcotron_Database.instance.createDescription(description20);
      await Calcotron_Database.instance.createDescription(description21);
      await Calcotron_Database.instance.createDescription(description22);
      await Calcotron_Database.instance.createDescription(description23);
      await Calcotron_Database.instance.createDescription(description24);
    }
    if (title.isEmpty) {
      await Calcotron_Database.instance.createTitle(title1);
      await Calcotron_Database.instance.createTitle(title2);
      await Calcotron_Database.instance.createTitle(title3);
      await Calcotron_Database.instance.createTitle(title4);
      await Calcotron_Database.instance.createTitle(title5);
      await Calcotron_Database.instance.createTitle(title6);
      await Calcotron_Database.instance.createTitle(title7);
      await Calcotron_Database.instance.createTitle(title8);
      await Calcotron_Database.instance.createTitle(title9);
      await Calcotron_Database.instance.createTitle(title10);
      await Calcotron_Database.instance.createTitle(title11);
      await Calcotron_Database.instance.createTitle(title12);
      await Calcotron_Database.instance.createTitle(title13);
      await Calcotron_Database.instance.createTitle(title14);
      await Calcotron_Database.instance.createTitle(title15);
      await Calcotron_Database.instance.createTitle(title16);
      await Calcotron_Database.instance.createTitle(title17);
      await Calcotron_Database.instance.createTitle(title18);
      await Calcotron_Database.instance.createTitle(title19);
      await Calcotron_Database.instance.createTitle(title20);
      await Calcotron_Database.instance.createTitle(title21);
      await Calcotron_Database.instance.createTitle(title22);
      await Calcotron_Database.instance.createTitle(title23);
      await Calcotron_Database.instance.createTitle(title24);
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
      await Calcotron_Database.instance.createTopics(topic4);
      await Calcotron_Database.instance.createTopics(topic5);
      await Calcotron_Database.instance.createTopics(topic6);
      await Calcotron_Database.instance.createTopics(topic7);
      await Calcotron_Database.instance.createTopics(topic8);
      await Calcotron_Database.instance.createTopics(topic9);
      await Calcotron_Database.instance.createTopics(topic10);
      await Calcotron_Database.instance.createTopics(topic11);
      await Calcotron_Database.instance.createTopics(topic12);
      await Calcotron_Database.instance.createTopics(topic13);
      await Calcotron_Database.instance.createTopics(topic14);
      await Calcotron_Database.instance.createTopics(topic15);
      await Calcotron_Database.instance.createTopics(topic16);
      await Calcotron_Database.instance.createTopics(topic17);
      await Calcotron_Database.instance.createTopics(topic18);
      await Calcotron_Database.instance.createTopics(topic19);
      await Calcotron_Database.instance.createTopics(topic20);
      await Calcotron_Database.instance.createTopics(topic21);
      await Calcotron_Database.instance.createTopics(topic22);
      await Calcotron_Database.instance.createTopics(topic23);
      await Calcotron_Database.instance.createTopics(topic24);
    }
    if (qna.isEmpty) {
      await Calcotron_Database.instance.createQnA(question1);
      await Calcotron_Database.instance.createQnA(question2);
      await Calcotron_Database.instance.createQnA(question3);
      await Calcotron_Database.instance.createQnA(question4);
      await Calcotron_Database.instance.createQnA(question5);
      await Calcotron_Database.instance.createQnA(question6);
      await Calcotron_Database.instance.createQnA(question7);
      await Calcotron_Database.instance.createQnA(question8);
      await Calcotron_Database.instance.createQnA(question9);
      await Calcotron_Database.instance.createQnA(question10);
      await Calcotron_Database.instance.createQnA(question11);
      await Calcotron_Database.instance.createQnA(question12);
      await Calcotron_Database.instance.createQnA(question13);
      await Calcotron_Database.instance.createQnA(question14);
      await Calcotron_Database.instance.createQnA(question15);
      await Calcotron_Database.instance.createQnA(question16);
      await Calcotron_Database.instance.createQnA(question17);
      await Calcotron_Database.instance.createQnA(question18);
      await Calcotron_Database.instance.createQnA(question19);
      await Calcotron_Database.instance.createQnA(question20);
      await Calcotron_Database.instance.createQnA(question21);
      await Calcotron_Database.instance.createQnA(question22);
    }
    //REFRESH DATA AFTER INSERTING
    //REFRESH DATA AFTER INSERTING
    images = await Calcotron_Database.instance.readAllImages();
    description = await Calcotron_Database.instance.readAllDescription();
    title = await Calcotron_Database.instance.readAllTitle();
    subject = await Calcotron_Database.instance.readAllSubjects();
    topics = await Calcotron_Database.instance.readAllTopics();
    qna = await Calcotron_Database.instance.readAllQnAs();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // GestureBinding.instance.handlePointerEvent(PointerDownEvent(
    //   position: Offset(200, 300),
    // ));
    TabController _tabController =
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              } else if (result == MenuItem.Graph) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Graph()));
              }else if (result == MenuItem.Quiz) {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quiz(qna: qna)));
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
                value: MenuItem.Graph,
                child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Text("Graph")),
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
                  delegate: MySearchBar(
                    id: 0,
                    images: images,
                    description: description,
                    title: title,
                    subject: subject,
                    topics: topics,
                    qna: qna,
                  ),
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
                icon: Icon(Icons.analytics_rounded),
              ),
              Tab(
                text: 'Chemistry',
                icon: Icon(Icons.science_rounded),
              ),
              Tab(
                text: 'Maths',
                icon: Icon(Icons.show_chart),
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Physics(
              images: images,
              description: description,
              title: title,
              subject: subject,
              topics: topics,
              qna: qna,
            ),
            Chemistry(
              images: images,
              description: description,
              title: title,
              subject: subject,
              topics: topics,
              qna: qna,
            ),
            Maths(
              images: images,
              description: description,
              title: title,
              subject: subject,
              topics: topics,
              qna: qna,
            )
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

enum MenuItem { About, Quiz, Graph }
