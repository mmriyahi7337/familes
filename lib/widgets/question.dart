import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';

class Question extends StatelessWidget {
  final TextEditingController controller;
  final String word;
  final String title;

  const Question(
      {required this.controller, required this.word, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          textFieldWidget(context),
          titleWidget(),
        ],
      ),
    );
  }

  Positioned titleWidget() {
    return Positioned.directional(
          top: 0,
          start: 0,
          end: 0,
          textDirection: TextDirection.ltr,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: MyColor.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 100,
              height: 40,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        );
  }

  Positioned textFieldWidget(BuildContext context) {
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      top: 20,
      start: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.darkerBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 110,
          width: MediaQuery.of(context).size.width - 64,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.highlightBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: controller,
                    autovalidateMode: AutovalidateMode.always,
                    style: const TextStyle(color: Colors.white),
                    validator: (txt) {
                      if (txt=='') {
                        return null;
                      }
                      else if (txt?.startsWith(word) ?? true) {
                        return null;
                      } else {
                        return 'کلمه باید با حرف مورد نظر شروع شود';
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
