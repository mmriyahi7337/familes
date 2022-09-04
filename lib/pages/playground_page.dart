import 'package:familes/const/my_colors.dart';
import 'package:familes/controller/message_controller.dart';
import 'package:familes/pages/round_result_page.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/count_down_timer.dart';
import '../widgets/question.dart';

class PlayGroundPage extends StatelessWidget {
  PlayGroundPage({Key? key}) : super(key: key);

  final nameTEC = TextEditingController();
  final familyTEC = TextEditingController();
  final cityTEC = TextEditingController();
  final countryTEC = TextEditingController();
  final thingsTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>(tag: 'MessageController');

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.background,
        body: GetBuilder<MessageController>(
            init: controller,
            builder: (c) {
              if (!(c.endRound_1) && c.endRound_2) {
                Future.delayed(const Duration(milliseconds: 100)).then((value) {
                  saveAns(c);
                  c.sendMessage(c.msgAnswers());
                });
              }
              if(c.endRound_1 && c.endRound_2){
                Future.delayed(const Duration(milliseconds: 100)).then((value) {
                  c.resetEndRounds();
                  Get.off(const RoundResultPage(), preventDuplicates: false);
                });
              }
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      header(
                          enemyScore: c.score_2, yourScore: c.score_1, selectedAlphabet: c.selectedWord),
                      hintText(),
                      const SizedBox(height: 16),
                      timer(c),
                      const SizedBox(height: 50),
                      questions(c.selectedWord),
                      const SizedBox(height: 25),
                      endMatchBtn(c),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              );
            }),
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

  timer(MessageController c) {
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
              if (nameTEC.text.trim().startsWith(c.selectedWord)) {
                c.name_1 = nameTEC.text.trim();
              }
              if (familyTEC.text.trim().startsWith(c.selectedWord)) {
                c.family_1 = familyTEC.text.trim();
              }
              if (cityTEC.text.trim().startsWith(c.selectedWord)) {
                c.city_1 = cityTEC.text.trim();
              }
              if (countryTEC.text.trim().startsWith(c.selectedWord)) {
                c.country_1 = countryTEC.text.trim();
              }
              if (thingsTEC.text.trim().startsWith(c.selectedWord)) {
                c.things_1 = thingsTEC.text.trim();
              }
              c.sendMessage(c.msgAnswers());
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

  questions(String selectedWord) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Question(
              title: 'اسم',
              word: selectedWord,
              controller: nameTEC,
            ),
            Question(
              title: 'فامیل',
              word: selectedWord,
              controller: familyTEC,
            ),
            Question(
              title: 'شهر',
              word: selectedWord,
              controller: cityTEC,
            ),
            Question(
              title: 'کشور',
              word: selectedWord,
              controller: countryTEC,
            ),
            Question(
              title: 'اشیا',
              word: selectedWord,
              controller: thingsTEC,
            ),
          ],
        ));
  }

  endMatchBtn(MessageController c) {
    return MyButton(
      onClick: () {
        saveAns(c);
        c.sendMessage(c.msgAnswers());
      },
      text: 'پایان راند',
      backgroundColor: MyColor.orange,
    );
  }

  saveAns(MessageController c) {
    if (nameTEC.text.trim().startsWith(c.selectedWord)) {
      c.name_1 = nameTEC.text.trim();
    }
    if (familyTEC.text.trim().startsWith(c.selectedWord)) {
      c.family_1 = familyTEC.text.trim();
    }
    if (cityTEC.text.trim().startsWith(c.selectedWord)) {
      c.city_1 = cityTEC.text.trim();
    }
    if (countryTEC.text.trim().startsWith(c.selectedWord)) {
      c.country_1 = countryTEC.text.trim();
    }
    if (thingsTEC.text.trim().startsWith(c.selectedWord)) {
      c.things_1 = thingsTEC.text.trim();
    }
  }
}
