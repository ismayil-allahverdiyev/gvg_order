import 'dart:convert';

CampaignDetailModel campaignDetailModelFromJson(String str) =>
    CampaignDetailModel.fromJson(json.decode(str));

String campaignDetailModelToJson(CampaignDetailModel data) =>
    json.encode(data.toJson());

class CampaignDetailModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  CampaignDetail data;

  CampaignDetailModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) =>
      CampaignDetailModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: CampaignDetail.fromJson(json["data"]),
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

class CampaignDetail {
  List<Product> products;
  String campaignId;
  String typeId;
  String productListId;
  String name;
  int stock;
  DateTime beginDate;
  DateTime endDate;
  String message;
  int discountedPrice;
  dynamic logo;
  List<dynamic> fileWithModels;
  String deletedFileName;
  String userId;
  String customerId;

  CampaignDetail({
    required this.products,
    required this.campaignId,
    required this.typeId,
    required this.productListId,
    required this.name,
    required this.stock,
    required this.beginDate,
    required this.endDate,
    required this.message,
    required this.discountedPrice,
    required this.logo,
    required this.fileWithModels,
    required this.deletedFileName,
    required this.userId,
    required this.customerId,
  });

  factory CampaignDetail.fromJson(Map<String, dynamic> json) {
    var res = json;
    return CampaignDetail(
      products:
          List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      campaignId: json["campaignId"],
      typeId: json["typeId"],
      productListId: json["productListId"],
      name: json["name"],
      stock: json["stock"],
      beginDate: DateTime.parse(json["beginDate"]),
      endDate: DateTime.parse(json["endDate"]),
      message: json["message"],
      discountedPrice: json["discountedPrice"],
      logo: json["logo"],
      fileWithModels: List<dynamic>.from(json["fileWithModels"].map((x) => x)),
      deletedFileName: json["deletedFileName"],
      userId: json["userId"],
      customerId: json["customerId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "campaignId": campaignId,
        "typeId": typeId,
        "productListId": productListId,
        "name": name,
        "stock": stock,
        "beginDate": beginDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "message": message,
        "discountedPrice": discountedPrice,
        "logo": logo,
        "fileWithModels": List<dynamic>.from(fileWithModels.map((x) => x)),
        "deletedFileName": deletedFileName,
        "userId": userId,
        "customerId": customerId,
      };
}

class Product {
  String productId;
  String productName;
  String stockKode;
  String parentCategoryName;
  String subCategoryName;
  String brandName;
  String productListProductId;
  List<dynamic> fileWithModel;
  List<ProductListInfo> productListInfo;
  String? customerId;
  String? userId;

  Product({
    required this.productId,
    required this.productName,
    required this.stockKode,
    required this.parentCategoryName,
    required this.subCategoryName,
    required this.brandName,
    required this.productListProductId,
    required this.fileWithModel,
    required this.productListInfo,
    required this.customerId,
    required this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var res = json;
    return Product(
      productId: json["productId"],
      productName: json["productName"],
      stockKode: json["stockKode"],
      parentCategoryName: json["parentCategoryName"],
      subCategoryName: json["subCategoryName"],
      brandName: json["brandName"],
      productListProductId: json["productListProductId"],
      fileWithModel: List<dynamic>.from(json["fileWithModel"].map((x) => x)),
      productListInfo: List<ProductListInfo>.from(
          json["productListInfo"].map((x) => ProductListInfo.fromJson(x))),
      customerId: json["customerId"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "stockKode": stockKode,
        "parentCategoryName": parentCategoryName,
        "subCategoryName": subCategoryName,
        "brandName": brandName,
        "productListProductId": productListProductId,
        "fileWithModel": List<dynamic>.from(fileWithModel.map((x) => x)),
        "productListInfo":
            List<dynamic>.from(productListInfo.map((x) => x.toJson())),
        "customerId": customerId,
        "userId": userId,
      };
}

class ProductListInfo {
  int listPrice;
  String productId;
  String productListId;
  String productListName;
  int quantity;
  int newListPrice;
  int campaignQuantity;
  dynamic piecesInBox;
  dynamic kdv;
  dynamic isActive;
  String? customerId;
  String? userId;

  ProductListInfo({
    required this.listPrice,
    required this.productId,
    required this.productListId,
    required this.productListName,
    required this.quantity,
    required this.newListPrice,
    required this.campaignQuantity,
    required this.piecesInBox,
    required this.kdv,
    required this.isActive,
    required this.customerId,
    required this.userId,
  });

  factory ProductListInfo.fromJson(Map<String, dynamic> json) {
    var res = json;
    return ProductListInfo(
      listPrice: json["listPrice"],
      productId: json["productId"],
      productListId: json["productListId"],
      productListName: json["productListName"],
      quantity: json["quantity"],
      newListPrice: json["newListPrice"] ?? json["listPrice"],
      campaignQuantity: json["campaignQuantity"],
      piecesInBox: json["piecesInBox"],
      kdv: json["kdv"],
      isActive: json["isActive"],
      customerId: json["customerId"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "listPrice": listPrice,
        "productId": productId,
        "productListId": productListId,
        "productListName": productListName,
        "quantity": quantity,
        "newListPrice": newListPrice,
        "campaignQuantity": campaignQuantity,
        "piecesInBox": piecesInBox,
        "kdv": kdv,
        "isActive": isActive,
        "customerId": customerId,
        "userId": userId,
      };
}
