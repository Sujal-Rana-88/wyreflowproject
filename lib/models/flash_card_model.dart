class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});

  // Convert Flashcard to JSON
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  // Create Flashcard from JSON
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
    );
  }
}
