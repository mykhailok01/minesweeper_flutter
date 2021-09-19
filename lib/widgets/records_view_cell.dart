import 'package:flutter/material.dart';

class RecordsViewCell extends StatelessWidget {
  const RecordsViewCell({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
