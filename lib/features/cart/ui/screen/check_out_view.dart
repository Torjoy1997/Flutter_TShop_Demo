import 'package:ecommerce_demo/core/common_widgets/shimmer/address_shimmer.dart';
import 'package:ecommerce_demo/features/cart/model/payment_model.dart';
import 'package:ecommerce_demo/features/order/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layout/box_container_layout.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../Address/bloc/address_bloc.dart';
import '../../../Address/model/address.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../model/cart_item_model.dart';
import '../widgets/billing_address_section.dart';
import '../widgets/billing_amount_section.dart';
import '../widgets/billing_payment_section.dart';
import '../widgets/cart_menu_item.dart';
import '../widgets/cupon.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen(
      {super.key, required this.cartData, required this.totalPrice});
  final List<CartItemModel> cartData;
  final double totalPrice;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<AddressModel> userAddress = [];
  PaymentMethodModel paymentData = PaymentMethodModel.empty();
  double totalPrice = 0.0;

  @override
  void initState() {
    context.read<AddressBloc>().add(const FetchUserAddressEvent());
    context.read<AddressBloc>().add(const FetchPaymentEvent());
    totalPrice = widget.totalPrice +
        6.0 +
        double.parse(
            TPricingCalculator.calculateTax(widget.totalPrice, 'germany'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            context.read<OrderBloc>().add(AddOrderEvent(
                orderData: OrderModel(
                    items: widget.cartData,
                    totalAmount: totalPrice,
                    orderDate: DateTime.now(),
                    paymentMethod: paymentData,
                    billingAddress: userAddress.first)));
          },
          child: Text('CheckOut € $totalPrice'),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state is FetchUserAddressLoaded) {
                userAddress = state.userAddress;
                userAddress.sort((a, b) {
                  if (b.seclectedAddress) {
                    return 1;
                  }
                  return -1;
                });
              }

              if (state is FetchPaymentMethod) {
                paymentData = state.paymentData;
              }
            },
          ),
          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is AddOrdersItem) {
                context.goNamed('paymentSuccess');
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
            child: Column(children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => CartMenuItem(
                        cartId: widget.cartData[index].id,
                        title: widget.cartData[index].title,
                        quantity: widget.cartData[index].quantity,
                        image: widget.cartData[index].image,
                        brandData: widget.cartData[index].brandData,
                        price: widget.cartData[index].price,
                        variations:
                            widget.cartData[index].selectedVariation ?? {},
                      ),
                  separatorBuilder: (_, __) => const SizedBox(
                        height: AppDefineSizes.spaceBtwSections,
                      ),
                  itemCount: widget.cartData.length),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              const CouponBox(),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              BoxContainer(
                showBorder: true,
                backGroundColor:
                    dark ? AppDefineColors.black : AppDefineColors.white,
                radius: 15,
                padding: const EdgeInsets.all(AppDefineSizes.md),
                child: Column(children: [
                  BillingAmountSection(
                    totalPrice: widget.totalPrice,
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      if (paymentData.image.isEmpty) {
                        return const AddressShimmer();
                      } else {
                        return BillingPaymentSection(
                          paymentData: paymentData,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      if (state is FetchUserAddressLoading) {
                        return const AddressShimmer();
                      }
                      if (state is FetchUserAddressLoaded) {
                        if (state.userAddress.isNotEmpty) {
                          return BillAddressSection(
                            userAddress: userAddress,
                          );
                        }
                      }

                      return TextButton(
                          onPressed: () {
                            context.pushNamed('Add_Address');
                          },
                          child: const Text('please add your address'));
                    },
                  )
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
