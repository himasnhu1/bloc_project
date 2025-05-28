import 'package:flutter/material.dart';
import '../color/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const RoundButton({super.key,required this.title,required this.press});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: press,
        child: Container(height:50,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColor.buttonColor,borderRadius:BorderRadius.circular(10)),
            child: Center(child: Text(title))));
  }
}
