import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tictactoe extends StatefulWidget {
  const Tictactoe({super.key});
  @override
  State<Tictactoe> createState() {
    return _Tictactoe();
  }
}

class _Tictactoe extends State<Tictactoe> {
  String status = "player X's turn";
  List<String> board = List.filled(9, "");
  List<int> moves = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  void fill(int index) {
    setState(() {
      if (moves.contains(index)) {
        board[index] = "X";
        moves.remove(index);
        // check win after x plays
        if (iswin("X") == true) {
          status = "You win";
          return;
        }
        if (iswin("O") == true) {
          status = "you lose";
          return;
        }
        if (moves.isEmpty) {
          status = "draw";
          return;
        }
        // is win is checked first after x turn
        // now we'll fill O
        moves.shuffle();
        index = moves[0];
        moves.removeAt(0);
        board[index] = "O";
        if (iswin("X")) {
          status = "you win";
          return;
        }
        if (iswin("O")) {
          status = "you lose";
          return;
        }
        if (moves.isEmpty) {
          status = "draw";
          return;
        }
      }
    });
  }

  void reset() {
    setState(() {
      board = List.filled(9, "");
      moves = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    });
  }

  bool iswin(String winner) {
    List<List<int>> combinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (List c in combinations) {
      if (board[c[0]] == winner &&
          board[c[1]] == winner &&
          board[c[2]] == winner) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: const Text(
          "TIC TAC TOE",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(
          //  height: 50,
          //),
          const SizedBox(height: 50),
          Flexible(
            flex: 2,
            child: Text(
              status,
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            // Wrap GridView.builder with Expanded
            flex: 6,
            child: Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => fill(index),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          //border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              //offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            board[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),

          // RESET BUTTON

          Flexible(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                minimumSize: const Size(160, 60),
                backgroundColor: Colors.blueGrey[800],
              ),
              onPressed: reset,
              child: const Text(
                "RESET",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
