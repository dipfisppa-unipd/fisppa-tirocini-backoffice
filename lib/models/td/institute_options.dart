// To parse this JSON data, do
//
//     final instituteOptions = instituteOptionsFromMap(jsonString);


import 'dart:convert';

class InstituteOptions {
    InstituteOptions({
        required this.schoolType,
        required this.geographicAreas,
        required this.countries,
        required this.regions,
        required this.provinces,
        required this.educationDegree,
    });

    final List<String> schoolType;
    final List<Country> countries;
    final List<GeoArea> geographicAreas;
    final List<Region> regions;
    final List<Province> provinces;
    final List<String> educationDegree;

    factory InstituteOptions.fromJson(String str) => InstituteOptions.fromMap(json.decode(str));

    factory InstituteOptions.fromMap(Map<String, dynamic> json) => InstituteOptions(
        schoolType: json["schoolType"] == null ? [] : List<String>.from(json["schoolType"].map((x) => x)),
        geographicAreas: json["geographicAreas"] == null ? [] : List<GeoArea>.from(json["geographicAreas"].map((x) =>GeoArea.fromMap(x))),
        regions: json["regions"] == null ? [] : List<Region>.from(json["regions"].map((x) => Region.fromMap(x))),
        educationDegree: json["educationDegree"] == null ? [] : List<String>.from(json["educationDegree"].map((x) => x)),
        countries: json["countries"] == null ? [] : List<Country>.from(json["countries"].map((x) => Country.fromMap(x))),
        provinces: json["provinces"] == null ? [] : List<Province>.from(json["provinces"].map((x) => Province.fromMap(x))),
    );

}


class Country {
    Country({
        required this.id,
        required this.name,

    });

    final String id;
    final String name;


    factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Country.fromMap(Map<String, dynamic> json) => Country(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],

    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        
    };
}


class Province {
    Province({
        required this.id,
        required this.name,
        required this.regionId,
    });

    final String id;
    final String name;
    final String regionId;

    factory Province.fromJson(String str) => Province.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Province.fromMap(Map<String, dynamic> json) => Province(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        regionId: json["region_id"] == null ? null : json["region_id"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "region_id": regionId,
    };
}

class GeoArea {
    GeoArea({
        required this.id,
        required this.name,
        required this.countryId,
    });

    final String id;
    final String name;
    final String countryId;

    factory GeoArea.fromJson(String str) => GeoArea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GeoArea.fromMap(Map<String, dynamic> json) => GeoArea(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        countryId: json["country_id"] == null ? null : json["country_id"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "country_id": countryId,
    };
}


class Region {
    Region({
        required this.id,
        required this.countryId,
        required this.geographicAreaId,
        required this.name,
    });

    final String id;
    final String countryId;
    final String geographicAreaId;
    final String name;

    factory Region.fromJson(String str) => Region.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Region.fromMap(Map<String, dynamic> json) => Region(
        id: json["_id"] == null ? null : json["_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        geographicAreaId: json["geographicArea_id"] == null ? null : json["geographicArea_id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "country_id": countryId,
        "geographicArea_id": geographicAreaId,
        "name": name,
    };
}

