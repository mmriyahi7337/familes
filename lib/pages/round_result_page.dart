import 'package:familes/pages/select_alphabet_page.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/my_colors.dart';
import '../controller/message_controller.dart';

class RoundResultPage extends StatelessWidget {
  const RoundResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>(tag: 'MessageController');
    bool isInit = false;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.background,
        body: GetBuilder<MessageController>(
            init: controller,
            builder: (c) {
              if (!isInit) {
                Future.delayed(const Duration(milliseconds: 50)).then((value) {
                  c.updateScore();
                  isInit = true;
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
                          enemyScore: c.totalScore_2, yourScore: c.totalScore_1, selectedAlphabet: c.selectedWord),
                      const SizedBox(height: 25),
                      results(c),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  results(MessageController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.darkerBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            resultItem(title: 'اسم' , ans_1: c.name_1, ans_2: c.name_2, scr_1: c.scoreName_1, scr_2: c.scoreName_2),
            resultItem(title: 'فامیل' , ans_1: c.family_1, ans_2: c.family_2, scr_1: c.scoreFamily_1, scr_2: c.scoreFamily_2),
            resultItem(title: 'شهر' , ans_1: c.city_1, ans_2: c.city_2, scr_1: c.scoreCity_1, scr_2: c.scoreCity_2),
            resultItem(title: 'کشور' , ans_1: c.country_1, ans_2: c.country_2, scr_1: c.scoreCountry_1, scr_2: c.scoreCountry_2),
            resultItem(title: 'اشیاء' , ans_1: c.things_1, ans_2: c.things_2, scr_1: c.scoreThings_1, scr_2: c.scoreThings_2),
            const SizedBox(height: 25),
            MyButton(
              onClick: () {
                if (c.endGame) {
                  Get.snackbar("نتیجه بازی", c.winner==1 ? 'شما برنده شدید!' : 'متاسفانه شما باختید :(', colorText: Colors.white);
                } else {
                  c.resetAns();
                  Get.off(const SelectAlphabetPage(), preventDuplicates: false);
                }
              },
              text: c.endGame ? 'مشاهده نتیجه'  : 'مرحله بعد',
            ),
          ],
        ),
      ),
    );
  }

  Widget resultItem({required String title, required String? ans_1, required String? ans_2, required int scr_1, required int scr_2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ansItem(ltr: true, ans: ans_2, score: scr_2),
          resultItemTitle(title),
          ansItem(ltr: false, ans: ans_1, score: scr_1),
        ],
      ),
    );
  }

  Widget resultItemTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget ansItem({required bool ltr, required int score, required String? ans}) {
    return Directionality(
      textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        children: [
          Text(
            ans??'',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(4),
            child: Text(
              '$score',
              style: TextStyle(color: MyColor.orange),
            ),
          ),
        ],
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
}
