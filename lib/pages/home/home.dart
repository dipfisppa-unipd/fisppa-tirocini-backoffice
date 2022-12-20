import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_config.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';
import 'package:unipd_tirocini/pages/home/drawer.dart';
import 'package:unipd_tirocini/pages/report/report_screen.dart';
import 'package:unipd_tirocini/pages/studenti/students_screen.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/istitutes_screen.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/tutor/tutor_screen.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/assegnazioni/assegnazioni_screen.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/gruppi/groups_screen.dart';


import '../../models/enums/home_navigation.dart';
import '../operators/operators_screen.dart';



class HomePage extends StatelessWidget {

  final HomeNavigation nav;
  
  HomePage({ this.nav=HomeNavigation.studenti, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if(kDebugMode){
          print('SIZING---------');
          print('Width: ${constraints.maxWidth}');
          print('Height: ${constraints.maxHeight}');
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: constraints.maxWidth>AppConfig.DESKTOP_MAX_WIDTH 
            ? null : DrawerView(isRealDrawer: true,),
          appBar: UnipdAppBar(withRealDrawer: constraints.maxWidth<=AppConfig.DESKTOP_MAX_WIDTH),
          body: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Row(
              children: [

                if(constraints.maxWidth>AppConfig.DESKTOP_MAX_WIDTH)
                SizedBox(
                  height: constraints.maxHeight,
                  child: DrawerView(isRealDrawer: false,),
                ),

                const SizedBox(width: 9,),

                Expanded(
                  child: Builder(
                    builder: (_) {
                      switch (nav) {
                        case HomeNavigation.unknown:
                          return Center(child: Text('Oops... qualcosa non va. Prova a ricaricare la pagina.'));
                        case HomeNavigation.studenti:
                          return StudentsScreen();
                        case HomeNavigation.istituti:
                          return InstitutesScreen();
                        case HomeNavigation.tutors:
                          return TutorScreen();
                        case HomeNavigation.gruppi:
                          return GroupsScreen();
                        case HomeNavigation.assegnazioni:
                          return AssegnazioniScreen();
                        case HomeNavigation.utenti:
                          return OperatorsScreen();
                        case HomeNavigation.reports:
                          return ReportScreen();
                      }
                    }
                  )
                ),

                
              ],
            ),
          ),
            
        );
      }
    );
  }
}