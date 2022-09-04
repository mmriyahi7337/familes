import 'package:familes/const/persian_alphabets.dart';
import 'package:familes/controller/message_controller.dart';
import 'package:familes/pages/playground_page.dart';
import 'package:familes/widgets/Loading_View.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:familes/widgets/rect_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/my_colors.dart';
import '../widgets/my_toolbar.dart';

class SelectAlphabetPage extends StatelessWidget {
  const SelectAlphabetPage({Key? key}) : super(key: key);

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
            if (!isInit && c.isSelectedWord) {
              Future.delayed(const Duration(milliseconds: 50)).then((value) {
                c.resetSelectedWordState();
                Get.off(PlayGroundPage(), preventDuplicates: false);
              });
              isInit = true;
            }
            return c.isMyTurn
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: body(controller),
                        ),
                      ),
                      const MyToolbar(),
                    ],
                  )
                : const LoadingView(
                    text: 'منتظر بمانید تا حریف الفبای مورد نظرش را انتخاب کند',
                  );
          },
        ),
      ),
    );
  }

  body(MessageController controller) {
    return GetBuilder<MessageController>(
        init: controller,
        builder: (c) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight + 60),
                  // Text('${c.round}'),
                  alphabets(c),
                  const SizedBox(height: 40),
                  startGameBtn(c),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        });
  }

  alphabets(MessageController c) {
    return Wrap(
      children: [
        ...alphabetList(c),
      ],
    );
  }

  List<Widget> alphabetList(MessageController c) {
    List<Widget> items = [];
    for (var element in persianAlphabets) {
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: RectButton(
            text: element,
            backgroundColor: (c.selectedWordList.contains(element) ||
                    c.selectedWord == element)
                ? MyColor.blue
                : MyColor.highlightBlue,
            onTap: () {
              if (!c.selectedWordList.contains(element)) {
                c.changeSelectedWord(element);
              }
            },
          ),
        ),
      );
    }
    return items;
  }

  startGameBtn(MessageController c) {
    return MyButton(
      onClick: () {
        c.sendMessage(c.msgSelectAlphabet());
      },
      text: 'شروع بازی',
    );
  }
}
