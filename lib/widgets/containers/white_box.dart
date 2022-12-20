import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';

class WhiteBox extends StatelessWidget {
  
  final Widget? child;
  
  const WhiteBox({@required this.child, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black26,
      color: AppColors.background,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}