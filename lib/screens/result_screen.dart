import 'package:flutter/material.dart';
import 'package:hcrl_quiz_app/models/quiz_question.dart';
import 'package:hcrl_quiz_app/widgets/question_summary/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.chooseAnswer,
    required this.onRestart,
    required this.questions,
    required this.onBack,
  });

  final List<String> chooseAnswer;
  final void Function() onRestart;
  final void Function() onBack;
  final List<QuizQuestion> questions;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chooseAnswer.length; i++) {
      final isCorrectAnswer = chooseAnswer[i] == questions[i].correctAnswer;

      summary.add({
        'question_index': i + 1,
        'question': questions[i].text,
        'correct_answer': questions[i].correctAnswer,
        'user_answer': chooseAnswer[i],
        'is_correct': isCorrectAnswer,
        'score': questions[i].score,
      });
    }
    return summary;
  }

  int calculateUserScore() {
    int userScore = 0;
    for (var i = 0; i < questions.length; i++) {
      if (summaryData[i]['is_correct'] as bool) {
        userScore += questions[i].score;
      }
    }
    return userScore;
  }

  int calculateMaxScore() {
    int maxScore = 0;
    for (var i = 0; i < questions.length; i++) {
      maxScore += questions[i].score;
    }
    return maxScore;
  }

  bool passQuiz(int userScore, int maxScore) {
    if (userScore > (maxScore / 2)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestion =
        summaryData.where((data) => data['is_correct'] == true).length;
    final userScore = calculateUserScore();
    final maxScore = calculateMaxScore();

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              'You answered correctly  $numCorrectQuestion out of $numTotalQuestions',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Score: $userScore of $maxScore',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    passQuiz(userScore, maxScore) ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            QuestionSummary(summaryData),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz'),
            ),
            TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}
