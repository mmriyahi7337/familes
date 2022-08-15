import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onClick;
  final Color fontColor;
  final Color backgroundColor;
  final bool isFullSize;
  final String text;
  final bool isActive;

  const MyButton({
    required this.onClick,
    this.fontColor = Colors.white,
    this.isActive = true,
    this.isFullSize = true,
    this.backgroundColor = const Color(0xff1751AF),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = isFullSize ?  MediaQuery.of(context).size.width - 64 : MediaQuery.of(context).size.width - 128;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: isActive ? backgroundColor : Colors.black26,
        child: InkWell(
          onTap: () => isActive ? onClick() : null,
          splashColor: Colors.black12,
          child: SizedBox(
           width: size,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  text,
                  style: TextStyle(color: fontColor, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
