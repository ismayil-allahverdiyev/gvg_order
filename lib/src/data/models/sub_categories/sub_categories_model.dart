import 'dart:convert';

SubCategoriesModel subCategoriesModelFromJson(String str) =>
    SubCategoriesModel.fromJson(json.decode(str));

String subCategoriesModelToJson(SubCategoriesModel data) =>
    json.encode(data.toJson());

class SubCategoriesModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<SubCategory> data;

  SubCategoriesModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<SubCategory>.from(
            json["data"].map((x) => SubCategory.fromJson(x))),
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

class SubCategory {
  String? parentCategoryId;
  String viewTypeId;
  String name;
  String shortName;
  String description;
  int relatedProductCount;
  SubCategory? parentCategory;
  String id;
  String? userId;
  String? customerId;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;

  SubCategory({
    required this.parentCategoryId,
    required this.viewTypeId,
    required this.name,
    required this.shortName,
    required this.description,
    required this.relatedProductCount,
    required this.parentCategory,
    required this.id,
    required this.userId,
    required this.customerId,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        parentCategoryId: json["parentCategoryId"],
        viewTypeId: json["viewTypeId"],
        name: json["name"],
        shortName: json["shortName"],
        description: json["description"],
        relatedProductCount: json["relatedProductCount"],
        parentCategory: json["parentCategory"] == null
            ? null
            : SubCategory.fromJson(json["parentCategory"]),
        id: json["id"],
        userId: json["userId"],
        customerId: json["customerId"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "parentCategoryId": parentCategoryId,
        "viewTypeId": viewTypeId,
        "name": name,
        "shortName": shortName,
        "description": description,
        "relatedProductCount": relatedProductCount,
        "parentCategory": parentCategory?.toJson(),
        "id": id,
        "userId": userId,
        "customerId": customerId,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
