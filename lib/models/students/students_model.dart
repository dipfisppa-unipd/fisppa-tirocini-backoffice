// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:unipd_tirocini/utils/ucfirst.dart';

import '../td/direct_model.dart';
import '../ti/indirect_model.dart';
import 'career_model.dart';



class StudentsModel {
    StudentsModel({
        this.students,
        this.total,
    });

    List<Student>? students;
    int? total;

    StudentsModel copyWith({
        List<Student>? students,
        int? total,
    }) => 
        StudentsModel(
            students: students ?? this.students,
            total: total ?? this.total,
        );

    factory StudentsModel.fromJson(String str) => StudentsModel.fromMap(json.decode(str));


    factory StudentsModel.fromMap(Map<String, dynamic> json) => StudentsModel(
        students: json["users"] == null ? null : List<Student>.from(json["users"].map((x) => Student.fromMap(x))),
        total: json["total"] == null ? null : json["total"],
    );

}

class Student {
    Student({
        this.id,
        this.email,
        this.v,
        this.createdAt,
        this.registry,
        this.university,
        this.updatedAt,
        this.isAdmin,
        this.indirectInternships = const [],
        this.directInternships = const [],
        this.career,
    });

    String? id;
    String? email;
    int? v;
    DateTime? createdAt;
    Registry? registry;
    University? university;
    DateTime? updatedAt;
    bool? isAdmin;
    List<IndirectInternship> indirectInternships;
    List<DirectInternship> directInternships;
    Career? career;

    String get fullname => registry==null ? 'nd' : '${registry!.lastName} ${registry!.firstName}';
    String get domicile => registry==null || registry!.domicile==null ? 'nd' : '${registry!.domicile?.city}';
    String get fullDomicile => registry==null || registry!.domicile==null ? 'nd' : '${registry!.domicile?.city}\n${registry!.domicile?.province}';

