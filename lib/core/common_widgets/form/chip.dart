import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class FormChoiceChip extends StatelessWidget {
  const FormChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColorExist = AppHelperFunctions.getColor(text) != null;
    return ChoiceChip(
      selected: selected,
      onSelected: onSelected,
      label: isColorExist ? const SizedBox() : Text(text),
      labelStyle: TextStyle(color: selected ? AppDefineColors.white : null),
      avatar: isColorExist
          ? BoxContainer(
              width: 50,
              height: 50,
              radius: 50,
              backGroundColor: AppHelperFunctions.getColor(text)!,
            )
          : null,
      shape: isColorExist ? const CircleBorder() : null,
      padding: isColorExist ? const EdgeInsets.all(0) : null,
      labelPadding: isColorExist ? const EdgeInsets.all(0) : null,
      backgroundColor: isColorExist ? AppHelperFunctions.getColor(text)! : null,
    );
  }
}
