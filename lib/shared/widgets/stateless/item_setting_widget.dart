import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ItemSettingWidget extends StatelessWidget {
  const ItemSettingWidget({
    super.key,
    required this.title,
    this.description,
    required this.image,
    this.ontap,
    this.trailing,
  });

  final String title;
  final String? description;
  final String image;
  final Function()? ontap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(12)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getSize(12),
          horizontal: getSize(10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: getSize(28),
              height: getSize(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(getSize(4)),
              child: SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                  ColorConstants.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppStyles.black000Size16Fw400FfMont
                        .copyWith(color: ColorConstants.black),
                  ),
                  SizedBox(
                    height: getSize(4),
                  ),
                  description != null
                      ? Text(
                          description ?? '',
                          style: AppStyles.botTitle000Size12Fw400FfMont
                              .copyWith(color: ColorConstants.botTitle),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            trailing ??
                SizedBox(
                  height: 24,
                  child: SvgPicture.asset(
                    AssetHelper.icoNextRight,
                    colorFilter: ColorFilter.mode(
                      ColorConstants.titleSearch,
                      BlendMode.srcIn,
                    ),
                    width: getSize(24),
                    height: getSize(24),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
