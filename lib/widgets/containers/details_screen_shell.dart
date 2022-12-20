import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';

import '../ui/ui_alter_size.dart';



class DetailsScreenShell extends StatelessWidget {

  final DataBox? dataBox;
  final Widget? content;

  DetailsScreenShell({@required this.dataBox, @required this.content, Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const UnipdAppBar(),
      body: ScreenTypeLayout(
        breakpoints: ScreenBreakpoints(
          tablet: 600,
          desktop: 900,
          watch: 300
        ),
        desktop: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 15, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: 400,
                child: dataBox,
              ),

              const SizedBox(width: 15),
              
              Expanded(
                child: SizedBox(
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: content,
                  ),
                ),
              ),
            ],
          ),
        ),

        tablet: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 15, 20),
              child: content,
            ),
          ),
        ),
        
        mobile: const UISizeAlert(),
      ),
    );
  }
}