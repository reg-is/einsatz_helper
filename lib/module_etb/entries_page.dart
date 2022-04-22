import 'package:flutter/material.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einträge'),
      ),
      body: const Center(
        child: Text(
          'Einträge',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
