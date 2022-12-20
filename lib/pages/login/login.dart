import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_config.dart';
import 'package:unipd_tirocini/controllers/auth_controller.dart';
import 'package:unipd_tirocini/controllers/version_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/logo_unipd.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/loader.dart';

class Login extends GetView<AuthController> {
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 510,
            width: 860,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Spacer(), 
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                          //   child: Image.asset("assets/images/fisspa/logo_pieno.png", height: 100,),
                          // ),

                          const Text("Accedi", style: TextStyle(color: AppColors.primary, fontSize: 31, fontWeight: FontWeight.bold),),

                          const SizedBox(height: 25,),

                          const Text("L'accesso è consentito al personale didattico dell'Università degli Studi di Padova.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Image.asset("assets/images/SSO.png"),
                          ),

                          Obx(()=> controller.isLoading() ? Loader(size: 40,) : Row(
                            children: [
                              
                              BtnPrimary(
                                text: "ACCEDI", 
                                onTap: (){
                                  controller.login(context);
                                },
                              ),
                              const Spacer(),
                            ],
                          ),),

                          const SizedBox(height: 50,),

                          Row(
                            children: [
                              const Text("Non hai accesso?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                              TextButton(
                                onPressed: () async {
                                  final Uri _url = Uri.parse('mailto:${AppConfig.EMAIL}');
                                  if (!await launchUrl(_url)) {
                                    Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore');
                                  }
                                }, 
                                child: Text("Clicca qui per richiederlo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))
                            ],
                          ),

                          const Spacer(), 

                        ],
                      ),
                    ),
                  )
                ), 
                Expanded(
                  flex: 3,
                  child: Container(
                    color: AppColors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),

                        const Text("Corso di laurea in Scienze della Formazione Primaria", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Oswald',),),
                        const SizedBox(height: 25,),
                        const Logo(),
                        
                        const Spacer(),

                        Text(VersionController.to.fullVersion, style: TextStyle(color: Colors.white, fontSize: 14),),

                        const SizedBox(height: 20,),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}