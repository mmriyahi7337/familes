import 'package:flutter/material.dart';

import '../const/my_colors.dart';



class LoadingView extends StatelessWidget {
  final String text;
  const LoadingView({required this.text ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.darkerBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,  style: const TextStyle(color: Colors.white, fontSize: 20),),
            CircularProgressIndicator(color: MyColor.orange,),
          ],
        ),
      ),
    );
  }
}
