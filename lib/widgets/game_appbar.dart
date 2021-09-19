import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/widgets/records_page.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({Key? key}) : super(key: key);
  String _gameStatusToEmoji(GameStatus status) {
    switch (status) {
      case GameStatus.won:
        return '😀';
      case GameStatus.ongoing:
      case GameStatus.notStarted:
        return '🙂';
      case GameStatus.loosed:
        return '😐';
    }
  }

  @override
  Widget build(BuildContext context) {
    var game = context.watch<MinesweeperGame>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bombs: ${game.bombs}',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () => game.restart(),
            child: RichText(
              text: TextSpan(
                text: _gameStatusToEmoji(game.status),
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Text(
            'Time: ${game.time.toString().padLeft(4, '0').substring(0, 4)}',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    // return Provider(
                    //   create: (BuildContext context) =>
                    //       context.read<List<Record>>(),
                    //   builder: (BuildContext context, Widget? child) =>
                    return RecordsPage();
                    // );
                  },
                ),
              );
            },
            child: Icon(Icons.menu, size: 30),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
