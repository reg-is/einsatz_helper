import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einträge'),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter pressed')));
              },
              icon: Icon(Ionicons.funnel)),
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
          'Einträge',
          style: TextStyle(fontSize: 60),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo
        },
        child: const Icon(Icons.add),
        //child: const Icon(Feather.plus),
        //child: const Icon(Ionicons.add),
        //child: const Icon(Fontisto.bookmark),
      ),
    );
  }
}
