// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../auth/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

final UserController userController = Get.find();
final ProfileController profileController = Get.find();

final HomeController homeController = Get.find();

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    profileController.getEditProfile();
  }

  @override
  void deactivate() {
    super.deactivate();
    profileController.imageFonts.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBackground,
      appBar: CustomAppBar(
        titles: StringConst.changeProfile.tr,
        backgroundColor: ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: Obx(
        () => SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(24),
                    ),
                    Stack(
                      children: [
                        profileController.imageFonts.value.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  File? imageFile = await profileController
                                      .imageFonts.value[0].file;
                                  String path = imageFile?.path ?? '';
                                  profileController.showFullImageDialog(
                                      context, path);
                                },
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundColor: ColorConstants.white,
                                  backgroundImage: AssetEntityImageProvider(
                                    profileController.imageFonts.value[0],
                                  ),
                                ),
                              )
                            : homeController.userModel.value != null &&
                                    homeController.userModel.value?.imgAvatar !=
                                        null &&
                                    homeController.userModel.value?.imgAvatar !=
                                        ""
                                ? GestureDetector(
                                    onTap: () async {
                                      profileController.showFullImageDialog(
                                          context,
                                          homeController
                                                  .userModel.value?.imgAvatar ??
                                              "");
                                    },
                                    child: CircleAvatar(
                                      radius: 64,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        homeController
                                                .userModel.value?.imgAvatar ??
                                            "",
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundColor: ColorConstants.white,
                                    child: Container(
                                      width: getSize(96),
                                      height: getSize(96),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                            ColorConstants.accent1,
                                            BlendMode.srcIn,
                                          ),
                                          image: const AssetImage(
                                            AssetHelper.imgUserProfileNon,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: ColorConstants.white,
                            child: IconButton(
                              onPressed: () {
                                profileController.pickImages(context);
                              },
                              icon: const Icon(Icons.add_a_photo),
                              color: ColorConstants.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(32),
                    ),
                    Text(
                      userController.userName.value,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.email.tr,
                      style: TextStyle(
                        color: ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    MyTextField(
                      controller: profileController.editEmailController,
                      hintText: '',
                      obscureText: false,
                      isCheckReadOnly: true,
                    ),
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.firstName.tr,
                      style: TextStyle(
                        color: ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    MyTextField(
                      controller: profileController.editFirstNameController,
                      hintText: StringConst.enterYourFirstname.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.lastName.tr,
                      style: TextStyle(
                        color: ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    MyTextField(
                      controller: profileController.editLastNameController,
                      hintText: StringConst.enterYourLastName.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.phoneNumber.tr,
                      style: TextStyle(
                        color: ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    MyTextField(
                      controller: profileController.editPhoneNumberController,
                      hintText: StringConst.enterYourPhoneNumber.tr,
                      obscureText: false,
                      isTypeNumb: true,
                      validatorCheck: (value) {
                        if (!Regex.isPasswordNumber(value!.trim())) {
                          return 'password must contain at least one number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.location.tr,
                      style: TextStyle(
                        color: ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    MyTextField(
                      controller: profileController.editLocationController,
                      hintText: StringConst.enterYourLocation.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(48),
                    ),
                    Center(
                      child: MyButton(
                        onTap: () async {
                          if (profileController.imageFonts.value.isNotEmpty) {
                            profileController.imageUrl.value =
                                await profileController.uploadImageToStorage(
                              'profileImage',
                              await profileController.assetEntityToUint8List(
                                profileController.imageFonts.value[0],
                              ),
                            );
                            profileController.urlImageOld.value =
                                homeController.userModel.value?.imgAvatar ?? '';

                            profileController.getDeleteImage(
                                profileController.urlImageOld.value);
                          } else if (homeController.userModel.value != null &&
                              homeController.userModel.value?.imgAvatar != "" &&
                              homeController.userModel.value?.imgAvatar !=
                                  null) {
                            profileController.imageUrl.value =
                                homeController.userModel.value?.imgAvatar ?? '';
                          }

                          final userModel = UserModel(
                            id: homeController.userModel.value?.id ?? '',
                            email: homeController.userModel.value?.email ?? '',
                            firstName: profileController
                                .editFirstNameController.text
                                .trim(),
                            lastName: profileController
                                .editLastNameController.text
                                .trim(),
                            passWord:
                                homeController.userModel.value?.passWord ?? '',
                            imgAvatar: profileController.imageUrl.value,
                            phoneNub: profileController
                                .editPhoneNumberController.text
                                .trim(),
                            location: profileController
                                .editLocationController.text
                                .trim(),
                            isActive: true,
                          );
                          await profileController.updateUserProfile(userModel);
                        },
                        textBtn: StringConst.save.tr,
                        colorBgr: ColorConstants.primaryButton,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
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
}
