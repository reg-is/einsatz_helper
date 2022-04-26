import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:einsatz_helper/module_etb/entry_details_page.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfItems = 10;

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
      body: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: numberOfItems,
          itemBuilder: (BuildContext context, int index) {
            return buildEntryCard(
                context,
                numberOfItems - index,
                '261814Feb22',
                'Platzhalter Inhat des Eintrages, Erkundung des Einsatzortes. Gefahrenquelle im Keller gefunden. Erkundung des Einsatzortes. Gefahrenquelle im Keller gefunden. Erkundung des Einsatzortes. Gefahrenquelle im Keller gefunden. Erkundung des Einsatzortes. Gefahrenquelle im Keller gefunden.',
                index);
          }),
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

// Builds a Card Widget for an ETB Entry
Widget buildEntryCard(BuildContext context, int entryID, String tacticalTime,
        String content, int attachments) =>
    InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EntryDetailsPage(entryID, tacticalTime, content)));
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 4,
            runSpacing: 1,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Chip with the number of the ETB-Entry
                  Chip(
                    visualDensity:
                        const VisualDensity(horizontal: 0.0, vertical: -4),
                    padding: const EdgeInsets.all(0),
                    label: Text('$entryID'),
                    labelStyle:
                        TextStyle(color: Theme.of(context).indicatorColor),
                    backgroundColor: Theme.of(context).dividerColor,
                    elevation: 1.0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  // Text box with the date and time of the entry
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tacticalTime,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  // Chip with the number of attachments of the entry
                  buildAttachmentsChip(attachments),
                ],
              ),
              // Text box with the content of the entry
              Text(
                content,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );

// Build a Chip depending on number of attachments an entry has
Widget buildAttachmentsChip(int attachments) {
  if (attachments > 0) {
    return Chip(
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
      labelPadding:
          const EdgeInsets.all(1).copyWith(right: 8, top: 0, bottom: 0),
      avatar: const Icon(
        Ionicons.attach,
        size: 16,
      ),
      label: (attachments == 1)
          ? Text(attachments.toString() + ' Anlage')
          : Text(attachments.toString() + ' Anlagen'),
      //labelStyle: TextStyle(color: Colors.white),
      //backgroundColor: Theme.of(context).unselectedWidgetColor,
      elevation: 1.0,
      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  } else {
    // Display no Attachment Chip if there are no Attachments
    return const SizedBox.shrink();
  }
}
