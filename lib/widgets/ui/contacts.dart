import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../utils/utils.dart';


class Contacts extends StatelessWidget {
  const Contacts({this.email, this.phoneNumber, super.key});

  final String? email, phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        InkWell(
          onTap: (){
            Utils.copyText(context, email ?? '-');
          },
          child: Text('@', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w700, fontSize: 18),),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: InkWell(
            onTap: ()=>Utils.copyText(context, '${phoneNumber ?? '-'}'),
            child: Text(phoneNumber ?? '-'),),
        ),
      ],
    );
  }
}