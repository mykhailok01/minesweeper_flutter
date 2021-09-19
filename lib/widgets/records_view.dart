import 'package:flutter/rendering.dart';
import 'package:minesweeper_in_flutter/data/records_provider.dart';
import 'package:minesweeper_in_flutter/widgets/record_tile.dart';
import 'package:minesweeper_in_flutter/widgets/records_view_cell.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var records = context.watch<List<Record>>();
    records.sort(
      (record1, record2) => record1.duration.compareTo(record2.duration),
    );

    int number = 1;
    if (records.length == 0) {
      return Center(
        child: Text(
          'No records yet, try harder!',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RecordsViewCell(text: 'Number'),
            RecordsViewCell(text: 'Duration'),
            RecordsViewCell(text: 'Date'),
          ],
        ),
        Expanded(
          child: ListView(
            children: records
                .map(
                  (record) => RecordTile(number++, record),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
