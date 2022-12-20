
// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_tirocini/models/td/institute_model.dart';
import 'package:unipd_tirocini/models/td/institute_tutor_model.dart';

import '../students/students_model.dart';

/// [choices] is now a List of List<String>
/// 
/// "choices": [
///   [
///     "PDIC845007",
///     "VE1A118008"
///   ],
///   [
///     "PDIC84400B"
///   ],
///   [
///     "PDIC824006"
///   ]
/// ],
/// 
class DirectInternship {
    DirectInternship({
        this.id,
        this.internshipYear,
        this.userId,
        this.v,
        this.calendarYear,
        this.createdAt,
        this.updatedAt,
        this.yearOfStudy,
        this.isAssignedChoiceConfirmed=false,
        this.notes='',
        this.choices, 
        this.assignedChoice = const [], // always one [ "PDIC845007" ],
        this.enhancedChoices,
        this.enhancedAssignedChoice,
        this.enhancedUser,
        this.instituteTutor = const [], // range 0-2
    });

    String? id;
    int? internshipYear;
    String? userId;
    int? v;
    int? calendarYear;
    List<List<String>>? choices;
    List<List<Institute>>? enhancedChoices;
    List<String> assignedChoice;
    List<Institute>? enhancedAssignedChoice;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? yearOfStudy;
    bool isAssignedChoiceConfirmed;
    String notes;
    Student? enhancedUser;
    List<InstituteTutor> instituteTutor;
    

    factory DirectInternship.fromJson(String str) => DirectInternship.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DirectInternship.fromMap(Map<String, dynamic> json) => DirectInternship(
        id: json["_id"] == null ? null : json["_id"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        userId: json["user_id"] == null ? null : json["user_id"],
        calendarYear: json["calendarYear"] == null ? null : json["calendarYear"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        yearOfStudy: json["yearOfStudy"] == null ? null : json["yearOfStudy"],
        isAssignedChoiceConfirmed: json["isAssignedChoiceConfirmed"] == null ? false : json["isAssignedChoiceConfirmed"],
        notes: json["notes"] == null ? '' : json["notes"],
        choices: json["choices"] == null ? null : _normalizeChoices(json["choices"]),
        assignedChoice: json["assignedChoice"] == null ? [] : List<String>.from(json["assignedChoice"].map((x)=>x)), 
        // enhancedChoices: json["enhancedChoices"] == null ? null : _normalizeEnhancedChoices(json["choices"], json["enhancedChoices"]),
        // enhancedAssignedChoice: json["enhancedAssignedChoice"] == null ? null : _normalizeEnahncedAssignedChoice(json["assignedChoice"], json["enhancedAssignedChoice"]),
        enhancedChoices: json["enhancedChoices"] == null ? null : List<List<Institute>>.from(json["enhancedChoices"].map((x) => List<Institute>.from(x.map((x) => Institute.fromMap(x))))),
        enhancedAssignedChoice: json["enhancedAssignedChoice"] == null ? null : List<Institute>.from(json["enhancedAssignedChoice"].map((x) => Institute.fromMap(x))),
        enhancedUser: json["enhancedUser"] == null ? null : Student.fromMap(json["enhancedUser"]),
        instituteTutor: json["instituteTutor"] == null ? [] : List<InstituteTutor>.from(json["instituteTutor"].map((x)=> InstituteTutor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "internshipYear": internshipYear == null ? null : internshipYear,
        "user_id": userId == null ? null : userId,
        "__v": v == null ? null : v,
        "assignedChoice": List<dynamic>.from(assignedChoice.map((x) => x)),
        "calendarYear": calendarYear == null ? null : calendarYear,
        "choices": choices == null ? null : List<dynamic>.from(choices!.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "yearOfStudy": yearOfStudy == null ? null : yearOfStudy,
        "isAssignedChoiceConfirmed": isAssignedChoiceConfirmed,
        "notes": notes,
    };

    // Custom
    static List<List<String>> _normalizeChoices(dynamic json) {

      List<List<String>> data = [];

      var dirty = List<dynamic>.from(json.map((x) => x));

      for(var d in dirty){
        if(d is List){
          List<String> choices = [];
          for(var s in d){
            choices.add(s);
          }

          data.add(choices);
        }
        else {
          data.add([d]);
        }
      }

      return data;
      
    }


    /// [instituteCode] is used to find the number of choice
    /// followed by the status of assignment {choiceNumber: 'Assegnato/Non assegnato/Confermato'}
    /// 
    Map<int, String> checkDirectStatus(String instituteCode,){

      var status = isAssignedChoiceConfirmed ? 'CONFERMATO' : 'Assegnato';

      if(choices==null || choices!.isEmpty) {
        if(assignedChoice.isNotEmpty){
          return {0: 'Manuale/$status'};
        }
      }

      var i = 1;
      var res;

      choices!.forEach((element) { 
       
        if(element.contains(instituteCode)){
            
            if(assignedChoice.isEmpty || !assignedChoice.contains(instituteCode))
              res = {i: 'Non assegnato'};
            else if(assignedChoice.first==instituteCode)
              res = {i: status};
            else if(assignedChoice.length>1 && assignedChoice.elementAt(1)==instituteCode)
              res = {i: status};
          
        }

        i++;
      });

      if(res!=null){
        return res;
      }else if(assignedChoice.isNotEmpty){
        return {0: 'Manuale/$status'};
      }

      return {0: '-'};

    }

    
}