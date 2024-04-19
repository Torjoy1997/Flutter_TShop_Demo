import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class CustomTabBar extends StatelessWidget implements PreferredSize {
  const CustomTabBar({super.key, required this.tabs, this.tabController});

  final List<Widget> tabs;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppHelperFunctions.isDarkMode(context)
          ? AppDefineColors.black
          : AppDefineColors.white,
      child: TabBar(
        controller: tabController,
        tabs: tabs,
        onTap: (value) {
          debugPrint(value.toString());
        },
        isScrollable: true,
        indicatorColor: AppDefineColors.primary,
        labelColor: AppHelperFunctions.isDarkMode(context)
            ? AppDefineColors.white
            : AppDefineColors.primary,
        unselectedLabelColor: AppDefineColors.darkGrey,
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}
