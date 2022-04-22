import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

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
      //body: buildETBOverviewCard(context),
      body: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: numberOfItems,
        itemBuilder: (BuildContext context, int index){
          return buildETBOverviewCard(context, numberOfItems - index, index.isEven);
        }),
    );
  }
}

// Builds a Card Widget for an ETB Overview
Widget buildETBOverviewCard(context, int etbID, bool finished) => Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 4,
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
                      'Einsatzname Nr. $etbID',
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
                  avatar: Icon(
                    Ionicons.share,
                    size: 16,
                  ),
                  label: Text('Exportiren'),
                  //labelStyle: TextStyle(color: Colors.white),
                  //backgroundColor: Theme.of(context).unselectedWidgetColor,
                  elevation: 1.0,
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ],
        ),
      ),
    );

// Build a Chip depending on the current status ('Laufend' or 'Abgeschlossen') of the ETB
Widget buildETBStatusChip(bool finished, context) {
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
