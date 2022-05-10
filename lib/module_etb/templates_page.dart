import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data_box.dart';
import 'model/template_data.dart';
import 'pages/add_template_page.dart';

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
              icon: const Icon(Ionicons.search)),
        ],
      ),
      body: ValueListenableBuilder<Box<TemplateData>>(
        valueListenable: DataBox.getTemplates().listenable(),
        builder: (context, box, _) {
          final templates = box.values.toList().cast<TemplateData>();
          return buildETBListView(context, templates);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTemplatePage(isNewTemplate: true,))),
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildETBListView(context, List<TemplateData> templates) {
    if (templates.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Es wurden noch kein Vorlagen erstellt.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              OutlinedButton.icon(
                  label: const Text('Vorlage erstellen'),
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTemplatePage(isNewTemplate: true,))),
                      }),
            ],
          ),
        ),
      );
    } else {
      var templatesReversed = List<TemplateData>.from(templates.reversed);
      return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: templates.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(templates[index].name),
              trailing: Icon(Ionicons.chevron_forward),
              onTap: () => {
                // ToDo: Open details page with key: templates[index].key
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTemplatePage(isNewTemplate: false, templateKey: templates[index].key,))),
              },
            );
          });
    }
  }

  ListView buildListView(int numberOfItems) {
    return ListView.separated(
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
    );
  }
}
