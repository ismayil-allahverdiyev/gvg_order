import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/home/home_controller.dart';
import 'package:gvg_order/src/data/models/campaign/campaign_detail.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import 'package:gvg_order/src/data/models/product/product_detail_model.dart';
import '../../constants/endpoints.dart';
import '../../data/repository/repository.dart';
import '../basket/basket_controller.dart';

class ProductController extends GetxController {
  final Repository repository;
  ProductController({required this.repository});

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
    if (selectedCount.value < availableProductCount) {
      selectedCount.value++;

      basketController!.editBasketList(
        orderList: OrderList(
          discountedListPrice: 0,
          listPrice: 0,
          productId: productDetail.value!.id,
          productName: productDetail.value!.productName,
          productListId: productDetail.value!.productListId,
          stockQuantity: productDetail.value!.stockQuantity,
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
    } else {
      repository.showMessage(
        title: "Quota restriction",
        message: "There are no more products available in the stock!",
      );
    }
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
        stockQuantity: productDetail.value!.stockQuantity,
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
        stockQuantity: campaignDetail.value!.stock,
      );
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
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
          "listId": "149e56b0-af99-4262-b4a8-78967c6b6bcc",
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
