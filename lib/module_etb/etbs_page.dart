import 'package:flutter/material.dart';

class ETBsPage extends StatelessWidget {
  const ETBsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ETBs'),
      ),
      body: const Center(
        child: Text(
          'ETB',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
