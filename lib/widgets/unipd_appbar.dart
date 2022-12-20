import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';

import '../controllers/auth_controller.dart';

class UnipdAppBar extends StatelessWidget implements PreferredSizeWidget{

  final bool withRealDrawer;
  
  const UnipdAppBar({this.withRealDrawer=false, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: withRealDrawer,
      toolbarHeight: 70,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          const SizedBox(width: 10),

          Row(
            children: [
              Image.asset('assets/images/logo_unipd.png', height: 52, width: 56,),
  
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: const Text('Corso di laurea in Scienze della Formazione Primaria',
                  style: TextStyle(fontFamily: 'Oswald', fontSize: 16, color: AppColors.white, letterSpacing: 1,),
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AuthController.to.user?.email ?? 'Utente', style: TextStyle(fontSize: 14),),
              ),
              IconButton(
                icon: Icon(Icons.logout_outlined),
                onPressed: (){
                  AuthController.to.logout();
                  GoRouter.of(context).goNamed('login');
                },
              ),
            ]
          ),

          const SizedBox(width: 10),

        ],
      ),
      leading: null,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(70);
}