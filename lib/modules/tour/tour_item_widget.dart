import 'package:cached_network_image/cached_network_image.dart';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/tour/tour_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../search/search_controller.dart';

// ignore: must_be_immutable
class TourItemWidget extends StatelessWidget {
  TourModel listTour;
  Function()? onTap;
  TourItemWidget({
    required this.listTour,
    this.onTap,
    super.key,
  });

  TourController tourController = Get.find();
  final SearchDesController searchDesController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isFavor = false;
    return GestureDetector(
      onTap: onTap ??
          () async {
            if (listTour.active) {
              await searchDesController.setHistoryCurrentTour(listTour);
              await searchDesController.getHistoryCurrentTour();
              Get.toNamed(Routes.TOUR_DETAILS, arguments: listTour);
            } else {
              Get.snackbar(
                StringConst.notification.tr,
                "${StringConst.theTourIsOnHold.tr}!",
              );
            }
          },
      child: Container(
        width: MediaQuery.of(context).size.width - getSize(40),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(16)),
          border: Border.all(
            color: ColorConstants.dividerColor.withOpacity(.4),
            width: 2,
          ),
        ),
        margin: EdgeInsets.only(bottom: getSize(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(getSize(16)),
                        child: listTour.images != null && listTour.images != []
                            ? CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: listTour.images?.first ?? '',
                              )
                            : Image.asset(
                                AssetHelper.imgPrevHotel01,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: getSize(24),
                        height: getSize(24),
                        margin: EdgeInsets.all(getSize(4)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getSize(8)),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: LikeButton(
                          onTap: (isLiked) async {
                            // setState(() {
                            //   isFavor = !isFavor;
                            // });
                            return Future.value(!isLiked);
                          },
                          isLiked: isFavor,
                          size: 12,
                          circleColor: const CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              FontAwesomeIcons.solidHeart,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 14,
                            );
                          },
                        ),
                      ),
                    ),
                    listTour.active
                        ? const SizedBox.shrink()
                        : Positioned(
                            bottom: 4,
                            right: 0,
                            left: 0,
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
              ),
              SizedBox(
                width: getSize(16),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listTour.nameTour.isNotEmpty ? listTour.nameTour : '',
                      style: AppStyles.botTitle000Size20Fw600FfMont
                          .copyWith(color: ColorConstants.botTitle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: getSize(8.0),
                    ),
                    RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: SvgPicture.asset(AssetHelper.icoMaps),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                              width: 6,
                            ),
                          ),
                          TextSpan(
                            text: tourController
                                .getNameCityById(listTour.idCity ?? ''),
                            style: AppStyles.botTitle000Size14Fw400FfMont
                                .copyWith(color: ColorConstants.botTitle),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(4),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icoStarSvg,
                        ),
                        SizedBox(
                          width: getSize(8.0),
                        ),
                        Text(
                          listTour.rating != 0
                              ? listTour.rating.toString()
                              : "",
                          style: AppStyles.botTitle000Size14Fw400FfMont
                              .copyWith(color: ColorConstants.botTitle),
                        ),
                        SizedBox(
                          width: getSize(8.0),
                        ),
                        Text(
                          listTour.reviews != null
                              ? '${listTour.reviews} ${StringConst.reviews.tr}'
                              : '',
                          style: AppStyles.graySecondSize14Fw400FfMont
                              .copyWith(color: ColorConstants.graySecond),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(4),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: listTour.price != 0
                                ? 'VND${listTour.price}'
                                : "\$143",
                            style: TextStyle(
                              color: ColorConstants.botTitle,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "/${StringConst.night.tr}",
                            style: AppStyles.botTitle000Size14Fw400FfMont
                                .copyWith(color: ColorConstants.botTitle),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
