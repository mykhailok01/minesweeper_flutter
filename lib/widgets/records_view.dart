import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/data/records_provider.dart';
import 'package:minesweeper_in_flutter/widgets/record_tile.dart';
import 'package:provider/provider.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: context
          .watch<List<Record>>()
          .map(
            (record) => RecordTile(record),
          )
          .toList(),
    );
  }
}
