import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class ETBsPage extends StatelessWidget {
  const ETBsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
          child: buildETBOverviewCard(context)),
    );
  }
}

Widget buildETBOverviewCard(context) => Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                  padding: const EdgeInsets.all(0),
                  label: Text('42'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
                  elevation: 1.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  'Einsatz Petresweg 32',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Chip(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  padding: EdgeInsets.all(2),
                  label: Text('Laufender Einsatz'),
                  elevation: 1.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Einsatzbeginn: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('261814Feb22')
              ],
            ),
            Row(
              children: [Text('Einsatzleitung: '), Text('Manuela Musterfrau')],
            ),
            Row(
              children: [Text('ETB-Führung: '), Text('Max Mustermann')],
            ),
            Row(
              children: [
                Chip(
                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                  padding: EdgeInsets.all(2),

                  label: Text('4 Einträge'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
                  elevation: 1.0,
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Chip(
                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                  padding: EdgeInsets.all(2),

                  label: Text('2 Anlagen'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
                  elevation: 1.0,
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Chip(
                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                  padding: EdgeInsets.all(2),

                  label: Text('4 Einträge'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
                  elevation: 1.0,
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            )
          ],
        ),
      ),
    );
