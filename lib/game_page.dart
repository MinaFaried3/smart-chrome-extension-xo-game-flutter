import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xo/game_logic.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  String activePlayer = "x";
  int turn = 0;
  String result = '';
  bool gameOver = false;
  Game game = Game();
  bool isSwitched = false;

  late AnimationController controller;
  late Animation<double> animation;
  int onTapIndex = -1;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..reverse()
          ..repeat();
    animation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: kIsWeb
              ? landScapeMode()
              : MediaQuery.of(context).orientation == Orientation.portrait
                  ? Column(
                      children: [
                        ...firstPart(),
                        Expanded(child: xoGrid(context)),
                        ...lastPart()
                      ],
                    )
                  : landScapeMode()),
    );
  }

  Widget landScapeMode() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [...firstPart(), ...lastPart()],
          ),
        ),
        Expanded(flex: 2, child: xoGrid(context)),
      ],
    );
  }

  List<Widget> lastPart() {
    return [
      if (result != "")
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            result,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton.icon(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
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
    ];
  }

  List<Widget> firstPart() {
    return [
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
    ];
  }

  Widget xoGrid(context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      children: List.generate(
          9,
          (index) => InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: gameOver ? null : () async => await onTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: onTapIndex == index
                          ? ScaleTransition(
                              scale: animation,
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
                              ),
                            )
                          : Text(
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
    // controller.forward();
    if ((!Player.playerX.contains(index) || Player.playerX.isEmpty) &&
        (!Player.playerO.contains(index) || Player.playerO.isEmpty)) {
      game.playGame(index, activePlayer);
      setState(() {
        onTapIndex = index;
      });
      switchPlayerRole();
      if (isSwitched && !gameOver && turn != 9) {
        game.autoPlay(activePlayer);
        switchPlayerRole();
      }
    }
  }
}
