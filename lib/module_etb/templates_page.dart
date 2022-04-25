import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfItems = 10;

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
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1, thickness: 2),
        padding: EdgeInsets.all(0),
        itemCount: numberOfItems,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Vorlage Name'),
            trailing: Icon(Ionicons.chevron_forward),
            onTap: () {
              // ToDo
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ToDo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
