import 'package:flutter/material.dart';
import 'package:unipd_tirocini/app/app_colors.dart';


class Loader extends StatelessWidget {

  final double size;

  const Loader({ this.size=50, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.primary),),
      ),
    );
  }
}

class LoaderPro extends StatelessWidget {
  final String message;

  const LoaderPro(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Loader(),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message,
              style: TextStyle(fontFamily: 'Oswald', fontSize: 20,),
            ),
          ),

        ],
      ),
    );
  }
}