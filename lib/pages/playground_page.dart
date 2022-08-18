import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';
import 'package:familes/widgets/my_button.dart';

import '../widgets/count_down_timer.dart';
import '../widgets/question.dart';

class PlayGroundPage extends StatefulWidget {
  const PlayGroundPage({Key? key}) : super(key: key);

  @override
  _PlayGroundPageState createState() => _PlayGroundPageState();
}

class _PlayGroundPageState extends State<PlayGroundPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.background,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 50),
                header(enemyScore: 2, yourScore: 1, selectedAlphabet: 'س'),
                hintText(),
                const SizedBox(height: 16),
                timer(),
                const SizedBox(height: 50),
                questions(),
                const SizedBox(height: 25),
                endMatchBtn(),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  header(
      {required int yourScore,
      required int enemyScore,
      required String selectedAlphabet}) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          scoresBox(yourScore: yourScore, enemyScore: enemyScore),
          selectedAlphabetBox(selectedAlphabet),
        ],
      ),
    );
  }

  Positioned selectedAlphabetBox(String text) {
    return Positioned.directional(
      top: 0,
      start: 0,
      end: 0,
      textDirection: TextDirection.ltr,
      child: Center(
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyColor.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scoresBox({required int yourScore, required int enemyScore}) {
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      top: 35,
      start: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyColor.darkBlue,
          ),
          padding:
              const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              title(),
              scores(yourScore: yourScore, enemyScore: enemyScore),
            ],
          ),
        ),
      ),
    );
  }

  Row scores({required int enemyScore, required int yourScore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        scoreItem('حریف', '$enemyScore'),
        scoreItem('شما', '$yourScore'),
      ],
    );
  }

  scoreItem(String title, String score) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        Text(
          score,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ],
    );
  }

  title() {
    return const Center(
      child: Text(
        'امتیازات',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  hintText() {
    return const Text(
      'حالا با حرف بالا شروع کن و جدول رو کامل کن',
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  timer() {
    return Column(
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyColor.darkerBlue,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CountDownTimer(
            secondsRemaining: 300,
            whenTimeExpires: () {
              setState(() {
                // todo: end game when time is over
              });
            },
            countDownTimerStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'از وقتت باقی مونده',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  questions() {
    return Form(
        child: Column(
      children: [
        Question(
          title: 'اسم',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'فامیل',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'شهر',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'کشور',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'ماشین',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'مشاهیر ',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'حیوان',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'اشیا',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'میوه',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'نام گل',
          word: 'ب',
          controller: TextEditingController(),
        ),
        Question(
          title: 'فیلم',
          word: 'ب',
          controller: TextEditingController(),
        ),

      ],
    ));
  }

  endMatchBtn() {
    return MyButton(
      onClick: () {
        // todo
      },
      text: 'پایان راند',
      backgroundColor: MyColor.orange,
    );
  }
}
