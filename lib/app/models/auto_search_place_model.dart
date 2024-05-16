import 'dart:convert';

AutoSearchPlaceModel autoSearchPlaceModelFromJson(String str) =>
    AutoSearchPlaceModel.fromJson(json.decode(str));

String autoSearchPlaceModelToJson(AutoSearchPlaceModel data) =>
    json.encode(data.toJson());

class AutoSearchPlaceModel {
  List<Feature>? features;

  AutoSearchPlaceModel({
    this.features,
  });

  factory AutoSearchPlaceModel.fromJson(Map<String, dynamic> json) =>
      AutoSearchPlaceModel(
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class Feature {
  Geometry? geometry;
  String? type;
  Properties? properties;

  Feature({
    this.geometry,
    this.type,
    this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        type: json["type"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "type": type,
        "properties": properties?.toJson(),
      };
}

class Geometry {
  List<double>? coordinates;
  String? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class Properties {
  String? osmType;
  int? osmId;
  List<double>? extent;
  String? country;
  String? osmKey;
  String? city;
  String? countrycode;
  String? street;
  String? osmValue;
  String? name;
  String? state;
  String? type;

  Properties({
    this.osmType,
    this.osmId,
    this.extent,
    this.country,
    this.osmKey,
    this.city,
    this.countrycode,
    this.street,
    this.osmValue,
    this.name,
    this.state,
    this.type,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        extent: json["extent"] == null
            ? []
            : List<double>.from(json["extent"]!.map((x) => x?.toDouble())),
        country: json["country"],
        osmKey: json["osm_key"],
        city: json["city"],
        countrycode: json["countrycode"],
        street: json["street"],
        osmValue: json["osm_value"],
        name: json["name"],
        state: json["state"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "osm_type": osmType,
        "osm_id": osmId,
        "extent":
            extent == null ? [] : List<dynamic>.from(extent!.map((x) => x)),
        "country": country,
        "osm_key": osmKey,
        "city": city,
        "countrycode": countrycode,
        "street": street,
        "osm_value": osmValue,
        "name": name,
        "state": state,
        "type": type,
      };
}
