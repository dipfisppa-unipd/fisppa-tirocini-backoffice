import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';


class OutlinedTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const OutlinedTextField({this.hint, this.controller, this.onSubmitted, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 5),
        prefixIcon: const Icon(Icons.search, color: AppColors.lightText,),
        hintText: hint ?? 'Cerca',     
        hintStyle: TextStyle(color: AppColors.lightText),
        enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(color: AppColors.lightText),   
        ),  
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightText),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightText),
        ),
        suffix: controller!=null 
          ? IconButton(
              splashRadius: 20,
              onPressed: (){
                controller!.clear();
                if(onSubmitted!=null)
                  onSubmitted!('');
              }, 
              icon: const Icon(Icons.close, size: 20,)
            ) 
          : null,
      )
    );
  }
}