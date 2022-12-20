import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';


class DataBox extends StatelessWidget {
  const DataBox({ Key? key, 
    required this.title, 
    required this.data, 
    required this.actions,
    this.editButton, }) : super(key: key);

  final String title;
  final List<DataBoxRow> data;
  final List<Widget> actions;
  final Widget? editButton;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFD7DAE2)),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
      
            //header
            Container(
              height: 65,
              color: AppColors.primary,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  IconButton(
                    onPressed: (){
                      context.pop();
                    }, 
                    icon: const Icon(Icons.arrow_back,),
                    color: AppColors.onPrimary,
                  ).marginOnly(left: 10),
      
                  Flexible(
                    child: AutoSizeText(
                      title, 
                      style: AppStyles.primaryButton, 
                      minFontSize: 18, 
                      maxFontSize: 20,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
      
                  
                  if(editButton!=null)
                    editButton!.marginOnly(right: 10),
                  
                  if(editButton==null) //soluzione tappabuchi per l'allineamento
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.arrow_back, size: 28,),
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
      
            //content
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 60, 23, 30),
              child: Column(
                children: [
                  ...data,
                ],
              ),
            ),

                  
            ...actions
          ],
        )
      ),
    );
  }
}


class DataBoxRow extends StatelessWidget {
  const DataBoxRow({required this.label, required this.content, this.skipLastDivider=false});

  final String label;
  final String content;
  final bool skipLastDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(label, style: TextStyle(color: AppColors.boxLabel, fontSize: 14, fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
              child: Text(content, style: TextStyle(color: Color(0xFF868AA8), fontSize: 14),)
            )
          ],
        ),
        
        skipLastDivider 
          ? const SizedBox(height: 30) 
          : Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Divider(color: Color(0xFFD1D1D1), thickness: 1,),
        )
      ],
    );
  }
}