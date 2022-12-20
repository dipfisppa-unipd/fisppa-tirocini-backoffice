import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/utils/utils.dart';

// typedef PatchFieldValue = void Function(String value,);

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({ 
    Key? key, 
    required this.label, 
    this.ctrl, 
    this.onChanged,
    this.onTap,
    this.hint,
    this.isReadOnly = false,
    this.withCopyButton = false,
    this.minLines = 1,
    this.withLink,
  }) : super(key: key);

  final String label;
  final TextEditingController? ctrl;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? hint;
  final bool isReadOnly, withCopyButton;
  final int minLines;
  final String? withLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Padding(
          padding: const EdgeInsets.only(bottom: 17),
          child: Text(label, style: AppStyles.textFieldLabel, textAlign: TextAlign.start,),
        ),

        SizedBox(
          height: minLines * 42,
          child: TextFormField(
            controller: ctrl,
            minLines: minLines,
            maxLines: minLines,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.lightText, width: 1),
                borderRadius: BorderRadius.circular(4)
              ),
              suffixIcon: 
                withCopyButton 
                  ? IconButton(onPressed: (){
                      if(ctrl?.text.isNotEmpty??false)
                        Utils.copyText(context, ctrl?.text ?? '');
                      else
                        Utils.showToast(context: context, isWarning: true, text: 'Nessun testo da copiare');
                      
                    }, icon: Icon(Icons.copy)) 
                  : withLink!=null 
                  ? IconButton(onPressed: (){
                      GoRouter.of(context).push(withLink!);
                    }, icon: Icon(Icons.link)) 
                  : null,
            ),
            onChanged: onChanged,
            onTap: onTap,
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(hint ?? '', style: TextStyle(color: AppColors.primary), textAlign: TextAlign.start,),
        ),

      ]
    );
  }
}

class LabeledField extends StatelessWidget {
  const LabeledField({ Key? key, required this.label, required this.child, this.hint}) : super(key: key);

  final String label;
  final Widget child;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 17),
          child: Text(label, style: AppStyles.textFieldLabel, textAlign: TextAlign.start,),
        ),
        
        SizedBox(
          height: 42, 
          child: child,
        ),

        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(hint ?? '', style: TextStyle(color: AppColors.primary), textAlign: TextAlign.start,),
        ),
      ]
    );
  }
}