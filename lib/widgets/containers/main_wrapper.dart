import 'package:flutter/material.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';



class MainWrapper extends StatelessWidget {

  final Widget? child;
  final String? title;
  final List<Widget> actions;

  const MainWrapper({@required this.title, @required this.child, this.actions=const [], Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (_, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
          
                    const SizedBox(height: 54,),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
          
                        Expanded(
                          child: Text(title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)
                        ),
          
                        ...actions,
          
                      ],
                    ),
          
                    const SizedBox(height: 30),
          
                    WhiteBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 32,),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      
    );
  }
}