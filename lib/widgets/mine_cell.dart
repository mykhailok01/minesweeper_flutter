import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';

class MineCell extends StatelessWidget {
  final int value;
  final double size;
  const MineCell({Key? key, required this.value, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: implement provider call
        throw UnimplementedError();
      },
      child: Container(
        color: value == Cells.closed
            ? Colors.lightBlue.shade300
            : Colors.lightBlue.shade50,
        margin: const EdgeInsets.all(1),
        width: size - 2,
        height: size - 2,
        child: Builder(builder: (_) {
          switch (value) {
            case Cells.bomb:
              return Icon(Icons.settings);
            case Cells.empty:
            case Cells.closed:
              return Container();
          }
          return Text('$value');
        }),
      ),
    );
  }
}
