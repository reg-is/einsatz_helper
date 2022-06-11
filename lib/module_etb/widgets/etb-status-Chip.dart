import 'package:flutter/material.dart';

/// Build a Chip depending on the current status  of the ETB stored inside [finished]
/// Return a Chip with 'Laufend' or 'Abgeschlossen'.
Chip etbStatusChip(bool finished, BuildContext context) {
  if (finished) {
    return Chip(
      label: const Text('Abgeschlossen'),
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Theme.of(context).errorColor.withOpacity(0.7),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(2),
      elevation: 1.0,
    );
  } else {
    return Chip(
      label: const Text('Laufend'),
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(2),
      elevation: 1.0,
    );
  }
}
