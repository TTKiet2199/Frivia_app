import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestion = 10;
  int questionCount = 0;
  List? questions;
  BuildContext context;
  GamePageProvider({required this.context}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromAPI();
  }
  Future<void> _getQuestionFromAPI() async {
    var response = await dio.get('', queryParameters: {
      'amount': 10,
      'type': 'boolean',
      'difficulty': 'easy'
    });
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
    print(data);
  }

  String getCurrentQuetsionText() {
    return questions![questionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect = questions![questionCount]["correct_answer"] == answer;
    questionCount++;
    print(isCorrect ? 'correct' : 'incorrect');
    notifyListeners();
  }
}
