import 'package:flutter/material.dart';

import '../../app/app_colors.dart';


class AlertBox extends StatelessWidget {
  final Function onTap;
  final List<Widget> children;
  final double width;

  const AlertBox({ Key? key, 
    required this.children, 
    required this.onTap, 
    this.width = 200,
    this.showIcon = true, 
    this.button = "CONFERMA" }) : super(key: key);

  final bool showIcon;
  final String button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  showIcon ? Row(
                    children: [
                      const Spacer(),
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)) 
                    ],
                  ) : const SizedBox(height: 25,),
                  ...children
                ],
              ),
            ),
  
            InkWell(
              child: Container(
                height: 60,
                color: AppColors.primary,
                child: Center(
                  child: Text(
                    button, 
                    style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ),
              ),
  
              onTap: (){
                onTap();
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      )
    );
  }
}