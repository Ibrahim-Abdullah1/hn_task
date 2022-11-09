import 'package:flutter/material.dart';

class preprocc extends StatefulWidget {
  const preprocc({Key? key}) : super(key: key);

  @override
  State<preprocc> createState() => _preproccState();
}

class _preproccState extends State<preprocc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("preprocessing page"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
      ),
    );
  }
}