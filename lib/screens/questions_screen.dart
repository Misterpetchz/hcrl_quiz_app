import 'package:flutter/material.dart';
import 'package:hcrl_quiz_app/models/quiz_question.dart';
import 'package:hcrl_quiz_app/services/database_service.dart';
import 'package:hcrl_quiz_app/widgets/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;

  final databaseService = DatabaseService();
  List<QuizQuestion> questionsList = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    List<QuizQuestion> fetchedQuestions =
        await databaseService.getAllQuestions();
    setState(() {
      questionsList = fetchedQuestions;
    });
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questionsList.isEmpty) {
      return const CircularProgressIndicator();
    }

    final currentQuestion = questionsList[currentQuestionIndex];
    final totalQuestions = questionsList.length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all((40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${currentQuestionIndex + 1} of $totalQuestions'),
            Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentQuestion.answers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: LinearProgressIndicator(
                value: currentQuestionIndex / totalQuestions,
                minHeight: 10,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
