import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';

///Era il pulsante grigio, mi sa che non c'è più

class BtnSecondary extends StatelessWidget {
  const BtnSecondary({ Key? key, required this.text, required this.onTap }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(), 
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        child: Text(text, 
          style: AppStyles.primaryButton,
          textAlign: TextAlign.center,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
      ),
    );
  }
}