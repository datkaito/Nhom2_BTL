// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:doan_clean_achitec/shared/utils/focus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/string_constants.dart';

class AuthController extends GetxController {
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final ProfileController _profileController =
      Get.put<ProfileController>(ProfileController());

  final UserController userController =
      Get.put<UserController>(UserController());

  final HomeController homeController =
      Get.put<HomeController>(HomeController());

  final _auth = FirebaseAuth.instance;
  late final Rx<User> firebaseUser;
  RxString veriticationId = ''.obs;
  int? resendToken;

  void signInPhoneAuthentication(
    String phoneNub,
    UserModel userModel,
    TourModel tourModel,
    String statusPayment,
  ) {
    phoneAuthentication(phoneNub, userModel, tourModel, statusPayment);
  }

  void clearControllLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
  }

  Future<void> phoneAuthentication(
    String phoneNub,
    UserModel userModel,
    TourModel tourModel,
    String statusPayment,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNub,
        verificationCompleted: (credential) async {},
        codeSent: (String verificationId, int? resendToken) async {
          veriticationId.value = verificationId;
          Get.toNamed(
            Routes.OTP_SCREEN,
            arguments: {
              'arg1': userModel,
              'arg2': tourModel,
              'arg3': statusPayment,
            },
          );
          this.resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (veriticationId) {
          this.veriticationId.value = veriticationId;
        },
        timeout: const Duration(seconds: 120),
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar(StringConst.error.tr, "The phone number invalid!");
          } else {
            Get.snackbar(StringConst.error.tr, "${e.code}. Try again!");
          }
        },
      );
    } catch (e) {
      resendVerificationCode(phoneNub, userModel, tourModel);
    }
  }

  Future<void> resendVerificationCode(
      String phoneNub, UserModel userModel, TourModel tourModel) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNub,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? resendToken) async {
        veriticationId.value = verificationId;
        Get.toNamed(
          Routes.OTP_SCREEN,
          arguments: {
            'arg1': userModel,
            'arg2': tourModel,
          },
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        veriticationId.value = verificationId;
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar(StringConst.error.tr, "The phone number is invalid!");
        } else {
          Get.snackbar(StringConst.error.tr, "${e.code}. Try again!");
        }
      },
      forceResendingToken: resendToken,
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: veriticationId.value,
          smsCode: otp,
        ),
      );
      // ignore: unnecessary_null_comparison
      return credentials != null;
    } catch (error) {
      return false;
    }
  }

  void register(BuildContext context) async {
  // Loại bỏ focus khỏi các TextField (nếu có)
  AppFocus.unFocus(context);

  // Hiển thị Dialog loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {
    // Lấy dữ liệu từ các controller
    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text.trim();
    final confirmPassword = registerConfirmPasswordController.text.trim();

    // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp không
    if (password != confirmPassword) {
      Get.back(); // Đóng Dialog
      wrongMessage(context, "Passwords don't match");
      return;
    }

    // Đăng ký người dùng
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.back(); // Đóng Dialog trước khi xử lý lỗi
      if (e.code == 'email-already-in-use') {
        wrongMessage(context, "Email đã tồn tại");
      } else {
        wrongMessage(context, "Đăng ký thất bại: ${e.code}");
      }
      return; // Kết thúc nếu có lỗi
    }

    // Lấy UID của người dùng mới
    final uid = FirebaseAuth.instance.currentUser?.uid;

    // Tạo đối tượng UserModel
    final userModel = UserModel(
      id: uid,
      email: email,
      passWord: password,
      phoneNub: "",
      isActive: true,
    );

    // Lưu thông tin người dùng vào database (thông qua _profileController)
    _profileController.createUser(userModel);

    // Thông báo thành công
    Incorrect("Register Success");

    // Lấy thông tin chi tiết người dùng
    homeController.getUserDetails(email);

    // Xóa dữ liệu các controller
    clearControllLogin();

    // Đóng Dialog và điều hướng (nếu cần)
    Get.back();
  } catch (e) {
    // Xử lý lỗi chung (nếu có lỗi khác ngoài FirebaseAuthException)
    Get.back();
    wrongMessage(context, "Có lỗi xảy ra: $e");
  }
}

  void login(BuildContext context) async {
    AppFocus.unFocus(context);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        Timer(
          const Duration(seconds: 1),
          () {
            Get.back();
          },
        );
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      await homeController.getUserDetails(loginEmailController.text);
      final fcmTokenGet = LocalStorageHelper.getValue('fcmToken') ?? "";
      profileController.createPushNotification(
        homeController.userModel.value?.id ?? "",
        fcmTokenGet,
      );
      clearControllLogin();

      Get.back();
    } on FirebaseAuthException catch (e) {
      wrongMessage(context, e.code);
    }
  }

  // ignore: non_constant_identifier_names
  void Incorrect(String text) {
    final context = Get.context;
    showDialog(
      context: context!,
      barrierDismissible: true,
      anchorPoint: const Offset(10, 10),
      builder: (context) {
        Timer(const Duration(seconds: 2), () {
          Get.back();
        });
        return Center(
          child: AlertDialog(
            title: Center(
              child: Text(text),
            ),
          ),
        );
      },
    );
  }

  // error message show dialog
  void wrongMessage(BuildContext context, String message) {
    String errorMessage = message;
    if (message == "weak-password") {
      errorMessage = "The password is too weak";
    } else if (message == "email-already-in-use") {
      errorMessage = "The email address is already in use";
    } else if (message == "user-not-found") {
      errorMessage = "User not found. Please register.";
    } else if (message == "wrong-password") {
      errorMessage = "Invalid password. Please try again.";
    } else if (message == "network-request-failed register") {
      errorMessage = "No internet. Please try again.";
    } else if (message == "user-disabled") {
      errorMessage = "User disabled !!!";
    } else if (message == "invalid-email") {
      errorMessage = "Invalid email. Please try again.";
    } else if (message == "email-already-exists") {
      errorMessage = "Email already exists !!!";
    } else if (message == "id-token-expired") {
      errorMessage = "Id token expired !!!";
    } else if (message == "id-token-revoked") {
      errorMessage = "Id token revoked !!!";
    } else if (message == "insufficient-permission") {
      errorMessage = "You are insufficient permission";
    } else if (message == "internal-error") {
      errorMessage = "Server error. Please try again!!!";
    } else if (message == "phone-number-already-exists") {
      errorMessage = "Phone number already exists";
    } else if (message == "project-not-found") {
      errorMessage = "Project not found";
    } else if (message == "session-cookie-expired") {
      errorMessage = "Session cookie expired";
    } else if (message == "too-many-requests") {
      errorMessage = "Too many requests";
    } else if (message == "uid-already-exists") {
      errorMessage = "Uid already exists";
    } else {
      errorMessage = "Something went wrong.";
    }

    final contextGet = Get.context;
    showDialog(
      context: contextGet!,
      barrierDismissible: true,
      builder: (context) {
        Timer(
          const Duration(seconds: 4),
          () {
            Get.back();
          },
        );
        return AlertDialog(
          backgroundColor: ColorConstants.primaryButton,
          title: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.dispose();
  }
}