    Student copyWith({
        String? email,
        Registry? registry,
        University? university,
        Career? career,
    }) => 
        Student(
            id: id ?? this.id,
            email: email ?? this.email,
            registry: registry ?? this.registry,
            university: university ?? this.university,
            career: career ?? this.career,
        );

    
    factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Student.fromMap(Map<String, dynamic> json) => Student(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        v: json["__v"] == null ? null : json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        registry: json["registry"] == null ? null : Registry.fromMap(json["registry"]),
        university: json["university"] == null ? null : University.fromMap(json["university"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        indirectInternships: json["indirectInternships"] == null ? [] : List<IndirectInternship>.from(json["indirectInternships"].map((x) => IndirectInternship.fromMap(x))),
        directInternships: json["directInternships"] == null ? [] : List<DirectInternship>.from(json["directInternships"].map((x) => DirectInternship.fromMap(x))),
        career: json['career'] == null ? null : Career.fromMap(json["career"]),
    );

    Map<String, dynamic> toMap() => {
        "registry": registry?.toMap(),
        "university": university?.toMap(),
        // "indirectInternships": List<dynamic>.from(indirectInternships.map((x) => x.toMap())),
        // "directInternships": List<dynamic>.from(directInternships.map((x) => x.toMap())),
        "career": career?.toMap(),
    };

    /// Passing [calendarYear], the academic year resulting
    /// will be modified accordingly
    int academicYear({int calendarYear=0}){

      var modifier = 0;
      if(calendarYear>0){
        modifier = DateTime.now().year - calendarYear;
      }

      var y = 0;

      if(university!=null && university!.year!.isNotEmpty){
        switch(university!.year!){
          case 'Primo': y = 1; break;
          case 'Secondo': y = 2; break;
          case 'Terzo': y = 3; break;
          case 'Quarto': y = 4; break;
          case 'Quinto': y = 5; break;
          case 'Sesto': y = 6; break;
          default: y=0;
        }
      }
      return y-modifier;
    }

    int getInternshipYear({int? calendarYear}){

      if(calendarYear==null){
        calendarYear = DateTime.now().year;
      }

      if(indirectInternships.isNotEmpty){
        IndirectInternship i = indirectInternships.firstWhere((element) => element.calendarYear==calendarYear, orElse: ()=>IndirectInternship(internshipYear: 0));

        return i.internshipYear ?? 0;

      }else if(directInternships.isNotEmpty){
        DirectInternship i = directInternships.firstWhere((element) => element.calendarYear==calendarYear, orElse: ()=>DirectInternship(internshipYear: 0));

        return i.internshipYear!;
      }

      return 0;
    }

    bool isInErasmus({int? calendarYear}){
      if(calendarYear==null){
        calendarYear = DateTime.now().year;
      }

      if(career==null) return false;

      var academicYear = career!.academicYears.firstWhere((element) => element.calendarYear==calendarYear, orElse: ()=>AcademicYear());

      return academicYear.erasmus!=null && academicYear.erasmus!.university!=null && academicYear.erasmus!.university!.isNotEmpty;
    }

    /// IF [isWorking], return the P or I letter for
    /// primary or kids school.
    /// return '' empty if not working.
    /// 
    String isWorking({int? calendarYear}){
      if(calendarYear==null){
        calendarYear = DateTime.now().year;
      }

      if(career==null) return '';

      var academicYear = career!.academicYears.firstWhere((element) => element.calendarYear==calendarYear, orElse: ()=>AcademicYear());

      if(academicYear.jobs.isNotEmpty){    
        if(academicYear.jobs.last.schoolCode!=null){
          return academicYear.jobs.last.schoolDegree=='primaria' ? 'P' : 'I';
        }
      } 
  
      return '';
    }

    String getConfirmedIndirect({int? calendarYear, bool getLast=false}){

      if(calendarYear==null){
        calendarYear = DateTime.now().year;
      }

      if(indirectInternships.isEmpty) return '-';

      if(getLast){
        if(indirectInternships.last.enhancedAssignedChoice!=null && indirectInternships.last.isAssignedChoiceConfirmed)
          return indirectInternships.last.enhancedAssignedChoice!.name!;
      }

      for(var i in indirectInternships){
        if(i.calendarYear==calendarYear) {
          if(i.enhancedAssignedChoice!=null){
            String name = i.enhancedAssignedChoice!.name ?? '';
            name = '$name [${i.enhancedAssignedChoice!.foundationYear}]';

            return name;
          }
        }
      }

      return '-';
    }

    String getConfirmedDirect({int? calendarYear, bool getLast=false}){

      if(calendarYear==null)
        calendarYear = DateTime.now().year;
      
      if(directInternships.isEmpty) 
        return '-';

      DirectInternship? i;

      if(getLast){
        i = directInternships.last;
      }else{
        for(var d in directInternships)
        if(d.calendarYear==calendarYear)
          i = d;
      }

      if(i!=null && i.isAssignedChoiceConfirmed && i.enhancedAssignedChoice!=null && i.enhancedAssignedChoice!.isNotEmpty){
        String name = ' ${i.enhancedAssignedChoice!.first.name}';

        if(i.enhancedAssignedChoice!.length>1)
          name += '\n ${i.enhancedAssignedChoice!.elementAt(1).name}';

        return name.toUCFirst();
      }

      return '-';
    }

    


}



class Registry {
    Registry({
        this.firstName,
        this.lastName,
        this.personalEmail,
        this.cellNumber,
        this.residence,
        this.domicile,
    });

    String? firstName;
    String? lastName;
    String? personalEmail;
    String? cellNumber;
    Domicile? residence;
    Domicile? domicile;

    Registry copyWith({
        String? firstName,
        String? lastName,
        String? personalEmail,
        String? cellNumber,
        Domicile? residence,
        Domicile? domicile,
    }) => 
        Registry(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            personalEmail: personalEmail ?? this.personalEmail,
            cellNumber: cellNumber ?? this.cellNumber,
            residence: residence ?? this.residence,
            domicile: domicile ?? this.domicile,
        );

    factory Registry.fromJson(String str) => Registry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Registry.fromMap(Map<String, dynamic> json) => Registry(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        personalEmail: json["personalEmail"] == null ? null : json["personalEmail"],
        cellNumber: json["cellNumber"] == null ? null : json["cellNumber"],
        residence: json["residence"] == null ? null : Domicile.fromMap(json["residence"]),
        domicile: json["domicile"] == null ? null : Domicile.fromMap(json["domicile"]),
    );

    Map<String, dynamic> toMap() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "personalEmail": personalEmail == null ? null : personalEmail,
        "cellNumber": cellNumber == null ? null : cellNumber,
        "residence": residence == null ? null : residence!.toMap(),
        "domicile": domicile == null ? null : domicile!.toMap(),
    };
}

// ignore: must_be_immutable
class Domicile extends Equatable {
    Domicile({
        this.street,
        this.city,
        this.cap,
        this.province,
    });

