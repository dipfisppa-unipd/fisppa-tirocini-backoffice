import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_config.dart';
import 'package:unipd_tirocini/controllers/auth_controller.dart';
import 'package:unipd_tirocini/controllers/version_controller.dart';
import 'package:unipd_tirocini/pages/home/drawer_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';


class DrawerView extends GetView<CustomDrawerController> {
  final bool isRealDrawer;
  const DrawerView({this.isRealDrawer=false, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return isRealDrawer 
      ? _Drawer(isRealDrawer: true,) 
      : Obx(()=>controller.isDrawerOpen()
        ? _Drawer(isRealDrawer: false,)
        : Container(
            height: Get.height-70,
            width: 40,
            color: AppColors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 68,
                  child: IconButton(onPressed: (){
                    controller.isDrawerOpen.toggle();
                  }, icon: Icon(Icons.menu, color: AppColors.primary,)),
                ),

                const Spacer(),
              ],
            ),
          ),);
  }

  
}

class _Drawer extends GetView<CustomDrawerController> {
  final bool isRealDrawer;

  const _Drawer({this.isRealDrawer=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 280,
      elevation: 10,
      child: Column(
        children: [

          Container(
            color: AppColors.surface,
            height: 68,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 0),
              child: Row(
                children: [
                  if(controller.isDrawerOpen())
                  Expanded(
                    child: Text('GESTIONE TIROCINI${AppConfig.PRODUCTION ? '' : ' - staging'}',
                      style: TextStyle(
                        fontFamily: 'Oswald', 
                        fontSize: 16, 
                        color: AppConfig.PRODUCTION ? AppColors.primary : Colors.amber[900], 
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  if(!isRealDrawer)
                  IconButton(onPressed: (){
                    controller.isDrawerOpen.toggle();
                  }, icon: Icon(Icons.menu, color: AppColors.primary,)),
                ],
              ),
            ),
          ),

          // Text(AuthController.to.user!.userType.name),
          // Text(AuthController.to.user!.isAdmin.toString()),
          
          buildMenuItem(
            index: 0,
            isSelected: controller.index()==0,
            label: 'Studenti',
            onTap: () {
              controller.index(0);
              context.goNamed('studenti');
            }
          ),              

          ExpansionTile(
              initiallyExpanded: controller.index()==1 || controller.index()==2,
              textColor: AppColors.onBackground,
              iconColor: AppColors.onBackground,
              title: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Text('Tirocinio Diretto'),
              ),
              children: [

                buildMenuItem(
                  index: 1,
                  isSelected: controller.index()==1,
                  label: 'Istituti scolastici',
                  onTap: () {
                    controller.index(1);
                    context.goNamed('istituti');
                  }
                ),  

                buildMenuItem(
                  index: 2,
                  isSelected: controller.index()==2,
                  label: 'Tutor',
                  onTap: () {
                    controller.index(2);
                    context.goNamed('tutors');
                  }
                ),

              ],
            ),
          

          ExpansionTile(
              initiallyExpanded: controller.index()==3 || controller.index()==4,
              textColor: AppColors.onBackground,
              iconColor: AppColors.onBackground,
              title: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Text('Tirocinio Indiretto'),
              ),
              children: [

                buildMenuItem(
                  index: 3,
                  isSelected: controller.index()==3,
                  label: 'Gruppi',
                  onTap: () {
                    controller.index(3);
                    context.goNamed('gruppi');
                  }
                ),  

                buildMenuItem(
                  index: 4,
                  isSelected: controller.index()==4,
                  label: 'Assegnazione primi anni',
                  onTap: () {
                    controller.index(4);
                    context.goNamed('assegnazioni');
                  }
                ),  

              ],
            ),
          

          buildMenuItem(
            index: 5,
            isSelected: controller.index()==5,
            label: 'Gestione utenti',
            onTap: () {
              controller.index(5);
              context.goNamed('utenti');
            }
          ),  

          buildMenuItem(
            index: 6,
            isSelected: controller.index()==6,
            label: 'Report',
            onTap: () {
              controller.index(6);
              context.goNamed('reports');
              Utils.showToast(context: context, text: 'Non ancora disponibile', isWarning: true,);
            }
          ),

          const Spacer(),

          
          ListTile(
            selected: false,
            contentPadding: EdgeInsets.only(left: 10.0),
            leading: VersionController.to.isVersionOutdated 
              ? const Icon(Icons.error_outlined, color: Colors.red,)
              : const Icon(Icons.check_circle),
            title: Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: Text('${VersionController.to.fullVersion}',
                style: VersionController.to.isVersionOutdated 
                  ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold) : null,
              ),
            ),
            onTap: (){
              if(VersionController.to.isVersionOutdated){
                Utils.showToast(context: context, text: 'Ricarica la finestra del browser per aggiornare alla versione più recente', isWarning: true);
              }else{
                Utils.showToast(context: context, text: 'Versione già aggiornata',);
              }
            },
          ),

          const Divider(thickness: 2,),

          buildMenuItem(
            index: 99,
            label: 'Esci',
            onTap: () {
              AuthController.to.logout();
              GoRouter.of(context).goNamed('login');
            }
          ),  
          
          

        ],
      ),
    );
  }

  Widget buildMenuItem({int index=0, bool isSelected=false, String label='', @required void Function()? onTap}){
    return ListTile(
      selected: controller.index()==index,
      title: Container(
        decoration: controller.index()==index ? BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.primary, width: 5)
          ),
        ) : null,
        padding: EdgeInsets.only(left: controller.index()==index ? 30 : 35.0),
        height: 56,
        alignment: Alignment.centerLeft,
        child: Text(label,),
      ),
      onTap: onTap ?? (){},
    );
  }
}