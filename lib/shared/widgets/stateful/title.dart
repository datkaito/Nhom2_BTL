import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../constants/app_style.dart';

class TitleHome extends StatefulWidget {
  const TitleHome({super.key, required this.title});
  final String title;

  @override
  State<TitleHome> createState() => _TitleHomeState();
}

class _TitleHomeState extends State<TitleHome> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: AppStyles.black000Size20Fw500FfMont
          .copyWith(color: ColorConstants.black),
    );
  }
}
