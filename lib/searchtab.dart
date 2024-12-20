import 'package:calcotron/redirect.dart';
import 'package:calcotron/redirect2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Database.dart';
import 'main.dart';

class MySearchBar extends SearchDelegate {
  MySearchBar(
      {required this.id,
      required this.images,
      required this.description,
      required this.title,
      required this.subject,
      required this.topics,
      required this.qna});

  final int id;
  final List<Images> images;
  final List<Description> description;
  final List<Titles> title;
  final List<Subject> subject;
  final List<Topics> topics;
  final List<QnA> qna;

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

  List<String> change_methods(List<String> all) {
    if (query.isEmpty) {
      if (searchedmethods.isEmpty) {
        return existingmethods;
      } else {
        return searchedmethods;
      }
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
    List<String> _methods = change_methods(existingmethods);

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
                      onTap: () async {
                        if (!searchedmethods.contains(method)) {
                          searchedmethods.add(method);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setStringList("searched", searchedmethods);
                        }
                        query = method;
                        showResults(context);
                      },
                      trailing: query.isNotEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white54),
                              onPressed: () async {
                                setState(() {
                                  searchedmethods.remove(method);
                                  _methods.remove(method);
                                });
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setStringList(
                                    "searched", searchedmethods);
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
    int index = existingmethods.indexOf(query);
    return Redirect2(
      id: index,
      images: images,
      description: description,
      title: title,
      subject: subject,
      topics: topics,
      qna: qna,
    );
  }
}
