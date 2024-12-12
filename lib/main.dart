import 'package:flutter/material.dart';
import 'package:wreflowproject/screens/flash_card_screen/views/flash_card_screen.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FlashcardScreen(),
    );
  }
}
