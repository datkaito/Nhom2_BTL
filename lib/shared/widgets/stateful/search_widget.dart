import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../modules/search/search_controller.dart';
import '../../../routes/app_pages.dart';
import '../../constants/app_style.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({
    super.key,
    this.hintText,
    this.textEditingController,
    this.onChanged,
    this.focusNode,
  });

  final String? hintText;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  final SearchDesController searchController = Get.put(SearchDesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.lightCard,
        borderRadius: BorderRadius.circular(14),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: getSize(16), vertical: getSize(4)),
      child: Row(
        children: [
          Obx(
            () => searchController.isCheckOnClickSearch.value
                ? GestureDetector(
                    onTap: () {
                      searchController.isCheckOnClickSearch.value = false;
                      searchController.getAllTourSearchScreen.value = [];
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: SvgPicture.asset(
                      AssetHelper.icArrowLeft,
                      height: getSize(18),
                      width: getSize(18),
                      colorFilter: ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    AssetHelper.icoSearch,
                    height: getSize(18),
                    width: getSize(18),
                    colorFilter: ColorFilter.mode(
                      ColorConstants.titleSearch,
                      BlendMode.srcIn,
                    ),
                  ),
          ),
          SizedBox(
            width: getSize(16),
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Get.toNamed(Routes.SEARCH_TOUR_SCREEN, arguments: value);
                  searchController.searchTourEditingController.text = value;
                  searchController.addSearchTour(value);
                  searchController.getAllSearch();
                  searchController.setHistorySearch(value);
                  searchController.getHistorySearch();
                }
              },
              focusNode: focusNode,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppStyles.titleSearchSize16Fw400FfMont
                    .copyWith(color: ColorConstants.titleSearch),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getSize(9),
                ),
                alignLabelWithHint: true,
              ),
              style: AppStyles.titleSearchSize16Fw400FfMont
                  .copyWith(color: ColorConstants.titleSearch),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: getSize(16),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.GOOGLE_MAP_SCREEN),
            child: SvgPicture.asset(
              AssetHelper.icoMaps,
              height: getSize(20),
              width: getSize(20),
              colorFilter: ColorFilter.mode(
                ColorConstants.graySecond,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
