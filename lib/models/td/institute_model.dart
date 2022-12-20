// To parse this JSON data, do
//
//     final instituteModel = instituteModelFromMap(jsonString);


import 'dart:convert';

import 'package:unipd_tirocini/models/patcher_model.dart';
import 'package:unipd_tirocini/models/td/direct_model.dart';

import '../../utils/utils.dart';

class InstitutesModel{
  InstitutesModel({
        this.institutes,
        this.total,
    });

    List<Institute>? institutes;
    int? total;

  factory InstitutesModel.fromJson(String str) => InstitutesModel.fromMap(json.decode(str));

  factory InstitutesModel.fromMap(Map<String, dynamic> json) => InstitutesModel(
      institutes: json["institutes"] == null ? [] : List<Institute>.from(json["institutes"].map((x) => Institute.fromMap(x))),
      total: json["total"] == null ? null : json["total"],
  );

}

class Institute {
    Institute({
        this.id,
        this.convention,
        this.schoolType='',
        this.academicYear='',
        this.geographicArea='',
        this.region='',
        this.province='',
        this.code='',
        this.name='',
        this.address='',
        this.cap='',
        this.cityCode='',
        this.city='',
        this.educationDegree='',
        this.email='',
        this.pec='',
        this.website='',
        this.referenceInstituteCode='',
        this.referenceInstituteName='',
        this.additionalCharacteristics='',
        this.isHeadOffice=false,
        this.allEncompassingCode='',
        this.directInternships = const [],
        this.directInternshipsCount = 0,
        this.state='ITALIA',
        this.fax='',
        this.phoneNumber='',
        this.vatNumber='',
        this.iban='',
    });

    String? id;
    Convention? convention;
    String schoolType;
    String academicYear;
    String geographicArea;
    String region;
    String province;
    String code;
    String name;
    String address;
    String cap;
    String cityCode;
    String city;
    String educationDegree;
    String? email;
    String? pec;
    String website;
    String referenceInstituteCode;
    String referenceInstituteName;
    String additionalCharacteristics;
    bool isHeadOffice=false;
    String allEncompassingCode;
    List<DirectInternship> directInternships = [];
    int directInternshipsCount = 0;
    String phoneNumber, fax, state, vatNumber, iban;

    Patcher patcher = Patcher();

    String conventionEnds(){
      if(convention!=null && convention!.endDate!=null)
      return Utils.formatDatePdf(convention!.endDate!);
      return '-';
    }

    String conventionStarts(){
      if(convention!=null && convention!.startDate!=null)
      return Utils.formatDatePdf(convention!.startDate!);
      return '-';
    }

    String schoolDegree() {
      if(educationDegree=='ISTITUTO COMPRENSIVO'){
        return 'Istituto Comprensivo';
      }else if(educationDegree=='SCUOLA PRIMARIA' || educationDegree=='SCUOLA PRIMARIA NON STATALE'){
        return 'Primaria';
      }else if(educationDegree=='SCUOLA INFANZIA' || educationDegree=='SCUOLA INFANZIA NON STATALE'){
        return 'Infanzia';
      }
      return '';
    }

    String schoolIcon() {
      if(educationDegree=='ISTITUTO COMPRENSIVO'){
        return 'assets/svg/c.svg';
      }else if(educationDegree=='SCUOLA PRIMARIA' || educationDegree=='SCUOLA PRIMARIA NON STATALE'){
        return 'assets/svg/p.svg';
      }else if(educationDegree=='SCUOLA INFANZIA' || educationDegree=='SCUOLA INFANZIA NON STATALE'){
        return 'assets/svg/i.svg';
      }
      return '';
    }

    factory Institute.fromJson(String str) => Institute.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Institute.fromMap(Map<String, dynamic> json) => Institute(
        id: json["_id"] == null ? null : json["_id"],
        convention: json["convention"] == null ? null :  Convention.fromMap(json["convention"]),
        schoolType: json["schoolType"] == null ? '' : json["schoolType"],
        academicYear: json["academicYear"] == null ? '' : json["academicYear"],
        geographicArea: json["geographicArea"] == null ? '' : json["geographicArea"],
        region: json["region"] == null ? '' : json["region"],
        province: json["province"] == null ? '' : json["province"],
        code: json["code"] == null ? '' : json["code"],
        name: json["name"] == null ? '' : json["name"],
        address: json["address"] == null ? '' : json["address"],
        cap: json["cap"] == null ? '' : json["cap"],
        cityCode: json["cityCode"] == null ? '' : json["cityCode"],
        city: json["city"] == null ? '' : json["city"],
        educationDegree: json["educationDegree"] == null ? '' : json["educationDegree"],
        email: json["email"] == null ? '' : json["email"],
        pec: json["pec"] == null ? '' : json["pec"],
        website: json["website"] == null ? '' : json["website"],
        referenceInstituteCode: json["referenceInstituteCode"] == null ? '' : json["referenceInstituteCode"],
        referenceInstituteName: json["referenceInstituteName"] == null ? '' : json["referenceInstituteName"],
        additionalCharacteristics: json["additionalCharacteristics"] == null ? '' : json["additionalCharacteristics"],
        isHeadOffice: json["isHeadOffice"] == null ? false : json["isHeadOffice"],
        allEncompassingCode: json["allEncompassingCode"] == null ? '' : json["allEncompassingCode"],
        directInternships: json["directInternships"] == null ? [] : List<DirectInternship>.from(json["directInternships"].map((x) => DirectInternship.fromMap(x))),
        state: json["state"] == null ? '' : json["state"],
        iban: json["iban"] == null ? '' : json["iban"],
        vatNumber: json["vatNumber"] == null ? '' : json["vatNumber"],
        phoneNumber: json["phoneNumber"] == null ? '' : json["phoneNumber"],
        fax: json["fax"] == null ? '' : json["fax"],
        directInternshipsCount: json["directInternshipsCount"] == null ? 0 : json["directInternshipsCount"],
    );

    Map<String, dynamic> toMap() => {

        "schoolType": schoolType,
        // "academicYear": "202223",
        "geographicArea": geographicArea,
        "region": region,
        "province": province,
        "code": code,
        "name": name,
        "address": address,
        "cap": cap,
        "cityCode": "x",
        "city": city,
        "educationDegree": educationDegree,
        "email": email,
        "pec": pec,
        "website": website,
        "referenceInstituteCode": referenceInstituteCode,
        // "referenceInstituteName": referenceInstituteName,
        "isHeadOffice": isHeadOffice,
        "iban": iban,
        "vatNumber": vatNumber,
        "phoneNumber": phoneNumber,
        "fax": fax,
        "state": state,
        "convention": convention?.toMap(),
    };
}


class Convention {
    Convention({
        required this.startDate,
        required this.endDate,
    });

    final DateTime? startDate;
    final DateTime? endDate;

    factory Convention.fromJson(String str) => Convention.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Convention.fromMap(Map<String, dynamic> json) => Convention(
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    );

    Map<String, dynamic> toMap() => {
        "startDate": startDate == null ? null : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate": endDate == null ? null : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    };
}
