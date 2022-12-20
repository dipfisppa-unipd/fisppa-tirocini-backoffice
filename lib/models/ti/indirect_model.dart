// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_tirocini/models/students/students_model.dart';
import 'package:unipd_tirocini/models/ti/territoriality_model.dart';

import 'group_model.dart';


class IndirectInternship {
    IndirectInternship({
        this.id,
        this.internshipYear,
        this.userId,
        this.v,
        this.calendarYear,
        this.choices,
        this.createdAt,
        this.updatedAt,
        this.enhancedChoices,
        this.assignedChoice,
        this.enhancedAssignedChoice,
        this.enhancedUser,
        this.isAssignedChoiceConfirmed=false,
        this.isProjectApproved=false,
        this.notes='',
        this.internalNotes='',
        this.evaluation=0,
    });

    String? id;
    int? internshipYear;
    String? userId;
    int? v;
    int? calendarYear;
    List<String>? choices;
    List<TerritorialityModel>? enhancedChoices;   // List format 
    String? assignedChoice;
    GroupModel? enhancedAssignedChoice;  // Single TerritorialityModel
    DateTime? createdAt;
    DateTime? updatedAt;
    Student? enhancedUser;
    bool isAssignedChoiceConfirmed, isProjectApproved;
    String notes, internalNotes;
    int evaluation;

    IndirectInternship copyWith({
        String? id,
        int? internshipYear,
        String? userId,
        int? v,
        int? calendarYear,
        List<String>? choices,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        IndirectInternship(
            id: id ?? this.id,
            internshipYear: internshipYear ?? this.internshipYear,
            userId: userId ?? this.userId,
            v: v ?? this.v,
            calendarYear: calendarYear ?? this.calendarYear,
            choices: choices ?? this.choices,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory IndirectInternship.fromJson(String str) => IndirectInternship.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory IndirectInternship.fromMap(Map<String, dynamic> json) => IndirectInternship(
        id: json["_id"] == null ? null : json["_id"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        userId: json["user_id"] == null ? null : json["user_id"],
        v: json["__v"] == null ? null : json["__v"],
        calendarYear: json["calendarYear"] == null ? null : json["calendarYear"],
        choices: json["choices"] == null ? null : List<String>.from(json["choices"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        enhancedChoices: json["enhancedChoices"] == null ? null : List<TerritorialityModel>.from(json["enhancedChoices"].map((x) => TerritorialityModel.fromMap(x))),
        assignedChoice: json["assignedChoice"] == null ? null : json["assignedChoice"],
        enhancedAssignedChoice: json["enhancedAssignedChoice"] == null ? null : GroupModel.fromMap(json["enhancedAssignedChoice"]),
        enhancedUser: json["enhancedUser"] == null ? null : Student.fromMap(json["enhancedUser"]),
        isAssignedChoiceConfirmed: json["isAssignedChoiceConfirmed"] == null ? false : json["isAssignedChoiceConfirmed"],
        isProjectApproved: json["isApproved"] == null ? false : json["isApproved"],
        notes: json["notes"] == null ? '' : json["notes"],
        internalNotes: json["internalNotes"] == null ? '' : json["internalNotes"],
        evaluation: json["evaluation"] == null ? 0 : json["evaluation"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "internshipYear": internshipYear == null ? null : internshipYear,
        "user_id": userId == null ? null : userId,
        "__v": v == null ? null : v,
        "calendarYear": calendarYear == null ? null : calendarYear,
        "choices": choices == null ? null : List<dynamic>.from(choices!.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}