import 'package:ecommerce_demo/features/product/model/product_variation.dart';
import 'package:ecommerce_demo/features/product/repos/product.dart';

import 'package:ecommerce_demo/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_demo/features/product/model/product_attribute.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_variation_section.dart';

class ProductActionAttribute extends StatelessWidget {
  const ProductActionAttribute({
    Key? key,
    this.productAttribute = const <ProductAttributeModel>[],
    required this.productType,
    this.productVariation,
  }) : super(key: key);

  final List<ProductAttributeModel> productAttribute;
  final String productType;
  final List<ProductVariationModel>? productVariation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (productType == ProductType.variable.toString())
          ProductVariationSection(
            section1: productAttribute[0],
            section2: productAttribute[1],
            onSelectedValue: context
                .read<ProductRepository>()
                .getSelectedVariation(productVariation!),
          )
      ],
    );
  }
}
