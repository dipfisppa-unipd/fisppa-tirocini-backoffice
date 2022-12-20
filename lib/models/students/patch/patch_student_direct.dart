// To parse this JSON data, do
//


import 'dart:convert';

import '../../td/institute_tutor_model.dart';

/// assignedChoice must always be an array [],
/// even if no data are passed
/// 
class PatchStudentDirect {
    PatchStudentDirect({
        this.assignedChoice,
        this.isAssignedChoiceConfirmed,
       this.instituteTutor,
    });

    final List<String>? assignedChoice;
    final bool? isAssignedChoiceConfirmed;
    final List<InstituteTutor>? instituteTutor;


    String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        "assignedChoice": assignedChoice == null ? [] : List<dynamic>.from(assignedChoice!.map((x) => x)),
        "isAssignedChoiceConfirmed": isAssignedChoiceConfirmed == null ? null : isAssignedChoiceConfirmed,
        "instituteTutor": instituteTutor == null ? [] : List<dynamic>.from(instituteTutor!.map((x) => x.toMap())),
    };
}