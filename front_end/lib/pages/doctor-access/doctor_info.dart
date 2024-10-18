import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Info"),
      ),
      body: Container(
        child: const Text("Doctor specialty, bio, etc."),
      ),
    );
  }
}