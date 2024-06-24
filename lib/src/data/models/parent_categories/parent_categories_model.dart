import 'dart:convert';

ParentCategoriesModel parentCategoriesModelFromJson(String str) =>
    ParentCategoriesModel.fromJson(json.decode(str));

String parentCategoriesModelToJson(ParentCategoriesModel data) =>
    json.encode(data.toJson());

class ParentCategoriesModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<ParentCategory> data;

  ParentCategoriesModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory ParentCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ParentCategoriesModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<ParentCategory>.from(
            json["data"].map((x) => ParentCategory.fromJson(x))),
      );

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

class ParentCategory {
  String viewTypeId;
  String name;
  String shortName;
  String description;
  int relatedProductCount;
  String id;
  String? userId;
  String? customerId;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;

  ParentCategory({
    required this.viewTypeId,
    required this.name,
    required this.shortName,
    required this.description,
    required this.relatedProductCount,
    required this.id,
    required this.userId,
    required this.customerId,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) => ParentCategory(
        viewTypeId: json["viewTypeId"],
        name: json["name"],
        shortName: json["shortName"],
        description: json["description"],
        relatedProductCount: json["relatedProductCount"],
        id: json["id"],
        userId: json["userId"],
        customerId: json["customerId"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "viewTypeId": viewTypeId,
        "name": name,
        "shortName": shortName,
        "description": description,
        "relatedProductCount": relatedProductCount,
        "id": id,
        "userId": userId,
        "customerId": customerId,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}

class FileWithModel {
  String fileName;
  String fullFileName;
  String fileExtension;
  String fileUri;
  int fileSize;

  FileWithModel({
    required this.fileName,
    required this.fullFileName,
    required this.fileExtension,
    required this.fileUri,
    required this.fileSize,
  });

  factory FileWithModel.fromJson(Map<String, dynamic> json) => FileWithModel(
        fileName: json["fileName"],
        fullFileName: json["fullFileName"],
        fileExtension: json["fileExtension"],
        fileUri: json["fileUri"],
        fileSize: json["fileSize"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fullFileName": fullFileName,
        "fileExtension": fileExtension,
        "fileUri": fileUri,
        "fileSize": fileSize,
      };
}
