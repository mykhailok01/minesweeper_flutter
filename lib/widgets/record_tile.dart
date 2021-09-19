import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/data/records_provider.dart';
import 'records_view_cell.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(
    this.number,
    this.record, {
    Key? key,
  }) : super(key: key);

  final Record record;
  final int number;

  @override
  Widget build(BuildContext context) {
    var local = record.dateTime.toLocal();

    var pad = (int val) => val.toString().padLeft(2, '0');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RecordsViewCell(text: '$number'),
          RecordsViewCell(text: '${record.duration.inSeconds} sec'),
          RecordsViewCell(
              text: '${pad(local.hour)}:${pad(local.minute)} ${pad(local.day)}.'
                  '${pad(local.month)}.${local.year}'),
        ],
      ),
    );
  }
}
