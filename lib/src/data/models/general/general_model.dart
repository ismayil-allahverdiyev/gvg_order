import 'dart:convert';

import 'package:flutter/material.dart';

ImageFileModel generalModelFromJson(String str) =>
    ImageFileModel.fromJson(json.decode(str));

String generalModelToJson(ImageFileModel data) => json.encode(data.toJson());

class ImageFileModel {
  int code;
  bool status;
  String statusText;
  String? message;
  dynamic data;

  ImageFileModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.data,
  });

  factory ImageFileModel.fromJson(Map<String, dynamic> json) => ImageFileModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "data": data.toString(),
      };
}
