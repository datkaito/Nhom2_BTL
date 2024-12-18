import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/user_profile_setting_groups.dart';
import '../../shared/widgets/user_profile_setting_item.dart';
import '../auth/user_controller.dart';
import '../home/widgets/home_header.dart';
import '../profile/profile_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.lightBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                size: size,
              ),
              SizedBox(
                height: getSize(32),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.PROFILE),
                child: ProfileWidget(
                  userController: userController,
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              BuildSettingsGroup(
                settingsGroupTitle: StringConst.appSetting.tr,
                items: [
                  BuildSettingsItem(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    imageAsset: AssetHelper.icProfile,
                    widgetTitle: Text(
                      StringConst.personalInformation.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BuildSettingsItem(
                    onTap: () {},
                    imageAsset: AssetHelper.icNotification,
                    widgetTitle: Text(
                      StringConst.notificationAndChat.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BuildSettingsItem(
                    onTap: () => openAppSettings(),
                    imageAsset: AssetHelper.icShieldDone,
                    widgetTitle: Text(
                      StringConst.privateAndPermissions.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BuildSettingsItem(
                    onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD_SCREEN),
                    imageAsset: AssetHelper.icLock,
                    widgetTitle: Text(
                      StringConst.passwordAndAccount.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () {},
                title: GestureDetector(
                  onTap: () => profileController.signUserOut(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringConst.logout.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppStyles.black000Size16Fw500FfMont,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Image.asset(
                        AssetHelper.icoLogout,
                        color: ColorConstants.graySub,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final ProfileController controller = Get.find();
