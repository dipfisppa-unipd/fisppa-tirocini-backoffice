import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:unipd_tirocini/app/app_colors.dart';

import '../services/context_service.dart';
import '../widgets/containers/alert_box.dart';


class Validator {
  //It's mandatory.
  static String? validateText(String value) {
    if (value.replaceAll(' ', '').isEmpty) {
      return 'Perfavore, compila questo campo.';
    } else {
      return null;
    }
  }

  static String? validateUserPassword(String value) {
    if (value.replaceAll(' ', '').length < 8) {
      return 'La password deve contenere almeno 8 caratteri';
    } else {
      return null;
    }
  }

  static bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}

class Utils {
  static final DateFormat _fDateBody = new DateFormat('yyyy/MM/dd');
  static final DateFormat _fDate = new DateFormat('dd/MM/yyyy');
  static final DateFormat _fDatePdf = new DateFormat('dd-MM-yyyy');
  static final DateFormat _fDateTimePdf = new DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _fShortDate = new DateFormat('dd/MM');

  static String formatDate(DateTime d){
    return isToday(d) ? 'Oggi' : _fDate.format(d.toLocal());
  } 

  static String formatShortDate(DateTime d, {bool isPrinting=false}) {
    if(isPrinting)
      return _fShortDate.format(d.toLocal());

    return isToday(d) ? 'Oggi' : _fShortDate.format(d.toLocal());
  } 

  /// Ritorna la data nel formato yyyy/MM/dd per le API request
  static String formatDateBody(DateTime d) => _fDateBody.format(d.toLocal());
  static String formatDatePdf(DateTime d) => _fDatePdf.format(d.toLocal());
  static String formatDateTimePdf(DateTime d) => _fDateTimePdf.format(d.toLocal());

  static DateTime onlyToday(DateTime d) => DateTime(d.year, d.month, d.day);

  static bool isToday(DateTime d) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime check = DateTime(d.year, d.month, d.day);

    return today == check;
  }

  static String period(DateTime dataInizio, DateTime dataFine, {bool isPrinting=false, bool isMultiLang=false}) {

    if(isPrinting && isMultiLang){
      return 'Dal/vom/from ${_fDate.format(dataInizio)} al/bis/to ${_fDate.format(dataFine)}';
    }else if(isPrinting && !isMultiLang)
      return 'Dal ${_fDate.format(dataInizio)} al ${_fDate.format(dataFine)}';
      
    String a = formatShortDate(dataInizio);
    String b = formatShortDate(dataFine);

    return '$a - $b';
  }

  static bool isInRange(DateTime check, DateTime from, DateTime to){
    if( check.isBefore(to.add(Duration(days: 1))) && check.isAfter(from.subtract(Duration(days: 1))))
      return true;

    return false;
  }

  static void showToast({context, String text='', bool isError=false, bool isWarning=false}){
    FToast fToast = FToast();
    fToast = fToast.init(context ?? GetContext.find!);
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isError ? AppColors.error : isWarning ? AppColors.warning : AppColors.success,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(isError ? Icons.close : isWarning ? Icons.error : Icons.check, color: Colors.white,),
            const SizedBox(width: 12.0,),
            Text(text, style: TextStyle(color: Colors.white),),
        ],
        ),
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.TOP,
        toastDuration: Duration(seconds: 2),
        fadeDuration: 260
    );

    // Fluttertoast.showToast(
    //     msg: title,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP_RIGHT,
    //     timeInSecForIosWeb: 2,
    //     backgroundColor: isError ? AppColors.error : isWarning ? AppColors.orangeTextColor : AppColors.success ,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //     webBgColor: isError 
    //       ? "linear-gradient(to right, #DD536C, #DD536C)" 
    //       : isWarning 
    //         ? "linear-gradient(to right, #FF9001, #FF9001)" 
    //         : "linear-gradient(to right, #2EB979, #2EB979)",
    // );
  }

  static void copyText(context, String text){
    FlutterClipboard.copy(text).then(( value ) => showToast(context: context, text: 'Copiato: $text'));
  }

  static Future<DateTime?> pickDate(context, {bool full=false, int maxYear=2100}) async {
    if(full){
      return await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2000), 
        lastDate: DateTime(maxYear));
    }

    return await showMonthYearPicker(
      initialMonthYearPickerMode: MonthYearPickerMode.year,
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(DateTime.now().year+1, 12),
    );
  }

  static void alertBox(context, {String message='', double width=450, String buttonText='CONFERMA', onTap}) {
    
    AlertBox alert = AlertBox(
      width: width,
      onTap: ()=>onTap(),
      button: buttonText,
      children: [
        Text(
          message, 
          style: TextStyle(fontSize: 22, fontFamily: 'Oswald',),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    
  }

  // static Result<Exception, int> toInt(String s){

  //   try{
      
  //   }catch(e){

  //   }

  // }

}
