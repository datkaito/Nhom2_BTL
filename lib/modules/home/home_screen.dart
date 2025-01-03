import 'package:doan_clean_achitec/models/Destination.dart';
import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/modules/history_tour/history_tour_screen.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../shared/widgets/stateless/drawer_widget.dart';
import '../auth/user_controller.dart';
import '../setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final user = FirebaseAuth.instance.currentUser!;
final userName = user.email.toString().substring(0, 3);
final UserController userController = Get.find();
final HomeController homeController = Get.find();
final TourController tourController = Get.put(TourController());

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    initializeUser();
    _loadDestination();
    getAllCityInit();
  }

  void getAllCityInit() async {
    await tourController.getAllCity();
    tourController.loadCity();
  }

  void initializeUser() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null && user!.email != null) {
      if (user!.email!.isNotEmpty) {
        StringConst.userName = user!.email!.toString().substring(0, 3);
        userController.userName.value = user!.email!.toString().substring(0, 5);
        userController.userEmail.value = user!.email!;
      }
    }
  }

  void _loadDestination() {
    setState(() {
      addListDestination(destiList);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.blue,
    ));
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        key: homeController.scaffoldHomeKey,
        drawer: DrawerWidget(),
        body: SafeArea(
          child: IndexedStack(
            index: homeController.currentIndex.value,
            children: _widgetOptions(),
          ),
        ),
        backgroundColor: ColorConstants.white,
        bottomNavigationBar: SalomonBottomBar(
          onTap: (index) {
            homeController.currentIndex.value = index;
          },
          currentIndex: homeController.currentIndex.value,
          selectedItemColor: ColorConstants.primaryButton,
          unselectedItemColor: ColorConstants.primaryButton.withOpacity(0.2),
          backgroundColor: ColorConstants.white,
          curve: Curves.easeOutQuint,
          duration: const Duration(milliseconds: 1000),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.house,
                size: kDefaultIconSize,
              ),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.search,
                size: kDefaultIconSize,
              ),
              title: const Text('Search'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.ccDiscover,
                size: kDefaultIconSize,
              ),
              title: const Text('History'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.briefcase,
                size: kDefaultIconSize,
              ),
              title: const Text('Booking'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.gears,
                size: kDefaultIconSize,
              ),
              title: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _widgetOptions() {
    return [
      HomeTab(),
      SearchScreen(),
      HistoryScreen(),
      BookingScreen(),
      SettingScreen(),
    ];
  }
}
