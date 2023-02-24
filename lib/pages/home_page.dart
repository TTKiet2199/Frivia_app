import 'package:flutter/material.dart';
import 'package:frivia_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceHeight, deviceWidth;
  double currentLevel = 0;
  final List<String> levelText = ['Easy', 'Medium', 'Hard'];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appTitle(),
              _levelSlider(),
              _startGameButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          levelText[currentLevel.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _levelSlider() {
    return Slider(
        label: 'Difficulty',
        min: 0,
        max: 2,
        divisions: 2,
        value: currentLevel,
        onChanged: (value) {
          setState(() {
            currentLevel = value;
          });
        });
  }

  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => GamePage(
                  difficultyLevel:
                      levelText[currentLevel.toInt()].toLowerCase(),
                ))));
      },
      color: Colors.deepOrange,
      minWidth: deviceWidth! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        'Start',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }
}
