import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_demo/features/Address/bloc/address_bloc.dart';
import 'package:ecommerce_demo/features/Address/repos/address.dart';
import 'package:ecommerce_demo/features/Autocomplete/cubit/auto_complete_cubit.dart';
import 'package:ecommerce_demo/features/Autocomplete/repos/auto_complete.dart';
import 'package:ecommerce_demo/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:ecommerce_demo/features/order/bloc/order_bloc.dart';
import 'package:ecommerce_demo/features/order/repos/order.dart';

import 'package:firebase_authentication_repository/authentication_repository.dart';

import '../../features/account/bloc/account_bloc.dart';
import '../../features/account/repos/account_repos.dart';
import '../../features/authentication/bloc/auth_bloc.dart';
import '../../features/cart/bloc/cart_bloc.dart';
import '../../features/cart/repos/cart.dart';

import '../../features/dash_board/repos/banner.dart';
import '../../features/network_manager/cubit/network_cubit.dart';
import '../../features/on_board/cubit/on_board_cubit.dart';
import '../../features/product/bloc/product_bloc.dart';
import '../../features/product/repos/product.dart';
import '../../features/store/bloc/store_bloc.dart';
import '../../features/store/repos/store.dart';
import '../../features/wish_list/bloc/wish_list_bloc.dart';
import '../../features/wish_list/repos/wish_list.dart';

class AppProvidersAndRepos {
  static final AddressRepository addressRepository = AddressRepository();
  static final ProductRepository productRepository = ProductRepository();
  static final CartRepository cartRepository = CartRepository();
  static final WishListRepository wishRepository = WishListRepository();
  static final NetworkCubit networkCubit =
      NetworkCubit(connectivity: Connectivity());
  static final onBoardCubit = OnBoardCubit();
  static final AutoCompleteCubit autoCompleteCubit =
      AutoCompleteCubit(AutoCompleteRepository());
  static final DashboardBloc dashboardBloc = DashboardBloc(BannerRepository());
  static final ProductBloc productBloc = ProductBloc(productRepository);
  static final WishListBloc wishListBloc = WishListBloc(wishRepository);
  static final CartBloc cartBloc = CartBloc(cartRepository, productRepository);
  static final AccountBloc accountBloc = AccountBloc(AccountRepository());
  static final AuthBloc authBloc = AuthBloc(AuthRepository(), accountBloc);
  static final StoreBloc storeBloc = StoreBloc(StoreRepository());
  static final AddressBloc addressBloc =
      AddressBloc(addressRepository: addressRepository);
  static final OrderBloc orderBloc =
      OrderBloc(OrderRepository(), cartRepository);
}
