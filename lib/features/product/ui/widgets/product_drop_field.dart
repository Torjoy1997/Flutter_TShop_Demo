import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductSortDropdown extends StatelessWidget {
  const ProductSortDropdown(
      {super.key,
      required this.sortItems,
      required this.onPressed,
      required this.selectedValue});

  final List<String> sortItems;
  final void Function(String?) onPressed;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        items: sortItems
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        onChanged: onPressed);
  }
}
