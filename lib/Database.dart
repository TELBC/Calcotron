
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


/*
*
* DATA FOR THE TABLES AS CLASSES
*
* */

class Images {

  static final List<String> value = [
    "id", "image"
  ];

  final int? id;
  final String image;

  const Images({
    this.id,
    required this.image,
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'image': image,
  };

  static Images fromJson(Map<String, Object?> json) => Images(

    id: json['id'] as int?,
    image: json['image'] as String,

  );

  Images copy({
    int? id,
    String? image,
  }) => Images(id: id ?? this.id, image: image ?? this.image);

}

class Description {

  static final List<String> value = [
    "id", "description"
  ];

  final int? id;
  final String description;

  const Description({
    this.id,
    required this.description,
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'description': description,
  };

  static Description fromJson(Map<String, Object?> json) => Description(

    id: json['id'] as int?,
    description: json['description'] as String,

  );

  Description copy({
    int? id,
    String? description,
  }) => Description(id: id ?? this.id, description: description ?? this.description);

}


class Titles {
  static final List<String> value = [
    "id", "title"
  ];

  final int? id;
  final String title;

  const Titles({
    this.id,
    required this.title,
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
  };

  static Titles fromJson(Map<String, Object?> json) => Titles(

    id: json['id'] as int?,
    title: json['title'] as String,

  );

  Titles copy({
    int? id,
    String? title,
  }) => Titles(id: id ?? this.id, title: title ?? this.title);
}

class Subject {
  static final List<String> value = [
    "id", "subject"
  ];

  final int? id;
  final String subject;

  const Subject({
    this.id,
    required this.subject,
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'subject': subject,
  };

  static Subject fromJson(Map<String, Object?> json) => Subject(

    id: json['id'] as int?,
    subject: json['subject'] as String,

  );

  Subject copy({
    int? id,
    String? subject,
  }) => Subject(id: id ?? this.id, subject: subject ?? this.subject);
}

class Topics {
  static final List<String> value = [
    "id", "SID", "topic"
  ];

  final int? id;
  final int? SID;
  final String topic;

  const Topics({
    this.id,
    required this.SID,
    required this.topic,
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'SID': SID,
    'topic': topic,
  };

  static Topics fromJson(Map<String, Object?> json) => Topics(

    id: json['id'] as int?,
    SID: json['SID'] as int?,
    topic: json['topic'] as String,

  );

  Topics copy({
    int? id,
    String? topic,
  }) => Topics(id: id ?? this.id,SID: SID ?? this.SID, topic: topic ?? this.topic);
}

class QnA {
  static final List<String> value = [
    "id", "question", "answer", "topicID"
  ];

  final int? id;
  final String question;
  final String answer;
  final int topicID;

  const QnA({
    this.id,
    required this.question,
    required this.answer,
    required this.topicID
  });
  Map<String, Object?> toJson() => {
    'id': id,
    'question': question,
    'answer': answer,
    'topicID': topicID
  };

  static QnA fromJson(Map<String, Object?> json) => QnA(

      id: json['id'] as int?,
      question: json['question'] as String,
      answer: json['answer'] as String,
      topicID: json['topicID'] as int
  );

  QnA copy({
    int? id,
    String? question,
    String? answer,
    int? topicID

  }) => QnA(id: id ?? this.id, question: question ?? this.question, answer: answer ?? this.answer,
      topicID: topicID ?? this.topicID);
}

//add Videos, Formulas, Descriptions, Formulas


/*
*
* THE DB, TABLE, AND METHOD CREATION
*
* */

class Calcotron_Database {

  static final Calcotron_Database instance = Calcotron_Database._init();

  static Database? _database;

  Calcotron_Database._init();

