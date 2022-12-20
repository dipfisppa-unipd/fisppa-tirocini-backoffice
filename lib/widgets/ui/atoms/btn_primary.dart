import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unipd_tirocini/widgets/loader.dart';

import '../../../app/app_colors.dart';


class BtnPrimary extends StatelessWidget {
  const BtnPrimary({ Key? key, required this.text, required this.onTap }) : super(key: key);


  final String text;
  //final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: ElevatedButton(
        onPressed: ()  => onTap(), 
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Text(text.toUpperCase(), style: TextStyle(fontFamily: 'Lato', fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF99051A)),
        ),
        ),
    );
  }
}

class FilledBtnIcon extends StatefulWidget {

  final Future<void> Function() onPressed;
  final Icon icon;

  const FilledBtnIcon({ Key? key, required this.onPressed, required this.icon }) : super(key: key);

  @override
  State<FilledBtnIcon> createState() => _FilledBtnIconState();
}

class _FilledBtnIconState extends State<FilledBtnIcon> {

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    if(isPressed) return Loader(size: 36);
    
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isPressed = true;
        });
        
        await widget.onPressed();

        setState(() {
          isPressed = false;
        });
      }, 
      child: widget.icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        )
      ),
    );
  }
}

class FilledBtn extends StatefulWidget {

  final Future<void> Function() onPressed;
  final String text;
  final bool rounded;

  const FilledBtn({ Key? key, this.rounded=false, required this.onPressed, required this.text }) : super(key: key);

  @override
  State<FilledBtn> createState() => _FilledBtnState();
}

class _FilledBtnState extends State<FilledBtn> {

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    if(isPressed) return Loader(size: 36);
    
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isPressed = true;
        });
        
        await widget.onPressed();

        setState(() {
          isPressed = false;
        });
      }, 
      child: AutoSizeText(widget.text, style: TextStyle(color: Colors.white,), minFontSize: 12, maxFontSize: 16,),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        minimumSize: widget.rounded ? const Size(100, 46) : const Size(140, 66),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.rounded ? 4 : 0),
        )
      ),
    );
  }
}

class OutlinedBtn extends StatefulWidget {

  final Future<void> Function() onPressed;
  final String text;

  const OutlinedBtn({ Key? key, required this.onPressed, required this.text }) : super(key: key);

  @override
  State<OutlinedBtn> createState() => _OutlinedBtnState();
}

class _OutlinedBtnState extends State<OutlinedBtn> {

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    if(isPressed) return Loader(size: 36);

    return OutlinedButton(
      onPressed: () async {
        setState(() {
          isPressed = true;
        });
        
        await widget.onPressed();

        setState(() {
          isPressed = false;
        });
      }, 
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: AutoSizeText(widget.text, style: TextStyle(color: AppColors.primary,), minFontSize: 12, maxFontSize: 16,),
      ),
    );
  }
}