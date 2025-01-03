import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

import '../constants/app_style.dart';
import 'user_profile_setting_item.dart';

class BuildSettingsGroup extends StatelessWidget {
  final String? settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final String? settingsGroupContentTitle;
  final TextStyle? settingsGroupContentTitleStyle;
  final List<BuildSettingsItem> items;
  final double? iconItemSize;
  final String? subTitle;

  const BuildSettingsGroup(
      {super.key,
      this.settingsGroupTitle,
      this.settingsGroupTitleStyle,
      this.settingsGroupContentTitle,
      this.settingsGroupContentTitleStyle,
      required this.items,
      this.subTitle,
      this.iconItemSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (settingsGroupTitle != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    settingsGroupTitle!,
                    style: (settingsGroupTitleStyle == null)
                        ? AppStyles.gray800Size16Fw500FfMont
                        : settingsGroupTitleStyle,
                  ),
                )
              : Container(),
          SizedBox(
            height: getSize(16),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.lightCard,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                if (settingsGroupContentTitle != null)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 24,
                        top: 24,
                        left: 18,
                      ),
                      child: Text(
                        settingsGroupContentTitle!,
                        style: (settingsGroupContentTitleStyle == null)
                            ? AppStyles.black000Size14Fw500FfMont
                            : settingsGroupContentTitleStyle,
                      ),
                    ),
                  ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Divider(
                        color: ColorConstants.black.withOpacity(.15),
                        thickness: 0.5,
                      ),
                    );
                  },
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return items[index];
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
