import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hcrl_quiz_app/models/quiz_question.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createQuestion(
      String collectionPath, QuizQuestion question) async {
    final Map<String, Object> questionData = {
      'text': question.text,
      'answers': question.answers,
      'correctAnswer': question.correctAnswer,
      'score': question.score,
    };

    await _firestore.collection(collectionPath).add(questionData);
  }

  Future<List<QuizQuestion>> getAllQuestions() async {
    List<QuizQuestion> questions = [];
    try {
      CollectionReference questionCollection =
          _firestore.collection('questions');
      QuerySnapshot querySnapshot = await questionCollection.get();

      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        QuizQuestion question = QuizQuestion(
          data['text'],
          List<String>.from(data['answers']),
          data['correctAnswer'],
          data['score'] as int,
        );
        questions.add(question);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return questions;
  }
}
