import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';

class MyToolbar extends StatelessWidget {
  const MyToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      start: 8,
      end: 0,
      child: Container(
        height: kToolbarHeight,
        color: MyColor.background,
        child: Row(
          children: [
            backBtn(context),
          ],
        ),
      ),
    );
  }

  backBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: MyColor.orange,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            splashColor: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back_ios_outlined,
                      size: 10, color: Colors.white),
                  SizedBox(width: 2),
                  Text(
                    'بازگشت',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
