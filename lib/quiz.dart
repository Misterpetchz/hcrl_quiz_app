import 'package:flutter/material.dart';
import 'package:hcrl_quiz_app/models/quiz_question.dart';
import 'package:hcrl_quiz_app/screens/add_questions.dart';
import 'package:hcrl_quiz_app/screens/questions_screen.dart';
import 'package:hcrl_quiz_app/screens/result_screen.dart';
import 'package:hcrl_quiz_app/screens/start_screen.dart';
import 'package:hcrl_quiz_app/services/database_service.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String _activeScreen = 'start-screen';
  List<String> _selectedAnswer = [];
  List<QuizQuestion> questions = [];

  final databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    List<QuizQuestion> fetchedQuestions =
        await databaseService.getAllQuestions();
    setState(() {
      questions = fetchedQuestions;
    });
  }

  void _switchScreen() {
    setState(() {
      _activeScreen = 'questions-screen';
    });
  }

  void _addQuestionScreen() {
    setState(() {
      _activeScreen = 'add-question-screen';
    });
  }

  void _chooseAnswer(String answer) {
    _selectedAnswer.add(answer);
    print(_selectedAnswer);

    if (_selectedAnswer.length == questions.length) {
      setState(() {
        _activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _activeScreen = 'questions-screen';
      _selectedAnswer.clear();
    });
  }

  void backToStartScreen() {
    setState(() {
      _activeScreen = 'start-screen';
      _selectedAnswer.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(_switchScreen, _addQuestionScreen);

    if (_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: _chooseAnswer,
      );
    }

    if (_activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chooseAnswer: _selectedAnswer,
        onRestart: restartQuiz,
        onBack: backToStartScreen,
        questions: questions,
      );
    }

    if (_activeScreen == 'add-question-screen') {
      screenWidget = AddQuestions(
        backToStartScreen: backToStartScreen,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screenWidget,
      ),
    );
  }
}
