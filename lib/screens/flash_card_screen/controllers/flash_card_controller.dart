import 'package:get/get.dart';

import '../../../models/flash_card_model.dart';
import '../../../services/storage_service.dart';
class FlashCardController extends GetxController {
  final StorageService _storageService = StorageService();
  var flashcards = <Flashcard>[].obs;
  var showAnswer = false.obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    final loadedFlashcards = await _storageService.getFlashcards();
    flashcards.assignAll(loadedFlashcards);
  }

  Future<void> _saveFlashcards() async {
    await _storageService.saveFlashcards(flashcards);
  }

  void addFlashcard(String question, String answer) {
    flashcards.add(Flashcard(question: question, answer: answer));
    _saveFlashcards();
  }

  void editFlashcard(int index, String question, String answer) {
    flashcards[index] = Flashcard(question: question, answer: answer);
    _saveFlashcards();
    update();
  }

  void deleteFlashcard(int index) {
    flashcards.removeAt(index);
    _saveFlashcards();
  }

  void toggleAnswer() {
    showAnswer.value = !showAnswer.value;
  }

  void nextFlashcard() {
    currentIndex.value = (currentIndex.value + 1) % flashcards.length;
  }

  void previousFlashcard() {
    currentIndex.value =
        (currentIndex.value - 1 + flashcards.length) % flashcards.length;
  }

}
