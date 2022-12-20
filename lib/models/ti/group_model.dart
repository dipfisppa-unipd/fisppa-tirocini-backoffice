// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_tirocini/models/ti/indirect_model.dart';
import 'package:unipd_tirocini/models/user.dart';

class GroupModel {
    GroupModel({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.territorialityId,
        required this.foundationYear,
        this.name,
        this.internshipYear,
        this.indirectInternships,
        this.notes,
        this.coordinatorTutor,
        this.coordinatorTutorId,
        this.organizerTutor,
        this.organizerTutorId,
    });

    final String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? territorialityId, territorialityName; // custom territorialityName
    UserModel? coordinatorTutor, organizerTutor;
    String? coordinatorTutorId, organizerTutorId;
    int foundationYear;
    String? name, notes;
    int? internshipYear;
    List<IndirectInternship>? indirectInternships;


    int get numOfStudents => indirectInternships?.length ?? 0;

    
    factory GroupModel.fromJson(String str) => GroupModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
        id: json["_id"] == null ? null : json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        territorialityId: json["territoriality_id"] == null ? null : json["territoriality_id"],
        
        coordinatorTutor: json["coordinatorTutor"] is String || json["coordinatorTutor"] == null ? null : UserModel.fromMap(json["coordinatorTutor"]),
        organizerTutor: json["organizerTutor"] is String || json["organizerTutor"] == null ? null : UserModel.fromMap(json["organizerTutor"]),
        coordinatorTutorId: json["coordinatorTutor"] is Map<String, dynamic> ? null : json["coordinatorTutor"],
        organizerTutorId: json["organizerTutor"] is Map<String, dynamic> ? null : json["organizerTutor"],

        name: json["name"] == null ? null : json["name"],
        foundationYear: json["foundationYear"] == null ? 0 : json["foundationYear"],
        notes: json["notes"] == null ? null : json["notes"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        indirectInternships: json["indirectInternships"] == null ? null : List<IndirectInternship>.from(json["indirectInternships"].map((x)=>IndirectInternship.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "territoriality_id": territorialityId == null ? null : territorialityId,
        "coordinatorTutor": coordinatorTutorId,
        "organizerTutor": organizerTutorId,
        "foundationYear": foundationYear,
        "notes": notes,
    };
}
