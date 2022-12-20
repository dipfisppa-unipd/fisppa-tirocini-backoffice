import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';


class CirclesAnnualita extends StatelessWidget {
  final int annoCorso, annoTirocinio;

  const CirclesAnnualita({
    this.annoCorso=0,
    this.annoTirocinio=0,
    Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        if(annoCorso>0)...[

          Text('C'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CircleAvatar(
              radius: 10,
              child: Text('$annoCorso', style: AppStyles.white14,),
              backgroundColor: AppColors.circle1,
            ),
          ),

        ],
        
        if(annoTirocinio>0)...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text('T'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CircleAvatar(
              radius: 10,
              child: Text('$annoTirocinio', style: AppStyles.white14,),
              backgroundColor: AppColors.circle2,
            ),
          ),
        ],
        
      ],
    );
  }
}