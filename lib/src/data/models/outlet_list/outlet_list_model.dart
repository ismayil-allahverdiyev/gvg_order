// To parse this JSON data, do
//
//     final outletListModel = outletListModelFromJson(jsonString);

import 'dart:convert';

OutletListModel outletListModelFromJson(String str) =>
    OutletListModel.fromJson(json.decode(str));

String outletListModelToJson(OutletListModel data) =>
    json.encode(data.toJson());

class OutletListModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<OutLet> data;

  OutletListModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory OutletListModel.fromJson(Map<String, dynamic> json) {
    var res = json;
    return OutletListModel(
      code: json["code"],
      status: json["status"],
      statusText: json["statusText"],
      message: json["message"],
      rowCount: json["rowCount"],
      totalCount: json["totalCount"],
      data: List<OutLet>.from(json["data"].map((x) => OutLet.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OutLet {
  String id;
  Properties properties;

  OutLet({
    required this.id,
    required this.properties,
  });

  factory OutLet.fromJson(Map<String, dynamic> json) => OutLet(
        id: json["id"],
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "properties": properties.toJson(),
      };
}

class Properties {
  double coordinatEY;
  String uid;
  double coordinatEX;
  String sigNName;
  String country;
  String city;
  String? legaLName;
  dynamic address;
  String? tradEChannel;
  dynamic subtradEChannel;
  String county;

  Properties({
    required this.coordinatEY,
    required this.uid,
    required this.coordinatEX,
    required this.sigNName,
    required this.country,
    required this.city,
    required this.legaLName,
    required this.address,
    required this.tradEChannel,
    required this.subtradEChannel,
    required this.county,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        coordinatEY: json["coordinatE_Y"]?.toDouble(),
        uid: json["uid"],
        coordinatEX: json["coordinatE_X"]?.toDouble(),
        sigNName: json["sigN_NAME"],
        country: json["country"],
        city: json["city"],
        legaLName: json["legaL_NAME"],
        address: json["address"],
        tradEChannel: json["tradE_CHANNEL"],
        subtradEChannel: json["subtradE_CHANNEL"],
        county: json["county"],
      );

  Map<String, dynamic> toJson() => {
        "coordinatE_Y": coordinatEY,
        "uid": uid,
        "coordinatE_X": coordinatEX,
        "sigN_NAME": sigNName,
        "country": country,
        "city": city,
        "legaL_NAME": legaLName,
        "address": address,
        "tradE_CHANNEL": tradEChannel,
        "subtradE_CHANNEL": subtradEChannel,
        "county": county,
      };
}
