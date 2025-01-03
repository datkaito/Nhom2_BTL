// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/home/widgets/carousel_slide.dart';
import 'package:doan_clean_achitec/modules/home/widgets/category_bar.dart';
import 'package:doan_clean_achitec/modules/home/widgets/home_header.dart';
import 'package:doan_clean_achitec/modules/home/widgets/special_popular.dart';
import 'package:doan_clean_achitec/modules/home/widgets/special_sale.dart';
import 'package:doan_clean_achitec/modules/home/widgets/title_des.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/widgets/item_service_widget.dart';
import '../../shared/widgets/stateful/DestinationItem.dart';
import 'widgets/special_close_here.dart';
import 'widgets/special_new.dart';
import 'widgets/special_offer.dart';

class HomeTab extends GetView<HomeController> {
  HomeTab({super.key});

  final SearchDesController searchDesController =
      Get.put(SearchDesController());
  final TourController tourController = Get.put(TourController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          controller.getAllCityModelData();
          tourController.getAllTourModelData();
        },
        child: Scaffold(
          backgroundColor: ColorConstants.lightBackground,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: controller.categoryIndex.value == 0
                  ? AllWidget(
                      size: size,
                      controller: controller,
                      searchDesController: searchDesController)
                  : controller.categoryIndex.value == 1
                      ? PopularWidget(
                          size: size,
                          controller: controller,
                          searchDesController: searchDesController)
                      : controller.categoryIndex.value == 2
                          ? NewWidget(
                              size: size,
                              controller: controller,
                              searchDesController: searchDesController)
                          : controller.categoryIndex.value == 3
                              ? SaleWidget(
                                  size: size,
                                  controller: controller,
                                  searchDesController: searchDesController)
                              : CloseHereWidget(
                                  size: size,
                                  controller: controller,
                                  searchDesController: searchDesController),
            ),
          ),
        ),
      ),
    );
  }
}

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    super.key,
    required this.size,
    required this.controller,
    required this.searchDesController,
  });

  final Size size;
  final HomeController controller;
  final SearchDesController searchDesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          size: size,
          avatar: true,
        ),
        CategoryBar(),
        SizedBox(
          height: getSize(8),
        ),
        TitleDes(
          largeTitle: StringConst.popularDestination.tr,
          seeAll: "",
        ),
        SizedBox(
          height: getSize(460),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCitys.value.isNotEmpty
                ? controller.listCitys.value.length
                : 0,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0
                  ? randomItemHeight = getSize(220)
                  : randomItemHeight = getSize(192);
              return InkWell(
                onTap: () async {
                  await searchDesController.setHistoryCurrentDestination(
                    controller.listCitys.value[index],
                  );
                  await searchDesController.getHistoryCurrentDestination();
                  Get.toNamed(
                    Routes.DETAIL_PLACE,
                    arguments: controller.listCitys.value[index],
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  child: DestinationItem(
                    heightSize: randomItemHeight,
                    cityModel: controller.listCitys.value[index],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: getSize(32),
        ),
        SpecialPopular(),
      ],
    );
  }
}

class AllWidget extends StatelessWidget {
  const AllWidget({
    super.key,
    required this.size,
    required this.controller,
    required this.searchDesController,
  });

