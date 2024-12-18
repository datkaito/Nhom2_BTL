import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/booking/booking_option/booking_option_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/button_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/app_style.dart';
import '../../../shared/utils/app_bar_widget.dart';
import '../../auth/user_controller.dart';
import '../booking_controller.dart';

class BookingOptionScreen extends GetView<BookingOptionController> {
  BookingOptionScreen({super.key});

  final TourModel? tourModel = Get.arguments['arg1'];

  final AuthController authController = Get.find();
  final HomeController homeController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());
  final BookingController bookingController = Get.put(BookingController());
  final BookingRequestController bookingRequestController =
      Get.put(BookingRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        titles: "Confirm Booking".tr,
        backgroundColor: ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.lightBackground,
      ),
      backgroundColor: ColorConstants.lightBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tourModel?.nameTour ?? '',
                              style: AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.startLocation.tr,
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              '${tourModel?.accommodation}',
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.startDateTour.tr,
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              controller.formatTimeStampToString(
                                  tourModel?.startDate ?? Timestamp.now()),
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.quantity.tr,
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              "${StringConst.adult.tr} x ${bookingRequestController.adultNumb.value?.toInt()}, ${StringConst.children.tr} x ${bookingRequestController.childrenNumb.value?.toInt()}",
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.informationCustomer.tr,
                              style: AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(24),
                            ),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    StringConst.firstName.tr,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller:
                                        controller.firstNameConfirmController,
                                    hintText: StringConst.enterYourFirstname.tr,
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.lastName.tr,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.lastNameController,
                                    hintText: StringConst.enterYourLastName.tr,
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.email.tr,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.emailController,
                                    hintText: StringConst.enterYourEmail.tr,
                                    obscureText: false,
                                    isCheckReadOnly: true,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.phoneNumber.tr,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller:
                                        controller.phoneNumberController,
                                    hintText:
                                        StringConst.enterYourPhoneNumber.tr,
                                    obscureText: false,
                                    isTypeNumb: true,
                                    validatorCheck: (value) {
                                      if (!Regex.isPasswordNumber(
                                          value!.trim())) {
                                        return 'password must contain at least one number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(96),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(getSize(16)),
                  color: ColorConstants.lightCard,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${bookingRequestController.totalPrice.toInt()} ',
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
                        textBtn: StringConst.payment.tr,
                        onTap: () {
                          Get.offAndToNamed(
                            Routes.PAY_STRIPE_SCREEN,
                            arguments: tourModel,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
