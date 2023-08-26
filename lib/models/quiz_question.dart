// import 'dart:math';

class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.correctAnswer, this.score);

  final String text;
  final List<String> answers;
  final String correctAnswer;
  final int score;

  // List<String> get shuffledAnswer {
  //   final shuffledList = List.of(answers);
  //   shuffledList.shuffle(Random());
  //   return shuffledList;
  // }
}
