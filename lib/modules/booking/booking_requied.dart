// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingRequiedScreen extends GetView<BookingRequestController> {
  BookingRequiedScreen({super.key});

  final TourModel? tourModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.setPrice(tourModel?.price ?? 0);
    return Scaffold(
      backgroundColor:  ColorConstants.lightStatusBar,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: getSize(60),
          bottom: getSize(40),
          right: getSize(36),
          left: getSize(36),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: getSize(48),
                bottom: getSize(80),
                right: getSize(24),
                left: getSize(24),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.lightCard,
                borderRadius: BorderRadius.circular(
                  getSize(8),
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    tourModel?.nameTour ?? '',
                    style: AppStyles.black000Size18Fw600FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    "${StringConst.startAt.tr} ${tourModel?.duration ?? 'Hotel'}",
                    style: AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${StringConst.price.tr}:',
                        style:  AppStyles.black000Size14Fw400FfMont,
                      ),
                      Text(
                        'VND ${tourModel?.price}',
                        style:  AppStyles.black000Size16Fw500FfMont,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(50),
                  ),
                  Text(
                    StringConst.serviceExcluded.tr,
                    style:  AppStyles.black000Size18Fw500FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  tourModel!.excludedServices!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tourModel!.excludedServices!
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(bottom: getSize(16)),
                                  child: Text(
                                    e,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          StringConst.noData.tr,
                          style: AppStyles.black000Size14Fw400FfMont,
                        ),
                  SizedBox(height: getSize(32)),
                  Text(
                    StringConst.choosePeople.tr,
                    style: AppStyles.black000Size18Fw500FfMont,
                  ),
                  SizedBox(height: getSize(24)),
                  Padding(
                    padding: EdgeInsets.only(bottom: getSize(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConst.adult.tr,
                                  style:  AppStyles.black000Size14Fw500FfMont,
                                ),
                                SizedBox(height: getSize(4)),
                                Text(
                                  StringConst.from141cmtall.tr,
                                  style: AppStyles.black000Size12Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                SizedBox(height: getSize(4)),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'VND ',
                                        style: AppStyles
                                                .black000Size12Fw400FfMont,
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.adultPrice.toInt()}',
                                        style: AppStyles
                                                .blue000Size14Fw500FfMont,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.adultNumb.value =
                                          controller.setMinus(
                                        controller.adultNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icMinus,
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  SizedBox(
                                    width: getSize(32),
                                    child: Text(
                                      "${controller.adultNumb.toInt()}",
                                      textAlign: TextAlign.center,
                                      style:  AppStyles.black000Size16Fw400FfMont,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  GestureDetector(
                                    onTap: () {
                                      controller.adultNumb.value =
                                          controller.setPlus(
                                        controller.adultNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icPlus,
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getSize(16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConst.children.tr,
                                  style: AppStyles.black000Size14Fw500FfMont,
                                ),
                                SizedBox(height: getSize(4)),
                                Text(
                                  StringConst.to140cmtallorless.tr,
                                  style:  AppStyles.black000Size12Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                SizedBox(height: getSize(4)),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'VND ',
                                        style: AppStyles
                                                .black000Size12Fw400FfMont,
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.childrenPrice.toInt()}',
                                        style:  AppStyles
                                                .blue000Size14Fw500FfMont,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.childrenNumb.value =
                                          controller.setMinus(
                                        controller.childrenNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icMinus,
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  SizedBox(
                                    width: getSize(32),
                                    child: Text(
                                      "${controller.childrenNumb.toInt()}",
                                      textAlign: TextAlign.center,
                                      style:AppStyles.black000Size16Fw400FfMont,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  GestureDetector(
                                    onTap: () {
                                      controller.childrenNumb.value =
                                          controller.setPlus(
                                        controller.childrenNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icPlus,
                                      colorFilter: ColorFilter.mode(
                                        ColorConstants.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    AssetHelper.icCloseSquare,
                    colorFilter: ColorFilter.mode(
                       ColorConstants.grey800!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: getSize(16),
              left: getSize(24),
              right: getSize(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${controller.totalPrice.toInt()} ',
                            style: AppStyles.blue000Size16Fw500FfMont,
                          ),
                          TextSpan(
                            text: 'VND ',
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonWidget(
                    textBtn: StringConst.continue_.tr,
                    onTap: () {
                      if (controller.adultNumb.value == 0 &&
                          controller.childrenNumb.value == 0) {
                        Get.snackbar(
                          StringConst.warning.tr,
                          StringConst.youneedtochoosethenumberofpeople.tr,
                        );
                      } else {
                        Get.toNamed(
                          Routes.BOOKING_OPTION_SCREEN,
                          arguments: {
                            'arg1': tourModel,
                            'arg2': controller.paymentMothod.value,
                          },
                        );
                      }
                    },
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
