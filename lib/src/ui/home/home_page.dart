import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/utils/device_utils.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import '../../controllers/home/home_controller.dart';
import '../../routes/app_routes.dart';
import '../shared/widgets/custom_app_bar_widget.dart';
import 'widgets/body_widget.dart';
import 'widgets/custom_search_widget.dart';
import 'widgets/general_categories_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: CustomAppBar(
          title: "Home Page",
          isBasketVisible: true,
          isBackButton: false,
          onPressed: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },
        ),
        drawer: Container(
          width: Get.width * 0.7,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                DrawerWidget(
                  title: "Previous orders",
                  onTap: () {
                    Get.toNamed(Routes.ORDERS);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DrawerWidget(
                  title: "Favourites",
                  onTap: () {
                    Get.toNamed(Routes.FAVOURITES);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DrawerWidget(
                  title: "Outlet",
                  onTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DrawerWidget(
                  title: "Logout",
                  onTap: () {
                    // controller.logout();
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              toolbarHeight: kToolbarHeight,
              leading: const SizedBox(),
              flexibleSpace: Obx(
                () {
                  return controller.tabController.value == null
                      ? const SizedBox()
                      : TabBar(
                          dividerColor: Colors.transparent,
                          labelColor: whiteColor,
                          unselectedLabelColor: whiteColor,
                          controller: controller.tabController.value!,
                          indicatorColor: Color.fromARGB(255, 206, 193, 233),
                          onTap: (value) async {
                            controller.selectedTab.value = value;
                            if (value == 0) {
                              await controller.getListOrders();
                            } else {
                              await controller.getCampaigns();
                            }
                          },
                          tabs: [
                            Tab(
                              text: "Products",
                            ),
                            Tab(
                              text: "Campaigns",
                            ),
                          ],
                        );
                },
              ),
            ),
            Obx(() {
              return controller.selectedTab.value == 0
                  ? CustomSearchWidget(
                      onSearch: (value) async {
                        if (value.isNotEmpty) {
                          controller.selectedParentCategory.value = null;
                          controller.selectedSubCategory.value = null;
                        } else {
                          controller.selectedParentCategory.value =
                              controller.parentCategories.first;
                          if (controller.subCategories.isNotEmpty) {
                            controller.selectedSubCategory.value =
                                controller.subCategories.first;
                          }
                        }
                        await controller.getListOrders();
                      },
                      controller: controller.searchTextEditingController,
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox(),
                    );
            }),
            const GeneralCategoriesWidget(),
            const BodyWidget(),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const DrawerWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: lightGreyColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: lightTextColor,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: lightTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
