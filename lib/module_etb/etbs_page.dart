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
      body: buildETBOverviewCard(context),
    );
  }
}

Widget buildETBOverviewCard(context) => Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 4,
          runSpacing: 1,
          //mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.start,
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Einsatzname',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                //Spacer(),
                const Chip(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  padding: EdgeInsets.all(2),
                  label: Text('Laufend'),
                  elevation: 1.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
              height: 8,
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
                    color: Colors.white,
                    size: 16,
                  ),
                  label: Text('4 Einträge'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
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
                    color: Colors.white,
                    size: 16,
                  ),
                  label: Text('2 Anlagen'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Theme.of(context).unselectedWidgetColor,
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
