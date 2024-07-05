import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tictactoe(),
    ),
  );
}
