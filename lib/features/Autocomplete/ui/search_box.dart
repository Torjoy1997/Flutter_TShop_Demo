import 'package:ecommerce_demo/core/layout/rounded_image_layout.dart';
import 'package:ecommerce_demo/features/Autocomplete/cubit/auto_complete_cubit.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/utils/constants/enums.dart';
import 'package:ecommerce_demo/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../model/autocomplete_model.dart';

class CustomSearchBox extends StatefulWidget {
  const CustomSearchBox({
    super.key,
    required this.textSearch,
    this.icon,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppDefineSizes.defaultSpace),
  });

  final String textSearch;
  final IconData? icon;

  final EdgeInsets padding;

  @override
  State<CustomSearchBox> createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  List<AutoCompleteModel> autoCompleteData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final autoCubit = context.read<AutoCompleteCubit>();
      autoCubit.fetchAutoCompleteData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context).routerDelegate.currentConfiguration;

    return BlocListener<AutoCompleteCubit, AutoCompleteState>(
      listener: (context, state) {
        if (state is AutoCompleteLoadedState) {
          autoCompleteData = state.autoCompeleData;
        }
      },
      child: Padding(
          padding: widget.padding,
          child: Autocomplete(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              } else {
                if (autoCompleteData.isNotEmpty) {
                  return autoCompleteData.where((word) => word.title
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                } else {
                  return const Iterable<String>.empty();
                }
              }
            },
            optionsViewBuilder:
                (context, Function(AutoCompleteModel) onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Card(
                  elevation: 4,
                  child: SizedBox(
                    width: AppHelperFunctions.screenWidth(context) - 50,
                    height: 350,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(top: 12.0),
                        shrinkWrap: false,
                        itemBuilder: (_, index) {
                          final autoData =
                              options.elementAt(index) as AutoCompleteModel;
                          return ListTile(
                            title: Text(
                              autoData.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: RoundedImageLayout(
                              imageUrl: autoData.image,
                              isNetworkImage:
                                  autoData.type == AutoCompleteType.product,
                            ),
                            dense: true,
                            onTap: () {
                              onSelected(autoData);
                            },
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: options.length),
                  ),
                ),
              );
            },
            onSelected: (option) {
              if (option is AutoCompleteModel) {
                if (option.type == AutoCompleteType.product) {
                  context.pushNamed('product_detail',
                      pathParameters: {'id': option.itemId});
                } else {
                  context.push('/store/brands/${option.title}',
                      extra: BrandModel(
                          image: option.image,
                          name: option.title,
                          productsCount: 12));
                }
              }
            },
            displayStringForOption: (option) {
              if (option is AutoCompleteModel) {
                return option.title;
              } else {
                return '';
              }
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                onEditingComplete: onFieldSubmitted,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.icon,
                    color: AppDefineColors.darkGrey,
                  ),
                  filled: true,
                  fillColor: AppDefineColors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: router.fullPath == '/store'
                              ? AppDefineColors.black
                              : AppDefineColors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: router.fullPath == '/store'
                              ? AppDefineColors.black
                              : AppDefineColors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: router.fullPath == '/store'
                              ? AppDefineColors.black
                              : AppDefineColors.white)),
                  hintText: widget.textSearch,
                ),
              );
            },
          )),
    );
  }
}
