import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/bottomsheet_tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../shared/utils/convert_date_time.dart';
import '../../shared/widgets/bottomsheet_type_tour.dart';
import '../../shared/widgets/stateful/search_widget_tour.dart';
import 'search_tour_controller.dart';

class SearchTourScreen extends GetView<SearchTourController> {
  SearchTourScreen({super.key});

  final SearchDesController searchDesController = Get.find();
  final String? dataSearch = Get.arguments;
  final TourController tourcontroller = Get.put(TourController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      searchDesController.searchEditingController.text = dataSearch ?? "";
      searchDesController.searchTourEditingController.text = dataSearch ?? "";
      searchDesController.getTourSearch(dataSearch ?? "");
    });

    return RefreshIndicator(
      onRefresh: () async {
        searchDesController.getAllTourSearchData(dataSearch ?? "");
        tourcontroller.getAllTourModelData();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorConstants.lightBackground,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: getSize(16),
                    ),
                    SearchWidgetTour(
                      hintText: StringConst.searchDestinations.tr,
                      textEditingController:
                          searchDesController.searchTourEditingController,
                      focusNode: searchDesController.focusNodeSearchTour,
                      onChanged: (value) {
                        searchDesController.getTourSearch(value);
                        searchDesController.searchTourEditingController.text =
                            value;
                      },
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showDestination(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getSize(8),
                                  horizontal: getSize(12),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: ColorConstants.gray500,
                                    width: .5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      StringConst.destination.tr,
                                      style:
                                          AppStyles.black000Size13Fw400FfMont,
                                    ),
                                    SizedBox(
                                      width: getSize(4),
                                    ),
                                    SvgPicture.asset(
                                      AssetHelper.icArrowDown2,
                                      width: getSize(18),
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getSize(12),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showTypeTour(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getSize(8),
                                  horizontal: getSize(12),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: ColorConstants.gray500,
                                    width: .5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Type tour",
                                      style:
                                          AppStyles.black000Size13Fw400FfMont,
                                    ),
                                    SizedBox(
                                      width: getSize(4),
                                    ),
                                    SvgPicture.asset(
                                      AssetHelper.icArrowDown2,
                                      width: getSize(18),
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getSize(12),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result =
                                    await Get.toNamed(Routes.SELECT_DATE);
                                if (result is List<DateTime?>) {
                                  searchDesController.dateSelected.value =
                                      '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                                  searchDesController.getDateSearch(
                                    result[0] ?? DateTime.now(),
                                    result[1] ?? DateTime.now(),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getSize(8),
                                  horizontal: getSize(12),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: ColorConstants.gray500,
                                    width: .5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Date",
                                      style:
                                          AppStyles.black000Size13Fw400FfMont,
                                    ),
                                    SizedBox(
                                      width: getSize(4),
                                    ),
                                    SvgPicture.asset(
                                      AssetHelper.icArrowDown2,
                                      width: getSize(18),
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(20),
                    ),
                    Obx(
                      () => searchDesController
                              .getAllTourSearch.value!.isNotEmpty
                          ? SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchDesController
                                        .getAllTourSearch.value?.length ??
                                    2,
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: getSize(12),
                                    ),
                                    child: buildItemTourSearch(
                                      tourModel: searchDesController
                                          .getAllTourSearch.value?[rowIndex],
                                    ),
                                  );
                                },
                              ),
                            )
                          : const NoData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDestination(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheetTour(dataSheet: searchDesController.destination);
      },
    );
  }

  void _showTypeTour(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: BottomSheetTypeTour(
            dataSheet: searchDesController.destination,
          ),
        );
      },
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(64),
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AssetHelper.imgLottieNodate,
                width: getSize(200),
                height: getSize(200),
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class buildItemTourSearch extends GetView<SearchDesController> {
  TourModel? tourModel;

  buildItemTourSearch({
    super.key,
    required this.tourModel,
  });

  final SearchDesController searchDesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (tourModel!.active) {
          await searchDesController.setHistoryCurrentTour(tourModel!);
          await searchDesController.getHistoryCurrentTour();
          Get.toNamed(Routes.TOUR_DETAILS, arguments: tourModel);
        } else {
          Get.snackbar(
            StringConst.notification.tr,
            "${StringConst.theTourIsOnHold.tr}!",
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.lightCard,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(8)),
                  child: tourModel?.images != null && tourModel?.images != []
                      ? CachedNetworkImage(
                          height: getSize(200),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: tourModel?.images?.first ?? '',
                        )
                      : Image.asset(
                          height: getSize(200),
                          width: double.infinity,
                          AssetHelper.imgPrevHotel01,
                          fit: BoxFit.cover,
                        ),
                ),
                tourModel?.active ?? true
                    ? const SizedBox.shrink()
                    : Positioned(
                        bottom: 4,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(getSize(8)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(getSize(8)),
                            child: Text(
                              StringConst.stopped.tr,
                              style: AppStyles.blue000Size14Fw500FfMont,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
                vertical: getSize(16),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    tourModel?.nameTour ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: AppStyles.black000Size16Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icStar,
                        width: getSize(20),
                        colorFilter: ColorFilter.mode(
                          ColorConstants.yellow,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${tourModel?.rating.toString()} (${tourModel?.reviews ?? 0})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                          color: ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icCalendar,
                        width: getSize(20),
                        colorFilter: ColorFilter.mode(
                          ColorConstants.botTitle,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${controller.timestampToString(
                          tourModel?.startDate ?? Timestamp.now(),
                        )} - ${controller.timestampToString(
                          tourModel?.endDate ?? Timestamp.now(),
                        )}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                          color: ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icBuy,
                        width: getSize(20),
                        colorFilter: ColorFilter.mode(
                          ColorConstants.botTitle,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${tourModel?.price} VND',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyles.blue000Size14Fw400FfMont,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class buildItemHistory extends StatelessWidget {
  TourModel? tourModel;

  buildItemHistory({this.tourModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.grayTextField,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tourModel?.nameTour ?? '',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '',
                  style: AppStyles.black000Size14Fw400FfMont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '${tourModel?.price} VND',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.blue000Size14Fw400FfMont,
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(30),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(14)),
              child: Image.asset(
                AssetHelper.city_1,
                height: getSize(77),
                width: getSize(77),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
