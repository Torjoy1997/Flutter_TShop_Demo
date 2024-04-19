import 'package:ecommerce_demo/core/common_widgets/card/horizontal_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';

class ProductsSectionView extends StatelessWidget {
  const ProductsSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Popular Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: Column(
            children: [
              DropdownButtonFormField(
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  items: [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popuarity'
                  ]
                      .map((option) =>
                          DropdownMenuItem(value: option, child: Text(option)))
                      .toList(),
                  onChanged: (value) {}),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              GridLayout(
                  itemCount: 10,
                  itemBuilder: (context, index) => const HorizontalCardView())
            ],
          ),
        ),
      ),
    );
  }
}
