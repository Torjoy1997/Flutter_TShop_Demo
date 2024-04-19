import 'package:flutter/material.dart';
import 'package:ecommerce_demo/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_widgets/form/chip.dart';
import '../../../../../core/layout/section_headline_layout.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../model/product_attribute.dart';
import 'product_variation_title.dart';

class ProductVariationSection extends StatefulWidget {
  const ProductVariationSection(
      {super.key,
      required this.onSelectedValue,
      required this.section1,
      required this.section2});

  final List<Map<String, dynamic>> onSelectedValue;
  final ProductAttributeModel section1, section2;

  @override
  State<ProductVariationSection> createState() =>
      _ProductVariationSectionState();
}

class _ProductVariationSectionState extends State<ProductVariationSection> {
  Map<String, dynamic> _defaultSelect = {};
  String _firstVariation = '';
  String _secondVariation = '';

  Map<String, dynamic> get defaultSelect {
    return _defaultSelect.isEmpty
        ? widget.onSelectedValue.first
        : _defaultSelect;
  }

  set defaultSelect(Map<String, dynamic> value) {
    _defaultSelect = value;
  }

  String get firstVariation {
    return _firstVariation.isEmpty ? defaultSelect.keys.first : _firstVariation;
  }

  set firstVariation(String value) {
    _firstVariation = value;
  }

  String get secondVariation {
    return _secondVariation.isEmpty
        ? defaultSelect[firstVariation][widget.section2.name].first
        : _secondVariation;
  }

  set secondVariation(String value) {
    _secondVariation = value;
  }

  @override
  void initState() {
    context.read<ProductBloc>().add(SetVariationEvent(variations: {
          widget.section1.name!: firstVariation,
          widget.section2.name!: secondVariation,
          'image': defaultSelect[firstVariation]['image'],
          'price':
              defaultSelect[firstVariation]['salePrice'][secondVariation] == 0
                  ? defaultSelect[firstVariation]['price'][secondVariation]
                  : defaultSelect[firstVariation]['salePrice'][secondVariation],
          'stock': defaultSelect[firstVariation]['stoke'][secondVariation]
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double actualPrice =
        defaultSelect[firstVariation]['salePrice'][secondVariation] == 0
            ? defaultSelect[firstVariation]['price'][secondVariation].toDouble()
            : defaultSelect[firstVariation]['salePrice'][secondVariation]
                .toDouble();
    int stock = defaultSelect[firstVariation]['stoke'][secondVariation];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BoxContainer(
        backGroundColor: AppHelperFunctions.isDarkMode(context)
            ? AppDefineColors.darkGrey
            : AppDefineColors.grey,
        padding: const EdgeInsets.all(AppDefineSizes.md),
        radius: 10,
        child: Column(
          children: [
            Row(
              children: [
                const SectionHeading(
                  title: 'Variations',
                  showActionButton: false,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleValue(
                      title: widget.section1.name!,
                      value: firstVariation,
                    ),
                    TitleValue(
                        title: widget.section2.name!, value: secondVariation),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems,
      ),
      SectionHeading(
        title: widget.section1.name ?? '',
        showActionButton: false,
      ),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems / 2,
      ),
      Wrap(
          spacing: 8,
          children: widget.section1.values!
              .map(
                (value) => FormChoiceChip(
                  text: value,
                  selected: defaultSelect.keys.contains(value),
                  onSelected: (item) {
                    setState(() {
                      defaultSelect = widget.onSelectedValue
                          .where((element) => element.keys.contains(value))
                          .first;

                      firstVariation = defaultSelect.keys.first;
                      secondVariation = defaultSelect[firstVariation]
                              [widget.section2.name]
                          .first;
                    });
                    context
                        .read<ProductBloc>()
                        .add(SetVariationEvent(variations: {
                          widget.section1.name!: firstVariation,
                          widget.section2.name!: secondVariation,
                          'image': defaultSelect[firstVariation]['image'],
                          'price': actualPrice,
                          'stock': stock
                        }));
                  },
                ),
              )
              .toList()),
      SectionHeading(
        title: widget.section2.name ?? '',
        showActionButton: false,
      ),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems / 2,
      ),
      Wrap(
          spacing: 8,
          children: widget.section2.values!
              .map(
                (value) => FormChoiceChip(
                    text: value,
                    selected: secondVariation == value,
                    onSelected: defaultSelect[firstVariation]
                                [widget.section2.name]
                            .contains(value)
                        ? (item) {
                            setState(() {
                              secondVariation = value;
                            });
                            context
                                .read<ProductBloc>()
                                .add(SetVariationEvent(variations: {
                                  widget.section1.name!: firstVariation,
                                  widget.section2.name!: secondVariation,
                                  'image': defaultSelect[firstVariation]
                                      ['image'],
                                  'price': actualPrice,
                                  'stock': stock
                                }));
                          }
                        : null),
              )
              .toList()),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems / 2,
      ),
      const SectionHeading(
        title: 'Price && Stock Status',
        showActionButton: false,
      ),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems / 2,
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          '€ $actualPrice',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(color: AppDefineColors.darkerGrey),
        ),
      ),
      const SizedBox(
        height: AppDefineSizes.spaceBtwItems / 2,
      ),
      if (stock > 0)
        Padding(
            padding: const EdgeInsets.all(12),
            child: Text('In stock this variation ($stock)'))
      else
        Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'out stock this variation',
              style: Theme.of(context).textTheme.titleSmall,
            ))
    ]);
  }
}
