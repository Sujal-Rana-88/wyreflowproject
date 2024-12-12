import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/flash_card_model.dart';

class StorageService {
  final String _key = 'flashcards';

  Future<List<Flashcard>> getFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      return jsonList.map((e) => Flashcard.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> saveFlashcards(List<Flashcard> flashcards) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = flashcards.map((e) => e.toJson()).toList();
    prefs.setString(_key, jsonEncode(jsonList));
  }
}
