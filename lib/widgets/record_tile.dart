import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/data/records_provider.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(
    this.record, {
    Key? key,
  }) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    var local = record.dateTime.toLocal();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('${record.duration.inSeconds}'),
        Text('${local.hour}:${local.minute} ${local.day}.'
            '${local.month}.${local.year}'),
      ],
    );
  }
}
