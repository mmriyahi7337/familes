import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';
import 'package:familes/pages/find_friend_page.dart';
import 'package:familes/widgets/my_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.background,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              image(context),
              playBtn(context),
              const SizedBox(height: 16),
              exitBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  MyButton exitBtn(BuildContext context) {
    return MyButton(
      onClick: () {
        //todo
      },
      isFullSize: false,
      backgroundColor: MyColor.orange,
      text: 'خروج',
    );
  }

  MyButton playBtn(BuildContext context) {
    return MyButton(
      onClick: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindFriendPage()));
      },
      isFullSize: false,
      backgroundColor: MyColor.blue,
      text: 'بازی',
    );
  }

  image(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: Image.asset(
        'assets/famil.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
