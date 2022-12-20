import 'package:flutter/material.dart';

import '../../app/app_colors.dart';


class JobErasmus extends StatelessWidget {

  final bool inErasmus;
  final String hasJob;
  final double iconSize;

  const JobErasmus({
    this.inErasmus=false,
    this.hasJob='',
    this.iconSize=18,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        
        if(hasJob.isNotEmpty)...[
          Tooltip(
            message: 'Studente lavoratore',
            child: Icon(Icons.work, color: AppColors.work, size: iconSize, semanticLabel: 'Studente lavoratore')), 

          Text(hasJob),

          const SizedBox(width: 4),
        ],
        
        
        if(inErasmus)
        Tooltip(
          message: 'Studente in Erasmus',
          child: Icon(Icons.public, color: AppColors.erasmus, size: iconSize, semanticLabel: 'Studente in Erasmus')),
      ],
    );
  }
}