  Future<Database> get database async {

    if(_database != null) return _database!;

    _database = await _initDB("calcotron.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {

    WidgetsFlutterBinding.ensureInitialized();

    final dBPath = await getDatabasesPath();
    final path = join(dBPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE Images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image TEXT NOT NULL
    );
    ''');
    await db.execute('''
    CREATE TABLE Description (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL
    );
    ''');
    await db.execute('''
    CREATE TABLE Title (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL
    );
    ''');
    await db.execute('''
    CREATE TABLE Subject (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject TEXT NOT NULL
    );
    ''');
    await db.execute('''
    CREATE TABLE Topics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    SID INTEGER NOT NULL,
    topic TEXT NOT NULL,
    FOREIGN KEY(SID) REFERENCES Subject(id)
    );
    ''');
    await db.execute('''
    CREATE TABLE QnA (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    topicID INTEGER NOT NULL,
    FOREIGN KEY(topicID) REFERENCES Topics(id)
    );
    ''');

  }

  Future<Images> createImage(Images image) async {

    final db = await instance.database;

    final id = await db.insert('Images', image.toJson());
    return image.copy(id: id);

  }

  Future<Images> readImage(int id) async {
    final db = await instance.database;

    final maps = await db.query('Images ', columns: Images.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return Images.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<Images>> readAllImages() async {

    final db = await instance.database;

    final maps = await db.query('Images', orderBy: 'id ASC');

    return maps.map((json) => Images.fromJson(json)).toList();
  }

  Future<int> updateImage(Images image) async {

    final db = await instance.database;

    return db.update('Images', image.toJson(), where: "id = ?", whereArgs: [image.id],);

  }

  Future<int> deleteImage(int id) async {

    final db = await instance.database;

    return await db.delete('Images', where: "id = ?", whereArgs: [id]);

  }

  Future<Description> createDescription(Description des) async {

    final db = await instance.database;

    final id = await db.insert('Description', des.toJson());
    return des.copy(id: id);

  }

  Future<Description> readDescription(int id) async {
    final db = await instance.database;

    final maps = await db.query('Description ', columns: Description.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return Description.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<Description>> readAllDescription() async {

    final db = await instance.database;

    final maps = await db.query('Description', orderBy: 'id ASC');

    return maps.map((json) => Description.fromJson(json)).toList();
  }

  Future<int> updateDescription(Description des) async {

    final db = await instance.database;

    return db.update('Description', des.toJson(), where: "id = ?", whereArgs: [des.id],);

  }

  Future<int> deleteDescription(int id) async {

    final db = await instance.database;

    return await db.delete('Description', where: "id = ?", whereArgs: [id]);

  }

  Future<Titles> createTitle(Titles title) async {

    final db = await instance.database;

    final id = await db.insert('Title', title.toJson());
    return title.copy(id: id);

  }

  Future<Titles> readTitle(int id) async {
    final db = await instance.database;

    final maps = await db.query('Title ', columns: Titles.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return Titles.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<Titles>> readAllTitle() async {

    final db = await instance.database;

    final maps = await db.query('Title', orderBy: 'id ASC');

    return maps.map((json) => Titles.fromJson(json)).toList();
  }

  Future<int> updateTitle(Titles title) async {

    final db = await instance.database;

    return db.update('Title', title.toJson(), where: "id = ?", whereArgs: [title.id],);

  }

  Future<int> deleteTitle(int id) async {

    final db = await instance.database;

    return await db.delete('Title', where: "id = ?", whereArgs: [id]);

  }

  Future<Subject> createSubject(Subject subject) async {

    final db = await instance.database;

    final id = await db.insert('Subject', subject.toJson());
    return subject.copy(id: id);

  }

  Future<Subject> readSubject(int id) async {
    final db = await instance.database;

    final maps = await db.query('Subject ', columns: Subject.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return Subject.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<Subject>> readAllSubjects() async {

    final db = await instance.database;

    final maps = await db.query('Subject', orderBy: 'id ASC');

    return maps.map((json) => Subject.fromJson(json)).toList();
  }

  Future<int> deleteSubject(int id) async {

    final db = await instance.database;

    return await db.delete('Subject', where: "id = ?", whereArgs: [id]);

  }

  Future<Topics> createTopics(Topics topic) async {

    final db = await instance.database;

    final id = await db.insert('Topics', topic.toJson());
    return topic.copy(id: id);

  }

  Future<Topics> readTopic(int id) async {
    final db = await instance.database;

    final maps = await db.query('Topics ', columns: Topics.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return Topics.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<Topics>> readAllTopics() async {

    final db = await instance.database;

    final maps = await db.query('Topics', orderBy: 'id ASC');

    return maps.map((json) => Topics.fromJson(json)).toList();
  }

  Future<int> deleteTopics(int id) async {

    final db = await instance.database;

    return await db.delete('Topics', where: "id = ?", whereArgs: [id]);

  }

  Future<QnA> createQnA(QnA qna) async {

    final db = await instance.database;

    final id = await db.insert('QnA', qna.toJson());
    return qna.copy(id: id);

  }

  Future<QnA> readQnA(int id) async {
    final db = await instance.database;

    final maps = await db.query('QnA ', columns: QnA.value, where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return QnA.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id could not be found');
    }
  }

  Future<List<QnA>> readAllQnAs() async {

    final db = await instance.database;

    final maps = await db.query('QnA', orderBy: 'id ASC');

    return maps.map((json) => QnA.fromJson(json)).toList();
  }

  Future<int> deleteQnA(int id) async {

    final db = await instance.database;

    return await db.delete('QnA', where: "id = ?", whereArgs: [id]);

  }

  Future close() async {
    final db = await instance.database;

    db.close();

  }


}

/*
  *
  * TESTING AREA AND IMPLEMENTING DATA
  *
  * await print("what field"()) to check whether INSERT or DELETION or UPDATE was successful
  *
  * */



