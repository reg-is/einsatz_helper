import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/data_box.dart';
import '../../model/template_data.dart';
import 'add_template_page.dart';
import '../../utils/global_variables.dart' as globals;

/// Page showing a list of all templates.
class TemplatesPage extends StatelessWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  /// Build page with a list of all templates.
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
          // Search button
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
      // Button to create new template
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TemplateDetailsPage())),
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build a ListView of [templates].
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
                                builder: (context) => TemplateDetailsPage())),
                      }),
            ],
          ),
        ),
      );
    } else {
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
                        builder: (context) => TemplateDetailsPage(
                              templateKey: templates[index].key,
                            ))),
              },
            );
          });
    }
  }

  /// Add default templates if they are not already available.
  void addDefaultTemplates() {
    List<TemplateData> defaultTemplates = [
      TemplateData.build(
          id: 'a',
          name: 'Abfahrt vom Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description: 'Abfahrt vom Ortsverband.'),
      TemplateData.build(
          id: 'a2',
          name: 'Abfahrt vom Gerätehaus',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description: 'Abfahrt vom Gerätehaus.'),
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
          description: 'Erkundung des Einsatzortes.'),
      TemplateData.build(
          id: 'd',
          name: 'Rückfahrt zum Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          counterpart: 'LuK-Ortsverband',
          description:
              'Abfahrt an LuK-Ortsverband gemeldet. Rückfahrt zum Ortsverband.'),
      TemplateData.build(
          id: 'd2',
          name: 'Rückfahrt zum Gerätehaus',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          counterpart: 'Leitstelle',
          description:
              'Abfahrt an Leitstelle gemeldet. Rückfahrt zum Gerätehaus.'),
      TemplateData.build(
          id: 'e',
          name: 'Ankunft am Ortsverband',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description:
              'Ankunft am Ortsverband. Herstellen der Einsatzbereitschaft.'),
      TemplateData.build(
          id: 'e2',
          name: 'Ankunft am Gerätehaus',
          creationTime: DateTime(2022),
          modificationTime: DateTime(2022),
          description:
              'Ankunft am Gerätehaus. Herstellen der Einsatzbereitschaft.'),
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
