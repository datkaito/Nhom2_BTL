import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/string_constants.dart';

class AuthService {
  final ProfileController profileController =
      Get.put<ProfileController>(ProfileController());

  final UserController userController = Get.put(UserController());

  final HomeController homeController = Get.put(HomeController());

  Future<User?> signInWithGoogle() async {
  try {
    // Đăng nhập Google
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      // Người dùng hủy bỏ đăng nhập
      return null;
    }

    // Lấy thông tin xác thực từ tài khoản Google
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Đăng nhập Firebase bằng thông tin Google
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = authResult.user;

    if (user != null) {
      // Kiểm tra nếu người dùng chưa tồn tại trong hệ thống của bạn
      final bool isExistingUser = await profileController.isCheckExist(
        user.email ?? '',
      );

      if (!isExistingUser) {
        // Nếu người dùng chưa tồn tại, tạo tài khoản mới
        final UserModel userModel = UserModel(
          email: user.email ?? "",
          passWord: "",
          phoneNub: "",
          isActive: true,
        );

        await profileController.createUser(userModel);
      }

      // Lấy chi tiết người dùng từ hệ thống
      await homeController.getUserDetails(user.email ?? "");

      // Lưu FCM Token cho thông báo đẩy
      final String fcmToken = LocalStorageHelper.getValue('fcmToken') ?? "";
      if (homeController.userModel.value?.id != null) {
        await profileController.createPushNotification(
          homeController.userModel.value!.id!,
          fcmToken,
        );
      }
    }

    return user;
  } catch (error) {
    // Thông báo lỗi nếu có vấn đề trong quá trình đăng nhập
    Get.snackbar(
      StringConst.errorSigningInWithGoogle.tr,
      'Error: $error',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return null;
  }
}

}
