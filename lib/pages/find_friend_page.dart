import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';
import 'package:familes/pages/select_round_page.dart';
import 'package:familes/widgets/my_button.dart';


import '../widgets/my_toolbar.dart';

class FindFriendPage extends StatefulWidget {
  const FindFriendPage({Key? key}) : super(key: key);

  @override
  _FindFriendPageState createState() => _FindFriendPageState();
}

class _FindFriendPageState extends State<FindFriendPage> {
  int selectedIndex = -1;
  int clientSide = -1;
  //todo a btn for clientmod (thad disappear device list? ) , a btn for serverside again , maybe we need a btn for disconnct)
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
        const SizedBox(height: 25),
        // serverBtn(),
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
          if (clientSide==0 || clientSide == -1) list(),
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
        clientSide = -1;
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SelectRoundPage()));
      },
      isActive:(clientSide==0 || selectedIndex !=-1) ? true : false,
      text: 'ادامه',
    );
  }
  clientBtn() {
    return MyButton(
      onClick: () {
        clientSide =1;
        selectedIndex =-1;
        // todo the master go to aplphabet page and client go to playground , not the aphabet page(for the first round , next round the client must choose the alphabet)

      },
      text: 'به بازی دیگران وصل بشیم',
    );
  }
  serverBtn() {
    return MyButton(
      onClick: () {
        clientSide = -1;
      },
      isActive: clientSide != 0,
      text: 'دستگاه مادر',
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
      items.add(deviceItem('guest', i));
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
