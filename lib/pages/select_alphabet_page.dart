import 'package:flutter/material.dart';
import 'package:familes/const/persian_alphabets.dart';
import 'package:familes/pages/playground_page.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:familes/widgets/rect_button.dart';

import '../const/my_colors.dart';
import '../widgets/my_toolbar.dart';

class SelectAlphabetPage extends StatefulWidget {
  const SelectAlphabetPage({Key? key}) : super(key: key);

  @override
  _SelectAlphabetPageState createState() => _SelectAlphabetPageState();
}

class _SelectAlphabetPageState extends State<SelectAlphabetPage> {
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
            const SizedBox(height: kToolbarHeight + 60),
            roundCountSelection(),
            const SizedBox(height: 25),
            alphabets(),
            const SizedBox(height: 40),
            startGameBtn(),
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

  alphabets() {
    return Wrap(
      children: [
        ...alphabetList(),
      ],
    );
  }

  List<Widget> alphabetList() {
    List<Widget> items = [];
    for (var element in persianAlphabets) {
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: RectButton(
              text: element,
              backgroundColor: selectedAlphabets.contains(element)
                  ? MyColor.blue
                  : MyColor.highlightBlue,
              onTap: () {
                // todo: add another logic for alphabet selection:
                if (selectedAlphabets.contains(element)) {
                  setState(() {
                    selectedAlphabets.remove(element);
                  });
                } else {
                  setState(() {
                    selectedAlphabets.add(element);
                  });
                }
              }),
        ),
      );
    }
    return items;
  }

  startGameBtn() {
    return MyButton(
      onClick: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PlayGroundPage()));
      },
      text: 'شروع بازی',
    );
  }
}
