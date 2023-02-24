import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final String dfcLevel;
  final int maxQuestion = 10;
  int questionCount = 0;
  List? questions;
  int correctCount = 0;
  BuildContext context;
  GamePageProvider({required this.context, required this.dfcLevel}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromAPI();
  }
  Future<void> _getQuestionFromAPI() async {
    var response = await dio.get('', queryParameters: {
      'amount': 10,
      'type': 'boolean',
      'difficulty': dfcLevel
    });
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
    print(dfcLevel);
  }

  String getCurrentQuetsionText() {
    return questions![questionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect = questions![questionCount]["correct_answer"] == answer;
    correctCount += isCorrect ? 1 : 0;
    questionCount++;
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.lime : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    Navigator.pop(context);

    if (questionCount == maxQuestion) {
      result();
    } else {
      notifyListeners();
    }
  }

  void result() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              'End Game',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            content: Text('Result: $correctCount/$maxQuestion'),
          );
        });
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
