import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/auth/user_controller.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;

  final ProfileController profileController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(24)),
        ),
        padding: EdgeInsets.all(getSize(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeController.userModel.value != null &&
                    homeController.userModel.value?.imgAvatar != null &&
                    homeController.userModel.value?.imgAvatar != ""
                ? GestureDetector(
                    onTap: () async {
                      profileController.showFullImageDialog(
                        context,
                        homeController.userModel.value?.imgAvatar ?? "",
                      );
                    },
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: CachedNetworkImageProvider(
                        homeController.userModel.value?.imgAvatar ?? "",
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
            SizedBox(width: getSize(24)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userController.userName.value != ''
                        ? userController.userName.value
                        : "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    userController.userEmail.value != ''
                        ? userController.userEmail.value
                        : '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Divider(
                      color: ColorConstants.graySecond,
                      thickness: getSize(0.5),
                      endIndent: getSize(16),
                    ),
                  ),
                  Text(
                    homeController.userModel.value?.phoneNub == null ||
                            homeController.userModel.value?.phoneNub == ""
                        ? "-"
                        : "+84 ${homeController.userModel.value?.phoneNub}",
                    style: TextStyle(
                      color: ColorConstants.titleSub,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Divider(
                      color: ColorConstants.graySecond,
                      thickness: getSize(0.5),
                      endIndent: getSize(16),
                    ),
                  ),
                  Text(
                    homeController.userModel.value?.location == null ||
                            homeController.userModel.value?.location == ""
                        ? "-"
                        : '${homeController.userModel.value?.location}',
                    style: TextStyle(
                      color: ColorConstants.titleSub,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: getSize(4),
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
