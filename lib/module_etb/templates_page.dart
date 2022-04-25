import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vorlagen'),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search pressed')));
              },
              icon: Icon(Ionicons.search)),
        ],
      ),
      body: const Center(
        child: Text(
          'Vorlagen',
          style: TextStyle(fontSize: 60),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
