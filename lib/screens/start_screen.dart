import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, this.addQuestion, {super.key});

  final void Function() startQuiz;
  final void Function() addQuestion;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 247, 249),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/quiz-logo.png',
                color: Colors.blue,
                width: 320,
                height: 400,
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          const Text(
            'Welcome to Quiz App.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: startQuiz,
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
            label: const Text('Start Quiz'),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton.icon(
            onPressed: addQuestion,
            icon: const Icon(Icons.playlist_add_rounded),
            label: const Text('New Question'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple[300],
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
