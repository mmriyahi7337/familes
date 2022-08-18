import 'package:flutter/material.dart';
import 'package:familes/pages/select_alphabet_page.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:familes/widgets/rect_button.dart';

import '../const/my_colors.dart';
import '../widgets/my_toolbar.dart';

class SelectRoundPage extends StatefulWidget {
  const SelectRoundPage({Key? key}) : super(key: key);

  @override
  _SelectRoundPageState createState() => _SelectRoundPageState();
}

class _SelectRoundPageState extends State<SelectRoundPage> {
  int roundCountNumber = 1;
  List<String> selectedAlphabets = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: body(),
              ),
            ),
            const MyToolbar(),
          ],
        ),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 200),
            roundCountSelection(),
            const SizedBox(height: 25),
            goAlphabetBtn(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  roundCountSelection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.lightBlue,
      ),
      child: Column(
        children: [
          roundText(),
          roundNumber(),
        ],
      ),
    );
  }

  roundText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: Center(
        child: Text(
          'تعداد راندهای بازی رو انتخاب کن',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  roundNumber() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Row(
        children: [
          minusBtn(),
          number(),
          plusBtn(),
        ],
      ),
    );
  }
  minusBtn() {
    return RectButton(
      text: '-',
      backgroundColor: MyColor.orange,
      onTap: () {
        setState(
              () {
            if (roundCountNumber > 1) {
              roundCountNumber--;
            }
          },
        );
      },
    );
  }

  plusBtn() {
    return RectButton(
      text: '+',
      backgroundColor: MyColor.blue,
      onTap: () {
        setState(() {
          roundCountNumber++;
        });
      },
    );
  }

  number() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: MyColor.highlightBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              '$roundCountNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }

  goAlphabetBtn() {
    return MyButton(
      onClick: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SelectAlphabetPage()));
      },
      text: 'انتخاب حرف ',
    );
  }

}

