import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';
import 'package:familes/pages/select_alphabet_page.dart';
import 'package:familes/widgets/my_button.dart';

import '../widgets/my_toolbar.dart';

class FindFriendPage extends StatefulWidget {
  const FindFriendPage({Key? key}) : super(key: key);

  @override
  _FindFriendPageState createState() => _FindFriendPageState();
}

class _FindFriendPageState extends State<FindFriendPage> {
  int selectedIndex = -1;

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
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight + 60),
        finder(),
        const SizedBox(height: 25),
        nextBtn(),
        const SizedBox(height: 25),
        clientBtn(),
      ],
    );
  }

  finder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(),
          list(),
        ],
      ),
    );
  }

  SizedBox list() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.75,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...devices(),
          ],
        ),
      ),
    );
  }

  nextBtn() {
    return MyButton(
      onClick: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SelectAlphabetPage()));
      },
      isActive: selectedIndex != -1,
      text: 'ادامه',
    );
  }
  clientBtn() {
    return MyButton(
      onClick: () {

      },
      text: 'به بازی دیگران وصل بشیم',
    );
  }

  header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: MyColor.lightBlue,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
        child: Center(
          child: Text(
            'این بار دوست داری با کی بازی کنی؟',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  List<Widget> devices() {
    List<Widget> items = [];
    // todo: pass devices to loop
    for (int i = 0; i < 100; i++) {
      items.add(deviceItem('abbas', i));
    }
    return items;
  }

  deviceItem(String name, int index) {
    final color = (selectedIndex == index)
        ? MyColor.blue
        : (index % 2 == 0)
            ? MyColor.highlightBlue
            : MyColor.lightBlue;
    return Material(
      color: color,
      child: InkWell(
        splashColor: MyColor.blue,
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
