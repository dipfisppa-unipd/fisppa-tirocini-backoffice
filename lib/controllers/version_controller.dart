import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../app/app_config.dart';




class VersionController extends GetxController{

  static VersionController get to => Get.find();
  
  PackageInfo? _packageInfo;

  bool get isInitialized => _packageInfo!=null;

  String get appName => _packageInfo?.appName ?? '';
  String get packageName => _packageInfo?.packageName ?? '';
  String get version => _packageInfo?.version ?? '';
  String get buildNumber => _packageInfo?.buildNumber ?? '';

  String get fullVersion => 'v${_packageInfo?.version ?? ''} (${_packageInfo?.buildNumber ?? ''})';

  bool get isVersionOutdated => buildNumber != AppConfig.BUILDNUMBER;
  
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> intialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return;
  }


}