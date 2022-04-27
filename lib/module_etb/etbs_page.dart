import 'package:einsatz_helper/module_etb/data_box.dart';
import 'package:einsatz_helper/module_etb/etb_dialog.dart';
import 'package:einsatz_helper/module_etb/model/etb_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ETBsPage extends StatelessWidget {
  const ETBsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfItems = 10;

    return Scaffold(
      //backgroundColor: Theme.of(context).indicatorColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Einsatztagebücher'),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search pressed')));
              },
              icon: Icon(Ionicons.search)),
        ],
      ),
      body: ValueListenableBuilder<Box<ETBData>>(
        valueListenable: DataBox.getETBs().listenable(),
        builder: (context, box, _) {
          final etbs = box.values.toList().cast<ETBData>();
          return buildETBListView(etbs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => ETBDialog(onClickedDone: addETB)),
      ),
    );
  }

  Widget buildETBListView(List<ETBData> etbs) {
    if (etbs.isEmpty) {
      return Center(
        child: Text(
          'Noch kein ETB vorhanden.',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: etbs.length,
          itemBuilder: (BuildContext context, int index) {
            return buildETBOverviewCard(context, etbs[index], etbs[index].id,
                etbs[index].finished, etbs[index].name);
          });
    }
  }

  Future addETB(String name, double amount, bool isExpense) async {
    final etb = ETBData()
      ..name = name
      ..attachmentsCount = 2
      ..finished = isExpense
      ..id = amount.toInt()
      ..leader = 'Max Mustermann'
      ..etbWriter = 'Maxi Musterschreiber'
      ..startedDate = DateTime(2022, 05, 24);
    final etbDB = DataBox.getETBs();
    etbDB.add(etb); // Auto key
    //box.put('myKey', etb) // Individual key
  }

  // Delete a ETB with all its entries
  Future deleteETB(context, ETBData etb) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Einsatztagebuch löschen?'),
        content: Text(
            'Wollen Sie wirklich das Einsatztagebuch "${etb.name}" löschen?'),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              etb.delete();
              Navigator.pop(context, 'OK');
            },
            child: const Text('Löschen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );
  }

// Builds a Card Widget for an ETB Overview
  Widget buildETBOverviewCard(
          context, ETBData etb, int etbID, bool finished, String name) =>
      Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 1,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                    padding: const EdgeInsets.all(0),
                    label: Text('$etbID'),
                    labelStyle:
                        TextStyle(color: Theme.of(context).indicatorColor),
                    backgroundColor: Theme.of(context).dividerColor,
                    elevation: 1.0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  //Spacer(),
                  buildETBStatusChip(finished, context),
                ],
              ),
              //SizedBox(height: 8,),
              Row(
                children: [
                  Text(
                    'Einsatzbeginn: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('261814Feb22'),
                ],
              ),
              Wrap(
                children: [
                  Text(
                    'Einsatzleitung: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Manuela Musterfrau')
                ],
              ),
              Wrap(
                children: [
                  Text(
                    'ETB-Führung: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Max Mustermann')
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                    labelPadding:
                        EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
                    //padding: EdgeInsets.all(0),
                    avatar: Icon(
                      Ionicons.file_tray_full,
                      color: Theme.of(context).indicatorColor.withOpacity(0.8),
                      size: 16,
                    ),
                    label: Text('4 Einträge'),
                    labelStyle:
                        TextStyle(color: Theme.of(context).indicatorColor),
                    backgroundColor: Theme.of(context).dividerColor,
                    elevation: 1.0,
                    //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                    labelPadding:
                        EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
                    //padding: EdgeInsets.all(0),
                    avatar: Icon(
                      Ionicons.attach,
                      color: Theme.of(context).indicatorColor.withOpacity(0.8),
                      size: 16,
                    ),
                    label: Text('2 Anlagen'),
                    labelStyle:
                        TextStyle(color: Theme.of(context).indicatorColor),
                    backgroundColor: Theme.of(context).dividerColor,
                    elevation: 1.0,
                    //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                    labelPadding:
                        EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
                    avatar: const Icon(
                      Ionicons.share,
                      size: 16,
                    ),
                    label: Text('Exportiren'),
                    //labelStyle: TextStyle(color: Colors.white),
                    //backgroundColor: Theme.of(context).unselectedWidgetColor,
                    elevation: 1.0,
                    //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  ActionChip(
                    label: const Text('Löschen'),
                    onPressed: () => deleteETB(context, etb),
                    visualDensity:
                        const VisualDensity(horizontal: 0.0, vertical: -4),
                    labelPadding: const EdgeInsets.all(1)
                        .copyWith(right: 8, top: 0, bottom: 0),
                    avatar: const Icon(
                      Ionicons.trash,
                      //Icons.delete,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

// Build a Chip depending on the current status ('Laufend' or 'Abgeschlossen') of the ETB
  Chip buildETBStatusChip(bool finished, context) {
    if (finished) {
      return Chip(
        label: Text('Abgeschlossen'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).errorColor.withOpacity(0.7),
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(2),
        elevation: 1.0,
      );
    } else {
      return Chip(
        label: Text('Laufend'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(2),
        elevation: 1.0,
      );
    }
  }
}
