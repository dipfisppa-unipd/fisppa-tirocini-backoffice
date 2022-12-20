
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';


import '../app/app_colors.dart';


class TooltipInfo extends StatelessWidget {

  final String title, content;
  final bool isWarning;

  TooltipInfo({required this.title, required this.content, this.isWarning=false});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Icon(
          isWarning ? Icons.error : Icons.info,
          color: isWarning ? AppColors.warning : AppColors.primary,
        ),
      ),
      content: SizedBox(
        width: 400,
        height: 320,
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              Text(content, style: TextStyle(height: 1.3),),
            ],
          ),
        ),
      ),
    );
  }
}