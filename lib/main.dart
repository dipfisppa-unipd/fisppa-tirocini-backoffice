import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:unipd_tirocini/app/app_routing.dart';
import 'package:unipd_tirocini/controllers/calendar_controller.dart';
import 'package:unipd_tirocini/controllers/download_controller.dart';
import 'package:unipd_tirocini/services/api_service.dart';

import 'app/app_theme.dart';
import 'controllers/auth_controller.dart';
import 'controllers/ui_controller.dart';


import 'controllers/version_controller.dart';
import 'repos/secure_repo.dart';
import 'services/context_service.dart';


void main() async {

  final repo = Get.put(SecureRepo(), permanent: true);
  await repo.readTokens();

  final version = Get.put(VersionController(), permanent: true);
  await version.intialize();
  
  Get.put(CalendarController(), permanent: true);
  Get.put(UIController(), permanent: true);
  Get.put(ApiService(), permanent: true);
  Get.put(AuthController(), permanent: true);

  Get.lazyPut(() => DownloadController(), fenix: true);
  // Get.lazyPut(() => MapController(), fenix: true);

  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(App());
}

class App extends StatelessWidget {
  
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: GetContext.key,
      debugShowCheckedModeBanner: false,
      title: 'UniPD Tirocini',
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('it', 'IT'), 
      ],
      theme: themeData(), 
    );
  }

  
}

