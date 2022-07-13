import 'package:flutter/material.dart';
import 'package:xo/game_logic.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String activePlayer = "x";
  int turn = 0;
  String result = '';
  bool gameOver = false;
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              value: isSwitched,
              onChanged: (val) {
                setState(() {
                  isSwitched = val;
                });
              },
              title: const Text(
                "Turn on/off auto player",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              activeColor: Colors.orangeAccent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "it's   ".toUpperCase(),
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "$activePlayer   ",
                  style: const TextStyle(
                      fontSize: 60,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "turn".toUpperCase(),
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
                children: List.generate(
                    9,
                    (index) => InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap:
                              gameOver ? null : () async => await onTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).shadowColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              Player.playerX.contains(index)
                                  ? "X"
                                  : Player.playerO.contains(index)
                                      ? "O"
                                      : "",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Player.playerX.contains(index)
                                      ? Colors.blue
                                      : Player.playerO.contains(index)
                                          ? Colors.pink
                                          : Colors.blue),
                            )),
                          ),
                        )),
              ),
            ),
            Text(
              result,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent)),
              icon: const Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  Player.playerX.clear();
                  Player.playerO.clear();
                  activePlayer = "x";
                  turn = 0;
                  result = '';
                  gameOver = false;
                });
              },
              label: const Text("Repeat the game"),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void switchPlayerRole() {
    setState(() {
      activePlayer = activePlayer == "x" ? "o" : "x";
      turn++;
      String winner = game.checkWinner();

      if (winner != "") {
        result = "winner is ${winner.toUpperCase()} player";
        gameOver = true;
      } else {
        if (turn == 9) {
          result = "no winners";
        }
      }
    });
  }

  onTap(int index) {
    if ((!Player.playerX.contains(index) || Player.playerX.isEmpty) &&
        (!Player.playerO.contains(index) || Player.playerO.isEmpty)) {
      game.playGame(index, activePlayer);
      switchPlayerRole();
      if (isSwitched && !gameOver && turn != 9) {
        game.autoPlay(activePlayer);
        switchPlayerRole();
      }
    }
  }
}
