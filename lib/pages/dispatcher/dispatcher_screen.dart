import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/loader.dart';

import 'dispatcher_controller.dart';

class DispatcherScreen extends StatelessWidget {

  const DispatcherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DispatcherController>(
        init: DispatcherController(context,),
        builder: (ctrl) {
          return SizedBox.expand(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Loader(),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Attendere prego, caricamento in corso',
                    style: TextStyle(fontFamily: 'Oswald', fontSize: 20,),
                  ),
                ),

              ],
            ),
          );
        }
      )
    );
  }
}
