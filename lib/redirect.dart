import 'dart:ui';
import 'package:flutter/material.dart';

class Redirect extends StatefulWidget {
  const Redirect({Key? key, required this.title, required this.text})
      : super(key: key);
  final String title;
  final String text;

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black26,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 6.0,
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DefaultTextStyle(
                child: Text(widget.text),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            InkWell(
              onTap: () async {
                await showDialog(
                    context: context, builder: (_) => const ImageDialogue(image: 'img/Calcotron_Logo.png',));
              },
              child: Container(
                height: 100.0,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: ExactAssetImage('img/Calcotron_Logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDialogue extends StatelessWidget {
  const ImageDialogue({Key? key, required this.image}) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      backgroundColor: Colors.white,
      child: Image(
        image:AssetImage(image),
        fit: BoxFit.contain,
      ),
    );
  }
}
