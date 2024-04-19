import 'package:ecommerce_demo/core/common_widgets/shimmer/cart_shimmer.dart';
import 'package:ecommerce_demo/features/order/bloc/order_bloc.dart';
import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/order_model.dart';
import '../widget/order_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel> orderData = [];

  @override
  void initState() {
    context.read<OrderBloc>().add(FetchOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: CustomAppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrederFetchLoadedState) {
            orderData = state.orderData;
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),

            /// -- Orders
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderFetchLoadingState) {
                  return const CartShimmer();
                }
                if (orderData.isNotEmpty) {
                  return OrderListItems(
                    order: orderData,
                  );
                } else {
                  return Center(
                    child: Text(
                      'There is No Data',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppDefineColors.grey),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
