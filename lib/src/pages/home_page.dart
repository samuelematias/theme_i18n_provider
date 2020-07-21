import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Example App"), actions: [CycleThemeIconButton()]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello!',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
