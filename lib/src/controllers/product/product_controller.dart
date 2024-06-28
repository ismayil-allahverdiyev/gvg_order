import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/home/home_controller.dart';
import 'package:gvg_order/src/data/models/campaign/campaign_detail.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import 'package:gvg_order/src/data/models/product/product_detail_model.dart';
import '../../constants/endpoints.dart';
import '../../data/models/image_file/image_file_model.dart';
import '../../data/repository/repository.dart';
import '../basket/basket_controller.dart';

class ProductController extends GetxController {
  final Repository repository;
  ProductController({required this.repository});

  var listId = "";

  var productId = "";
  var selectedCount = 0.obs;
  var availableProductCount = 5;
  var isCampaign = false;

  var productDetail = Rxn<ProductData>();
  var campaignDetail = Rxn<CampaignDetail>();

  BasketController? basketController;
  HomeController? homeController;

  @override
  void onInit() async {
    super.onInit();

    productId = Get.arguments["productId"];
    selectedCount.value = Get.arguments["selectedCount"];
    availableProductCount = Get.arguments["availableProductCount"];
    isCampaign = Get.arguments["isCampaign"];
    listId = Get.arguments["listId"];

    basketController = Get.find<BasketController>();
    homeController = Get.find<HomeController>();

    selectedCount.value = basketController!.basketList
            .firstWhereOrNull(
              (element) => element.productId == productId,
            )
            ?.selectedCount ??
        0;

    await getDetail();
  }

  addToBasket() {
    selectedCount.value++;

    basketController!.editBasketList(
      orderList: OrderList(
        discountedListPrice: productDetail.value!.discountedListPrice,
        listPrice: productDetail.value!.listPrice,
        productId: productDetail.value!.id,
        productName: productDetail.value!.productName,
        productListId: productDetail.value!.productListId,
        selectedCount: selectedCount.value,
        id: productDetail.value!.id,
        piecesInBox: 0,
      ),
    );

    homeController!.orderList.forEach((element) {
      if (element.productId == productDetail.value!.id) {
        element.selectedCount = selectedCount.value;
      }
    });

    homeController!.update(["orderList"]);
  }

  removeFromBasket() {
    selectedCount.value--;

    basketController!.editBasketList(
      orderList: OrderList(
        discountedListPrice: productDetail.value!.discountedListPrice,
        listPrice: productDetail.value!.listPrice,
        productId: productDetail.value!.id,
        productName: productDetail.value!.productName,
        productListId: productDetail.value!.productListId,
        selectedCount: selectedCount.value,
        id: productDetail.value!.id,
        piecesInBox: 0,
      ),
    );

    homeController!.orderList.forEach((element) {
      if (element.productId == productDetail.value!.id) {
        element.selectedCount = selectedCount.value;
      }
    });
    homeController!.update(["orderList"]);
  }

  getDetail() async {
    if (isCampaign) {
      await getCampaign();
    } else {
      await getProductDetail();
    }

    await getFile(
      isCampaign: isCampaign,
      fileName: productDetail.value!.id,
    );
  }

  getCampaign() async {
    var response = campaignDetailModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.getCampaign,
        query: {
          "id": productId,
        },
      ),
    );

    if (response.code == 200) {
      campaignDetail.value = response.data;
      productDetail.value = ProductData(
        description1: campaignDetail.value!.message,
        brandName: "",
        description2: null,
        description3: null,
        description4: null,
        discountedListPrice: campaignDetail.value!.discountedPrice,
        listPrice: campaignDetail.value!.discountedPrice,
        id: campaignDetail.value!.campaignId,
        isFavorite: false,
        productName: campaignDetail.value!.name,
        productListId: campaignDetail.value!.productListId,
        products: campaignDetail.value!.products,
      );

      productDetail.value!.products?.forEach((element) async {
        element.imageFile = await getFile(
          isCampaign: true,
          fileName: element.productId,
        );
      });
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  getFile({required bool isCampaign, required fileName}) async {
    var res = imageFileModelFromJson(
      await repository.getData(
          endpoint: EndPoint.getFile,
          base: EndPoint.base_url_product,
          query: {
            "folder": isCampaign ? "campaign" : "product",
            "fileName": fileName,
          }),
    );

    if (res.code == 200) {
      productDetail.value!.imageFile = res.data;
      productDetail.refresh();
    } else {
      repository.showMessage(
        title: "Error",
        message: res.message,
      );
    }
  }

  getProductDetail() async {
    var response = productDetailModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_detail_order,
        query: {
          "id": productId,
          "listId": listId,
          "isCampaign": isCampaign,
        },
      ),
    );

    if (response.code == 200) {
      productDetail.value = response.data;
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }
}
