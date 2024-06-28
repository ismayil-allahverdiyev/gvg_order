import 'dart:convert';

import 'package:flutter/material.dart';

ImageFileModel imageFileModelFromJson(String str) =>
    ImageFileModel.fromJson(json.decode(str));

String imageFileModelToJson(ImageFileModel data) => json.encode(data.toJson());

class ImageFileModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  ImageFile data;

  ImageFileModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory ImageFileModel.fromJson(Map<String, dynamic> json) => ImageFileModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: ImageFile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": data.toJson(),
      };
}

class ImageFile {
  String fileName;
  Image? image;

  ImageFile({
    required this.fileName,
    required this.image,
  });

  factory ImageFile.fromJson(Map<String, dynamic> json) => ImageFile(
        fileName: json["fileName"],
        image: json["content"] == "" || json["content"] == null
            ? null
            : Image.memory(base64Decode(json["content"])),
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "image": image?.toString(),
      };
}
