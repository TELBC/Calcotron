import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

// List<String> searchedmethods = [];
// List<String> existingmethods = [
//   'Linear Functions',
//   'Polynomials',
//   'Equations',
//   'Something else 0',
//   'Something else 1',
//   'Something else 2',
//   'Something else 3',
//   'Something else 4',
//   'Something else 5'
// ];

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
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64),
        // This is where we show the actual page
      ),
    );
  }
}
