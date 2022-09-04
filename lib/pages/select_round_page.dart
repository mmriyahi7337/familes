import 'dart:async';

import 'package:familes/pages/select_alphabet_page.dart';
import 'package:familes/widgets/Loading_View.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:familes/widgets/rect_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/my_colors.dart';
import '../controller/message_controller.dart';
import '../widgets/my_toolbar.dart';

class SelectRoundPage extends StatelessWidget {
  final bool isServer;

  const SelectRoundPage({required this.isServer});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>(tag: 'MessageController');
    bool isInit = false;

    return SafeArea(
      child: GetBuilder<MessageController>(
        init: controller,
        builder: (c) {
          if(!isInit && controller.selectRound){
            Future.delayed(const Duration(milliseconds: 50)).then((value) {
              Get.off(const SelectAlphabetPage(), preventDuplicates: false);
            });
            isInit = true;
          }
          return Scaffold(
            backgroundColor: MyColor.background,
            body: isServer
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: body(controller, context),
                        ),
                      ),
                      const MyToolbar(),
                    ],
                  )
                : const LoadingView(text: 'لطفا منتظر بمانید!'),
          );
        }
      ),
    );
  }

  body(MessageController controller, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 200),
            roundCountSelection(controller),
            const SizedBox(height: 25),
            goAlphabetBtn(controller, context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  roundCountSelection(MessageController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.lightBlue,
      ),
      child: Column(
        children: [
          roundText(),
          roundNumber(controller),
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

  roundNumber(MessageController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Row(
        children: [
          minusBtn(controller),
          number(controller),
          plusBtn(controller),
        ],
      ),
    );
  }

  minusBtn(MessageController controller) {
    return RectButton(
      text: '-',
      backgroundColor: MyColor.orange,
      onTap: () {
        controller.decRound();
      },
    );
  }

  plusBtn(MessageController controller) {
    return RectButton(
      text: '+',
      backgroundColor: MyColor.blue,
      onTap: () {
        controller.incRound();
      },
    );
  }

  number(MessageController controller) {
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
            child: GetBuilder<MessageController>(
              init: controller,
              builder: (c) {
                return Text(
                  '${c.round}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  goAlphabetBtn(MessageController controller, BuildContext context) {
    return MyButton(
      onClick: () async {
        // controller.msgSelectRound();
        controller.sendMessage(controller.msgSelectRound());
        // Get.to(SelectAlphabetPage(device: device), preventDuplicates: false);
      },
      text: 'انتخاب حرف ',
    );
  }

}
