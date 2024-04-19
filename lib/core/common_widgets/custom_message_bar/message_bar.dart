
import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/image_strings.dart';




class MessageBar {
  static Widget errorSnackBar({required String title, String message = ''}) {
     return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 1,),
                        Text(
                          message,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: SvgPicture.asset(
                  AppImages.bubblesIcon,
                  height: 48,
                  width: 40,
                  colorFilter: const ColorFilter.mode(Color(0xFF801336), BlendMode.srcIn),
                ),
              )),
          Positioned(
              top: -20,
              left: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: SvgPicture.asset(
                  AppImages.failIcon,
                  height: 40,
                  colorFilter: const ColorFilter.mode(Color(0xFF801336), BlendMode.srcIn),
                ),
              )),
        ],
      );
  }

  static Widget successSnackBar({required String title, String message = ''}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
              color:  Color(0xFFA5D6A7),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 1,),
                      Text(
                        message,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                AppImages.bubblesIcon,
                height: 48,
                width: 40,
                colorFilter: const ColorFilter.mode(Color(0xFF1B5E20), BlendMode.srcIn),

              ),
            )),
        Positioned(
            top: -20,
            left: 0,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                AppImages.failIcon,
                height: 40,
                colorFilter: const ColorFilter.mode(Color(0xFF1B5E20), BlendMode.srcIn),
              ),
            )),
      ],
    );
  }


  static Widget infoSnackBar({required String title, String message = ''}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
              color:  AppDefineColors.warning,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 1,),
                      Text(
                        message,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                AppImages.bubblesIcon,
                height: 48,
                width: 40,
                colorFilter: const ColorFilter.mode(Color(0xFFfcb103), BlendMode.srcIn),

              ),
            )),
        Positioned(
            top: -20,
            left: 0,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                AppImages.failIcon,
                height: 40,
                colorFilter: const ColorFilter.mode(Color(0xFFfcb103), BlendMode.srcIn),
              ),
            )),
      ],
    );
  }

}