  final Size size;
  final HomeController controller;
  final SearchDesController searchDesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          size: size,
          avatar: true,
        ),
        CategoryBar(),
        CarouselSliderDes(),
        SizedBox(
          height: getSize(16),
        ),
        const ItemServiceWidget(),
        SizedBox(
          height: getSize(32),
        ),
        SpecialOffers(),
        SizedBox(
          height: getSize(32),
        ),
        TitleDes(
          largeTitle: StringConst.popularDestination.tr,
          seeAll: StringConst.seeAll.tr,
          onTap: () {},
        ),
        SizedBox(
          height: getSize(8),
        ),
        SizedBox(
          height: getSize(460),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCitys.value.isNotEmpty
                ? controller.listCitys.value.length
                : 0,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0
                  ? randomItemHeight = getSize(220)
                  : randomItemHeight = getSize(192);
              return InkWell(
                onTap: () async {
                  await searchDesController.setHistoryCurrentDestination(
                    controller.listCitys.value[index],
                  );
                  await searchDesController.getHistoryCurrentDestination();
                  Get.toNamed(
                    Routes.DETAIL_PLACE,
                    arguments: controller.listCitys.value[index],
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  child: DestinationItem(
                    heightSize: randomItemHeight,
                    cityModel: controller.listCitys.value[index],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: getSize(32),
        ),
        SpecialSale(),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.size,
    required this.controller,
    required this.searchDesController,
  });

  final Size size;
  final HomeController controller;
  final SearchDesController searchDesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          size: size,
          avatar: true,
        ),
        CategoryBar(),
        SpecialNew(),
        SizedBox(
          height: getSize(36),
        ),
        TitleDes(
          largeTitle: StringConst.popularDestination.tr,
          seeAll: "",
        ),
        SizedBox(
          height: getSize(460),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCitys.value.isNotEmpty
                ? controller.listCitys.value.length
                : 0,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0
                  ? randomItemHeight = getSize(220)
                  : randomItemHeight = getSize(192);
              return InkWell(
                onTap: () async {
                  await searchDesController.setHistoryCurrentDestination(
                    controller.listCitys.value[index],
                  );
                  await searchDesController.getHistoryCurrentDestination();
                  Get.toNamed(
                    Routes.DETAIL_PLACE,
                    arguments: controller.listCitys.value[index],
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  child: DestinationItem(
                    heightSize: randomItemHeight,
                    cityModel: controller.listCitys.value[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SaleWidget extends StatelessWidget {
  const SaleWidget({
    super.key,
    required this.size,
    required this.controller,
    required this.searchDesController,
  });

  final Size size;
  final HomeController controller;
  final SearchDesController searchDesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          size: size,
          avatar: true,
        ),
        CategoryBar(),
        SizedBox(
          height: getSize(8),
        ),
        SpecialSale(),
        SizedBox(
          height: getSize(32),
        ),
        TitleDes(
          largeTitle: StringConst.popularDestination.tr,
          seeAll: "",
        ),
        SizedBox(
          height: getSize(460),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCitys.value.isNotEmpty
                ? controller.listCitys.value.length
                : 0,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0
                  ? randomItemHeight = getSize(220)
                  : randomItemHeight = getSize(192);
              return InkWell(
                onTap: () async {
                  await searchDesController.setHistoryCurrentDestination(
                    controller.listCitys.value[index],
                  );
                  await searchDesController.getHistoryCurrentDestination();
                  Get.toNamed(
                    Routes.DETAIL_PLACE,
                    arguments: controller.listCitys.value[index],
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  child: DestinationItem(
                    heightSize: randomItemHeight,
                    cityModel: controller.listCitys.value[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CloseHereWidget extends StatelessWidget {
  const CloseHereWidget({
    super.key,
    required this.size,
    required this.controller,
    required this.searchDesController,
  });

  final Size size;
  final HomeController controller;
  final SearchDesController searchDesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          size: size,
          avatar: true,
        ),
        CategoryBar(),
        SpecialCloseHere(),
        SizedBox(
          height: getSize(32),
        ),
        TitleDes(
          largeTitle: StringConst.popularDestination.tr,
          seeAll: "",
        ),
        SizedBox(
          height: getSize(8),
        ),
        SizedBox(
          height: getSize(460),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCitys.value.isNotEmpty
                ? controller.listCitys.value.length
                : 0,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0
                  ? randomItemHeight = getSize(220)
                  : randomItemHeight = getSize(192);
              return InkWell(
                onTap: () async {
                  await searchDesController.setHistoryCurrentDestination(
                    controller.listCitys.value[index],
                  );
                  await searchDesController.getHistoryCurrentDestination();
                  Get.toNamed(
                    Routes.DETAIL_PLACE,
                    arguments: controller.listCitys.value[index],
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  child: DestinationItem(
                    heightSize: randomItemHeight,
                    cityModel: controller.listCitys.value[index],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: getSize(32),
        ),
        SpecialSale(),
      ],
    );
  }
}
