// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hcrl_quiz_app/models/quiz_question.dart';
import 'package:hcrl_quiz_app/services/database_service.dart';
// import 'package:hcrl_quiz_app/widgets/radio_tile/radio_tile.dart';

class AddQuestions extends StatefulWidget {
  const AddQuestions({Key? key, required this.backToStartScreen})
      : super(key: key);

  final void Function() backToStartScreen;

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> answerControllers =
      List.generate(4, (_) => TextEditingController());

  String correctAnswer = '';
  int score = 1;
  String? selectedAnswer;

  void _submitQuestion() async {
    String questionText = questionController.text;
    List<String> answers =
        answerControllers.map((controller) => controller.text).toList();

    QuizQuestion newQuestion = QuizQuestion(
      questionText,
      answers,
      correctAnswer,
      score,
    );

    const path = 'questions';

    final databaseService = DatabaseService();
    await databaseService.createQuestion(path, newQuestion);

    widget.backToStartScreen();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedRadioValue;

    return SingleChildScrollView(
        child: SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Question',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'New Question'),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: ((context, index) {
                  return RadioListTile<String>(
                    value: answerControllers[index].text,
                    groupValue: selectedRadioValue,
                    onChanged: (value) {
                      setState(() {
                        selectedRadioValue = value!;
                        correctAnswer = value;
                      });
                    },
                    title: TextField(
                      controller: answerControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Answer ${index + 1}',
                      ),
                    ),
                    activeColor: Colors.blue,
                    selected:
                        selectedRadioValue == answerControllers[index].text,
                  );
                })),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  score = int.tryParse(value) ?? 1;
                });
              },
              decoration: const InputDecoration(labelText: 'Score'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: const Text('Add Question'),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton.icon(
                onPressed: widget.backToStartScreen,
                icon: const Icon(
                  Icons.arrow_circle_left_rounded,
                  size: 60,
                ),
                label: const Text(''),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                  shape: const CircleBorder(),
                  elevation: 0,
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
