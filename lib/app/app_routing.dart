
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../models/enums/home_navigation.dart';
import '../pages/error_screen.dart';
import '../pages/home/drawer_controller.dart';
import '../pages/home/home.dart';
import '../pages/login/login.dart';
import '../pages/dispatcher/dispatcher_screen.dart';
import '../pages/operators/operator/operator_screen.dart';
import '../pages/studenti/studente/student_details_screen.dart';
import '../pages/tirocinio_diretto/institutes/institute/institute_details.dart';
import '../pages/tirocinio_indiretto/gruppi/gruppo/edit-group/group_edit_screen.dart';
import '../pages/tirocinio_indiretto/gruppi/gruppo/group_details_screen.dart';

final goRouter = GoRouter(
    initialLocation: '/authenticating',
    errorBuilder: (_, state) => ErrorScreen(errorState: state),
    redirect: (state){ 
      // guard
      final loggingIn = state.subloc == '/login';
      final authenticating = state.subloc == '/authenticating';

      if(!AuthController.to.isLoggedin && !loggingIn && !authenticating){
        String ref = state.subloc;
        print('redirect: $ref');
        if(ref!='/studenti'){
          AuthController.to.saveRef(ref);
        }
        
        return '/authenticating?ref=$ref';
      }
      
      return null;
    },
    routes: [

      GoRoute(
        path: '/authenticating',
        name: 'dispatcher',
        builder: (_, state) {
          print(state.queryParams['ref']);
          return DispatcherScreen();
        },
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (_, state) {
          
          return Login();
        },
      ),

      GoRoute(
        path: '/',
        name: 'home',
        builder: (_, state) {
          Get.put(CustomDrawerController());
          return HomePage();
        },
        redirect: (state) => '/studenti',
        routes: [

          GoRoute(
            path: 'studenti',
            name: 'studenti',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.studenti);
            },
            routes: [

              GoRoute(
                path: 'studente/:sid',
                name: 'studente',
                builder: (_, state) {
                  return StudentDetailsScreen(sid: state.params['sid']!);
                },
              ),

            ]
          ),

          GoRoute(
            path: 'istituti',
            name: 'istituti',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.istituti);
            },
            routes: [
              GoRoute(
                path: 'istituto/:code',
                name: 'istituto',
                builder: (_, state) {

                  return InstituteDetails(code: state.params['code']!,); // TODO sistemare il landing da nuovo-instituto
                },
              ),

              GoRoute(
                path: 'nuovo-istituto',
                name: 'nuovo-istituto',
                builder: (_, state) {

                  return InstituteDetails(code: '',);
                },
              ),
            ]
          ),

          GoRoute(
            path: 'gruppi',
            name: 'gruppi',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.gruppi);
            },
            routes: [

              GoRoute(
                path: 'crea-gruppo',
                name: 'crea-gruppo',
                builder: (_, state) {

                  return GroupEditScreen();
                },
              ),

              GoRoute(
                path: 'gruppo/:gid',
                name: 'gruppo',
                builder: (_, state) {
                  int internshipYear = 1;
                  if(state.queryParams['internshipYear']!=null){
                    internshipYear = int.tryParse(state.queryParams['internshipYear']!) ?? 1;
                  }

                  return GroupDetailsScreen(gid: state.params['gid']!, internshipYear: internshipYear==0 ? 1 : internshipYear,);
                },
              ),

              GoRoute(
                path: 'gruppo/:gid/edit',
                name: 'edit-gruppo',
                builder: (_, state) {

                  return GroupEditScreen(gid: state.params['gid']!,);
                },
              ),
            ]
          ),

          GoRoute(
            path: 'assegnazioni',
            name: 'assegnazioni',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.assegnazioni);
            },
          ),

          GoRoute(
            path: 'tutors',
            name: 'tutors',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.tutors);
            },
          ),
          
          GoRoute(
            path: 'utenti',
            name: 'utenti',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.utenti);
            },
            routes: [
              GoRoute(
                path: 'crea-operatore',
                name: 'crea-operatore',
                builder: (_, state) {

                  return OperatorScreen();
                },
              ),

              GoRoute(
                path: 'operatore/:uid',
                name: 'operatore',
                builder: (_, state) {

                  return OperatorScreen();
                },
              ),
            ]
          ),

          GoRoute(
            path: 'reports',
            name: 'reports',
            builder: (_, state) {
              return HomePage(nav: HomeNavigation.reports);
            },
          ),

        ]
      ),      

    ]
  );