import 'package:flutter/material.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vorlagen'),
      ),
      body: const Center(
        child: Text(
          'Vorlagen',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
