// To parse this JSON data, do
//
//     final patchStudentIndirect = patchStudentIndirectFromMap(jsonString);


import 'dart:convert';



class PatchStudentIndirect {
    PatchStudentIndirect({
        this.assignedChoice,
        this.isAssignedChoiceConfirmed,
        this.isApproved,
        this.evaluation,
        this.internalNotes,
    });

    final String? assignedChoice;
    final bool? isAssignedChoiceConfirmed;
    final bool? isApproved;
    final int? evaluation;
    final String? internalNotes;

    factory PatchStudentIndirect.fromJson(String str) => PatchStudentIndirect.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PatchStudentIndirect.fromMap(Map<String, dynamic> json) => PatchStudentIndirect(
        assignedChoice: json["assignedChoice"] == null ? null : json["assignedChoice"],
        isAssignedChoiceConfirmed: json["isAssignedChoiceConfirmed"] == null ? null : json["isAssignedChoiceConfirmed"],
        isApproved: json["isApproved"] == null ? null : json["isApproved"],
        evaluation: json["evaluation"] == null ? null : json["evaluation"],
        internalNotes: json["internalNotes"] == null ? null : json["internalNotes"],
    );

    Map<String, dynamic> toMap() => {
        "assignedChoice": assignedChoice == null ? null : assignedChoice,
        "isAssignedChoiceConfirmed": isAssignedChoiceConfirmed == null ? null : isAssignedChoiceConfirmed,
        "isApproved": isApproved == null ? null : isApproved,
        "evaluation": evaluation == null ? null : evaluation,
        "internalNotes": internalNotes == null ? null : internalNotes,
    };

    Map<String, dynamic> toPatch() => {
        "assignedChoice": assignedChoice == null ? null : assignedChoice,
        "isAssignedChoiceConfirmed": isAssignedChoiceConfirmed == null ? null : isAssignedChoiceConfirmed,
        "isApproved": isApproved == null ? null : isApproved,
        "evaluation": evaluation == null ? null : evaluation,
        "internalNotes": internalNotes == null ? null : internalNotes,
    }..removeWhere((String key, dynamic value) => value == null);
}


