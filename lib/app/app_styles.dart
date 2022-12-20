import 'package:flutter/material.dart';
import 'app_colors.dart';



abstract class AppStyles {

  static const TextStyle white14 = const TextStyle(fontSize: 12, color: Colors.white);
  static const TextStyle white16 = const TextStyle(fontSize: 16, color: Colors.white);

  static const TextStyle primary16 = const TextStyle(fontSize: 16, color: AppColors.primary);
  
  static const TextStyle secondary16 = const TextStyle(fontSize: 16, color: AppColors.secondary);
  
  static const TextStyle primaryButton = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onPrimary);

  static const TextStyle textFieldLabel = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black);
  static const TextStyle textFieldHint = const TextStyle(fontSize: 14, color: AppColors.lightText);

}
