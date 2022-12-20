import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin, IosDeviceInfo;
import 'package:unipd_tirocini/app/app_colors.dart';


class UIController extends GetxService {

  static UIController get to => Get.find();
  
  bool _notch = false;
  static const List<String> _IOS_MACHINES_WITH_BOTTOM_NOTCH = [
    'iPhone10,3',
    'iPhone10,6',
    'iPhone11,2',
    'iPhone11,4',
    'iPhone11,6',
    'iPhone11,8',
    'iPhone12,1',
    'iPhone12,3',
    'iPhone12,5',
    'iPhone13,1',
    'iPhone13,3',
    'iPhone13,5',
  ];
  double? iOSversion;

  @override
  void onInit() {
    MissLog.i('Device width: ${Get.width}, height: ${Get.height}, pixelRatio: ${Get.pixelRatio}, textFactor: ${Get.textScaleFactor}' );
    _initPlatform();
    super.onInit();
  }

  bool get isAndroid => GetPlatform.isAndroid;
  bool get isIOS => GetPlatform.isIOS;

  bool get isiPad => Get.width>=768; // iPad Mini
  bool get isiPhone13 => Get.width<=428 && Get.width>375; // iPhone 12, 13, 13 Max
  bool get isiPhone12mini => Get.width==375 && Get.height==812; // iPhone 12 e 13 mini
  bool get isiPhone8 => Get.width<=375 && Get.width>320 && Get.height<=667; // iPhone 8, 7, 6s
  bool get isiPhone5 => Get.width<=320; // iPhone 5, 4, 3, SE 1st Gen

  bool get isLandscape => Get.mediaQuery.orientation == Orientation.landscape;
  bool get hasNotch => _notch;

  bool get isAndroidOrIphone6 => GetPlatform.isAndroid || isiPhone8;

  void _initPlatform() async {
    if(!isIOS) return;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    MissLog.i('Device: ${iosDeviceInfo.utsname.machine}');
    _notch = _IOS_MACHINES_WITH_BOTTOM_NOTCH.contains(iosDeviceInfo.utsname.machine);
    iOSversion = double.tryParse(iosDeviceInfo.systemVersion ?? '0') ?? 0;
  }

  void changeStatusBarColor({Color color = AppColors.background}){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  void setTransparentStatusBar(){
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
      )
    );
  }

}