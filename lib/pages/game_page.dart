import 'package:flutter/material.dart';
import 'package:frivia_app/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  GamePage({Key? key, required this.difficultyLevel}) : super(key: key);
  double? deviceHeight;
  double? deviceWidth;
  GamePageProvider? _pageProvider;
  String difficultyLevel;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Frivia Question',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) =>
            GamePageProvider(context: context, dfcLevel: difficultyLevel),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: deviceHeight! * 0.05),
            child: _gameUI(),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionTask(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionTask() {
    return Text(
      _pageProvider!.getCurrentQuetsionText(),
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion('True');
      },
      color: Colors.lime,
      minWidth: deviceWidth! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        'true',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion('False');
      },
      color: Colors.red,
      minWidth: deviceWidth! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        'false',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
