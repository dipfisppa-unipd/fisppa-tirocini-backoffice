// To parse this JSON data, do
//
//     final careerModel = careerModelFromMap(jsonString);

import 'dart:convert';

// class CareerModel {
//     CareerModel({
//         @required this.career,
//     });

//     final Career career;

//     factory CareerModel.fromJson(String str) => CareerModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory CareerModel.fromMap(Map<String, dynamic> json) => CareerModel(
//         career: json["career"] == null ? null : Career.fromMap(json["career"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "career": career == null ? null : career.toMap(),
//     };
// }

class Career {
    Career({
        this.inProgress=true,
        this.finalScore=0,
        this.finalNotes='',
        this.academicYears= const [],
    });

    final bool inProgress;
    final int finalScore;
    final String finalNotes;
    final List<AcademicYear> academicYears;

    Career copyWith({
        bool? inProgress,
        int? finalScore,
        String? finalNotes,
        List<AcademicYear>? academicYears,
    }) => 
        Career(
            inProgress: inProgress ?? this.inProgress,
            finalScore: finalScore ?? this.finalScore,
            finalNotes: finalNotes ?? this.finalNotes,
            academicYears: academicYears ?? this.academicYears,);

    factory Career.fromJson(String str) => Career.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Career.fromMap(Map<String, dynamic> json) => Career(
        inProgress: json["inProgress"] == null ? true : json["inProgress"],
        finalScore: json["finalScore"] == null ? 0 : json["finalScore"],
        finalNotes: json["finalNotes"] == null ? '' : json["finalNotes"],
        academicYears: json["academicYears"] == null ? [] : List<AcademicYear>.from(json["academicYears"].map((x) => AcademicYear.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "inProgress": inProgress,
        "finalScore": finalScore,
        "finalNotes": finalNotes,
        "academicYears": List<dynamic>.from(academicYears.map((x) => x.toMap())),
    };
}

class AcademicYear {
    AcademicYear({
        this.calendarYear,
        this.universityOfOrigin,
        this.universityCity,
        this.erasmus,
        this.jobs = const [],
        this.reductionPercentage = 0,
        this.reductionRight = false,
    });

    final int? calendarYear;
    final String? universityOfOrigin;
    final String? universityCity;
    final Erasmus? erasmus;
    final List<Job> jobs;
    final int reductionPercentage;
    final bool reductionRight;

    AcademicYear copyWith({
        int? calendarYear,
        String? universityOfOrigin,
        String? universityCity,
        Erasmus? erasmus,
        List<Job> jobs = const [],
        int? reductionPercentage,
        bool? reductionRight,
    }) => 
        AcademicYear(
            calendarYear: calendarYear ?? this.calendarYear,
            universityOfOrigin: universityOfOrigin ?? this.universityOfOrigin,
            universityCity: universityCity ?? this.universityCity,
            erasmus: erasmus ?? this.erasmus,
            jobs: jobs.isNotEmpty ? jobs : this.jobs,
            reductionPercentage: reductionPercentage ?? this.reductionPercentage,
            reductionRight: reductionRight ?? this.reductionRight
        );

    factory AcademicYear.fromJson(String str) => AcademicYear.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AcademicYear.fromMap(Map<String, dynamic> json) => AcademicYear(
        calendarYear: json["calendarYear"] == null ? null : json["calendarYear"],
        universityOfOrigin: json["universityOfOrigin"] == null ? null : json["universityOfOrigin"],
        universityCity: json["universityCity"] == null ? null : json["universityCity"],
        erasmus: json["erasmus"] == null ? null : Erasmus.fromMap(json["erasmus"]),
        jobs: json["jobs"] == null ? [] : List<Job>.from(json['jobs'].map((x) => Job.fromMap(x))),
        reductionPercentage: json["reductionPercentage"] == null ? 0 : json["reductionPercentage"],
        reductionRight: json["reductionRight"] == null ? false : json["reductionRight"],
    );

    Map<String, dynamic> toMap() => {
        "calendarYear": calendarYear == null ? null : calendarYear,
        "universityOfOrigin": universityOfOrigin == null ? null : universityOfOrigin,
        "universityCity": universityCity == null ? null : universityCity,
        "erasmus": erasmus == null ? null : erasmus!.toMap(),
        "jobs": List<dynamic>.from(jobs.map((x) => x.toMap())),
        "reductionPercentage": reductionPercentage,
        "reductionRight": reductionRight,
    };
}

class Erasmus {
    Erasmus({
        this.university,
        this.state,
        this.address,
        this.email,
        this.notes,
    });

    final String? university;
    final String? state;
    final String? address;
    final String? email, notes;

    Erasmus copyWith({
        String? university,
        String? state,
        String? address,
        String? email,
        String? notes,
    }) => 
        Erasmus(
            university: university ?? this.university,
            state: state ?? this.state,
            address: address ?? this.address,
            email: email ?? this.email,
            notes: notes ?? this.notes,
        );

    static Erasmus empty() => 
        Erasmus(
            university: '',
            state: '',
            address: '',
            email: '',
        );

    factory Erasmus.fromJson(String str) => Erasmus.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Erasmus.fromMap(Map<String, dynamic> json) => Erasmus(
        university: json["university"] == null ? null : json["university"],
        state: json["state"] == null ? null : json["state"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
        notes: json["notes"] == null ? null : json["notes"],
    );

    Map<String, dynamic> toMap() => {
        "university": university == null ? null : university,
        "state": state == null ? null : state,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
        "notes": notes == null ? null : notes,
    };
}

class Job {
    Job({
        this.schoolDegree,
        this.contractType,
        this.contractDuration=0,
        this.weeklySchedule=0,
        this.workLocation,
        this.notes='',
        this.schoolCode,
        this.role,
    });

    final String? schoolDegree;
    final String? contractType;
    final int contractDuration; // in days
    final int weeklySchedule;
    final String? workLocation;
    final String notes;
    final String? schoolCode, role;


    Job copyWith({
        bool? reductionRight,
        String? schoolDegree,
        String? contractType,
        int? contractDuration,
        int? weeklySchedule,
        int? percentageReduction,
        String? workLocation,
        String? notes,
    }) => 
        Job(
            schoolDegree: schoolDegree ?? this.schoolDegree,
            contractType: contractType ?? this.contractType,
            contractDuration: contractDuration ?? this.contractDuration,
            weeklySchedule: weeklySchedule ?? this.weeklySchedule,
            workLocation: workLocation ?? this.workLocation,
            notes: notes ?? this.notes,
        );

    static Job empty() => 
        Job(
            schoolCode: '',
            schoolDegree: '',
            contractType: '',
            contractDuration: 0,
            weeklySchedule: 0,
            role: '',
            workLocation: '',
            notes: '',
        );

    factory Job.fromJson(String str) => Job.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Job.fromMap(Map<String, dynamic> json) => Job(
        schoolCode: json["schoolCode"] == null ? false : json["schoolCode"],
        schoolDegree: json["schoolDegree"] == null ? null : json["schoolDegree"],
        contractType: json["contractType"] == null ? null : json["contractType"],
        contractDuration: json["contractDuration"] == null ? 0 : json["contractDuration"],
        weeklySchedule: json["weeklySchedule"] == null ? 0 : json["weeklySchedule"],
        role: json["role"] == null ? 0 : json["role"],
        workLocation: json["workLocation"] == null ? null : json["workLocation"],
        notes: json["notes"] == null ? null : json["notes"],
    );

    Map<String, dynamic> toMap() => {
        "role": role,
        "schoolDegree": schoolDegree == null ? null : schoolDegree,
        "contractType": contractType == null ? null : contractType,
        "contractDuration": contractDuration,
        "weeklySchedule": weeklySchedule,
        "schoolCode": schoolCode,
        "workLocation": workLocation,
        "notes": notes,
    };
}
