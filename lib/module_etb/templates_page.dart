import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data_box.dart';
import 'model/template_data.dart';
import 'pages/add_template_page.dart';
import 'utils/global_variables.dart' as globals;

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addDefaultTemplates();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vorlagen'),
        leading: IconButton(
            onPressed: () {
              globals.scaffoldKey.currentState?.openDrawer();
            },
            icon: const FaIcon(Ionicons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Funktion noch nicht implementiert.')));
              },
              icon: const FaIcon(Ionicons.search)),
        ],
      ),
      body: ValueListenableBuilder<Box<TemplateData>>(
        valueListenable: DataBox.getTemplates().listenable(),
        builder: (context, box, _) {
          final templates = box.values.toList().cast<TemplateData>();
          return buildTemplateListView(context, templates);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTemplatePage())),
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTemplateListView(context, List<TemplateData> templates) {
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
              const SizedBox(height: 8),
              OutlinedButton.icon(
                  label: const Text('Vorlage erstellen'),
                  icon: const FaIcon(Ionicons.add_outline),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTemplatePage())),
                      }),
            ],
          ),
        ),
      );
    } else {
      var templatesReversed = List<TemplateData>.from(templates.reversed);
      return ListView.separated(
          padding: const EdgeInsets.all(0),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 1, thickness: 2),
          itemCount: templates.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(templates[index].name),
              trailing: const FaIcon(Ionicons.chevron_forward),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTemplatePage(
                              templateKey: templates[index].key,
                            ))),
              },
            );
          });
    }
  }

  // Add some default templates if not already present.
  void addDefaultTemplates() {
    List<TemplateData> defaultTemplates = [
      TemplateData.build(
          id: 'a',
          name: 'Abfahrt vom Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description: 'Abfahrt vom Ortsverband.'),
      TemplateData.build(
          id: 'b',
          name: 'Ankunft am Einsatzort',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description: 'Ankunft am Einsatzort.'),
      TemplateData.build(
          id: 'c',
          name: 'Erkundung des Einsatzortes',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description: 'Erkundung des Einsatzort'),
      TemplateData.build(
          id: 'd',
          name: 'Rückfahrt zum Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          counterpart: 'LuK-Ortsverband',
          description:
              'Abfahrt an LuK-Ortsverband gemeldet. Rückfahrt zum Ortsverband.'),
      TemplateData.build(
          id: 'e',
          name: 'Ankunft am Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description:
              'Ankunft am Ortsverband. Herstellen der Einsatzbereitschaft.'),
      TemplateData.build(
          id: 'f',
          name: 'Einsatzabschlussmeldung',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          counterpart: 'LuK-Ortsverband',
          description:
              'Einsatzbereitschaft wiederhergestellt, Einsatzabschlussmeldung in Anlage an LuK-Ortsverband weitergeleitet.'),
    ];

    for (var template in defaultTemplates) {
      if (!DataBox.getTemplates().containsKey(template.id)) {
        DataBox.getTemplates().put(template.id, template);
      }
    }
  }
}
