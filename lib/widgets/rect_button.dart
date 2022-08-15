import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final Function onTap;

  const RectButton({
    this.backgroundColor = const Color(0xff2C2C51),
    required this.text,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: () => onTap(),
          splashColor: Colors.black26,
          child: SizedBox(
            height: 55,
            width: 55,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