    String? street;
    String? city;
    String? cap;
    String? province;

    Domicile copyWith({
        String? street,
        String? city,
        String? cap,
        String? province,
    }) => 
        Domicile(
            street: street ?? this.street,
            city: city ?? this.city,
            cap: cap ?? this.cap,
            province: province ?? this.province,
        );

    factory Domicile.fromJson(String str) => Domicile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Domicile.fromMap(Map<String, dynamic> json) => Domicile(
        street: json["street"] == null ? null : json["street"],
        city: json["city"] == null ? null : json["city"],
        cap: json["cap"] == null ? null : json["cap"],
        province: json["province"] == null ? null : json["province"],
    );

    Map<String, dynamic> toMap() => {
        "street": street == null ? null : street,
        "city": city == null ? null : city,
        "cap": cap == null ? null : cap,
        "province": province == null ? null : province,
    };
    
      @override
      List<Object?> get props => [city, street];
}

class University {
    University({
        this.studentNumber,
        this.codCourse,
        this.codCourseName,
        this.degreeType,
        this.degreeTypeCode,
        this.faculty,
        this.enrollmentType,
        this.year,
        this.earnedCreditsNumber,
        this.earnedCreditsNotes,
    });

    String? studentNumber;
    String? codCourse;
    String? codCourseName;
    String? degreeType;
    String? degreeTypeCode;
    String? faculty;
    String? enrollmentType;
    String? year;
    int? earnedCreditsNumber;
    String? earnedCreditsNotes;

    int get credits => earnedCreditsNumber ?? 0;

    University copyWith({
        
        int? earnedCreditsNumber,
        String? earnedCreditsNotes,
    }) => 
        University(
            
            earnedCreditsNumber: earnedCreditsNumber ?? this.earnedCreditsNumber,
            earnedCreditsNotes: earnedCreditsNotes ?? this.earnedCreditsNotes,
        );

    factory University.fromJson(String str) => University.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory University.fromMap(Map<String, dynamic> json) => University(
        studentNumber: json["studentNumber"] == null ? null : json["studentNumber"],
        codCourse: json["codCourse"] == null ? null : json["codCourse"],
        codCourseName: json["codCourseName"] == null ? null : json["codCourseName"],
        degreeType: json["degreeType"] == null ? null : json["degreeType"],
        degreeTypeCode: json["degreeTypeCode"] == null ? null : json["degreeTypeCode"],
        faculty: json["faculty"] == null ? null : json["faculty"],
        enrollmentType: json["enrollmentType"] == null ? null : json["enrollmentType"],
        year: json["year"] == null ? null : json["year"],
        earnedCreditsNumber: json["earnedCreditsNumber"] == null ? 0 : json["earnedCreditsNumber"],
        earnedCreditsNotes: json["earnedCreditsNotes"] == null ? '' : json["earnedCreditsNotes"],
    );

    Map<String, dynamic> toMap() => {
        // "studentNumber": studentNumber == null ? null : studentNumber,
        // "codCourse": codCourse == null ? null : codCourse,
        // "codCourseName": codCourseName == null ? null : codCourseName,
        // "degreeType": degreeType == null ? null : degreeType,
        // "degreeTypeCode": degreeTypeCode == null ? null : degreeTypeCode,
        // "faculty": faculty == null ? null : faculty,
        // "enrollmentType": enrollmentType == null ? null : enrollmentType,
        // "year": year == null ? null : year,
        "earnedCreditsNumber": earnedCreditsNumber == null ? null : earnedCreditsNumber,
        "earnedCreditsNotes": earnedCreditsNotes == null ? null : earnedCreditsNotes,
    };
}
