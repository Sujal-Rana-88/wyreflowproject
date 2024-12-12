import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flash_card_controller.dart';

class FlashcardScreen extends StatelessWidget {
  final FlashCardController controller = Get.put(FlashCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: Obx(() {
        if (controller.flashcards.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Flashcards',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Show Add Flashcard Dialog
                    _showAddFlashcardDialog(context);
                  },
                  child: const Text('Add Flashcard'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: controller.toggleAnswer,
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        controller.showAnswer.value
                            ? controller
                                .flashcards[controller.currentIndex.value]
                                .answer
                            : controller
                                .flashcards[controller.currentIndex.value]
                                .question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.previousFlashcard,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: controller.nextFlashcard,
                  child: const Text('Next'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Show confirmation dialog before deleting
                    _showDeleteConfirmationDialog(
                        context, controller.currentIndex.value);
                  },
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show Edit Flashcard Dialog
                    _showEditFlashcardDialog(
                        context, controller.currentIndex.value);
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show Add Flashcard Dialog
                _showAddFlashcardDialog(context);
              },
              child: const Text('Add Flashcard'),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  void _showAddFlashcardDialog(BuildContext context) {
    String question = '';
    String answer = '';
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Flashcard'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Question'),
                  onChanged: (value) {
                    question = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Answer'),
                  onChanged: (value) {
                    answer = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  controller.addFlashcard(question, answer);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditFlashcardDialog(BuildContext context, int index) {
    String question = controller.flashcards[index].question;
    String answer = controller.flashcards[index].answer;
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Flashcard'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: question,
                  decoration: const InputDecoration(labelText: 'Question'),
                  onChanged: (value) {
                    question = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: answer,
                  decoration: const InputDecoration(labelText: 'Answer'),
                  onChanged: (value) {
                    answer = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  controller.editFlashcard(index, question, answer);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this flashcard?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Proceed with deletion
                controller.deleteFlashcard(index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
