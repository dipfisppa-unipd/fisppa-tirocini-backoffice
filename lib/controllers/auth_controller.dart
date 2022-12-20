import 'dart:async';
import 'dart:html' as html; // da commentare per mobile 1/2
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_tirocini/services/context_service.dart';

import '../repos/user_repo.dart';
import '../models/user.dart';
import '../repos/auth_repo.dart';
import '../repos/secure_repo.dart';
import '../services/api_service.dart';
import '../utils/utils.dart';
import 'generic_data_controller.dart';


class AuthController extends GetxController with StateMixin<UserModel>{

  static AuthController get to => Get.find();

  final _authRepo = AuthRepo();
  final _userRepo = UserRepo();
  final isLoading = false.obs;

  Timer? _pollingTimer, _timeout;
  var _context;
  String? ref;

  UserModel? user;
  var xWin;

  bool get isLoggedin => user!=null && user!.email!=null;
  
  @override
  void onInit() {
    Get.find<ApiService>().initApi();
    super.onInit();
  }

  @override
  void onClose() {
    cancelPolling();
    super.onClose();
  }


  void login(context) async {
    isLoading(true);
    _context = context;
    
    // user = UserModel();
    // isLoading(false);
    // return;

    if(SecureRepo.to.refreshToken==null || SecureRepo.to.refreshToken!.isEmpty){
      
      
      var url = await _authRepo.initAuth();
      
      if(url!=null){
        if(GetPlatform.isWeb){
          xWin = html.window.open(url, 'SHIB'); // da commentare per mobile 2/2
        }else{
          GoRouter.of(context).goNamed('shibboleth', params: {'url': url});
        }

        _startPolling(context);
      }else{

        Utils.showToast(context: context, isError: true, text: 'Errore durante il login');
      }
        
        
      
      return;
    }

    // Il refresh token è presente
    var newToken = await refreshAccessToken();

    if(newToken==null){
      Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore');
      GoRouter.of(context).goNamed('login');
      isLoading(false);
      return;
    }

    Get.find<ApiService>().initApi();
    await decodeToken(newToken);
    
  }

  void logout() async {
    await SecureRepo.to.deleteAll(); 
    user = UserModel();
    change(user, status: RxStatus.success());
    
  }

  Future<String?> refreshAccessToken() async {
    if(SecureRepo.to.accessToken?.isNotEmpty ?? false){
      bool isExpired = JwtDecoder.isExpired(SecureRepo.to.accessToken!);
      if(!isExpired) 
        return SecureRepo.to.accessToken!;
    }

    var newAccessToken = await _authRepo.refreshToken();
    if(newAccessToken==null){
      SecureRepo.to.deleteAll();
    }
      
    return newAccessToken;
  }


  void _startPolling(context){

    _timeout = Timer.periodic(Duration(seconds: 80), (timer) {
      xWin?.close();
      cancelPolling();
      
      GoRouter.of(GetContext.find!).goNamed('login');
      Utils.showToast(context: context, isError: true, text: 'Tempo scaduto, riprovare');

    });

    _pollingTimer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
        var data = await _authRepo.checkAuth();
        if(data!=null){
          cancelPolling();
          xWin?.close(); 
          if(data=='unauthorized')
            Utils.showToast(text: 'Non autorizzato', isError: true);
          else 
            decodeToken(data);

        }
    });
  }

  void cancelPolling(){
    _pollingTimer?.cancel();
    _timeout?.cancel();
    isLoading(false);
  }

  Future<void> decodeToken(String token, {context}) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      
      if(!kReleaseMode){
        print('-------------------------------');
        print(decodedToken);
        print('-------------------------------');
        print('email: ${decodedToken['email']}');
      }

      // await getUser(withEmail: decodedToken['email'] ?? '');
      user = UserModel(
        email: decodedToken['email'],
      );
      isLoading(false);

      

      if(user!=null && (user!.email?.toLowerCase().contains('unipd') ?? false)){
        Get.find<ApiService>().initApi();
        Get.put(GenericDataController(), permanent: true);
        if(ref?.isNotEmpty ?? false){
          GoRouter.of(context ?? _context).go(ref!);
          ref = '';
        } else
          GoRouter.of(context ?? _context).goNamed('home');
      }else{
        GoRouter.of(context ?? _context).goNamed('login');
        Utils.showToast(context: context ?? _context, isWarning: true, text: 'Utente non autorizzato');
      }
        

    } on Exception catch (e) {
      MissLog.e('$e');
    }
  }

  Future<UserModel?> getUser({String withEmail=''}) async {
    user = await _userRepo.getUser();
    MissLog.i(user?.registry?.toJson() ?? 'no user...');
    if(withEmail.isNotEmpty)
      user?.email = withEmail;

    update();
    return user;
  }

  // Auto routing

  void saveRef(String r){
    ref = r;
  }



}