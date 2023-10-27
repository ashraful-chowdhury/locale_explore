import 'package:flutter/material.dart';
import 'package:locale_explore/nstack/nstack.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.defaultSection.home),
          backgroundColor: Colors.amber.shade200,
        ),
        body: Center(
          child: Text(context.localization.defaultSection.hello),
        ),
      ),
    );
  }
}
