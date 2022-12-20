import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    Key? key, required this.text, required this.onTap, required this.isActive,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        border: Border(
          top: BorderSide(
              color:AppColors.lightText,
              width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 0, 23, 0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text.toUpperCase(), 
                style: TextStyle(
                  color: isActive ? AppColors.onPrimary : AppColors.black, 
                  fontSize: 14, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.chevron_right, color: isActive ? AppColors.onPrimary : AppColors.lightText),
            ],
          ),
        ),
      ),
    );
  }
}