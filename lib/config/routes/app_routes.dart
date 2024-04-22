import 'package:ecommerce_demo/core/layout/screen/success.dart';
import 'package:ecommerce_demo/features/account/ui/screen/account.dart';

import 'package:ecommerce_demo/features/authentication/ui/screen/signup.dart';
import 'package:ecommerce_demo/features/authentication/ui/screen/verify_email.dart';
import 'package:ecommerce_demo/features/authentication/ui/screen/verify_success.dart';
import 'package:ecommerce_demo/features/bottom_navigation_menu/bottom_navigation_menu.dart';
import 'package:ecommerce_demo/features/cart/model/cart_item_model.dart';
import 'package:ecommerce_demo/features/cart/ui/screen/cart.dart';
import 'package:ecommerce_demo/features/dash_board/ui/screen/dash_board.dart';
import 'package:ecommerce_demo/features/network_manager/ui/disconnected_screen.dart';
import 'package:ecommerce_demo/features/on_board/ui/on_board_screen.dart';
import 'package:ecommerce_demo/features/order/ui/screen/order.dart';
import 'package:ecommerce_demo/features/product/ui/screen/product_detail.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/features/store/ui/screen/all_brand_section.dart';
import 'package:ecommerce_demo/features/store/ui/screen/brand_selected_products.dart';
import 'package:ecommerce_demo/features/store/ui/screen/store.dart';
import 'package:ecommerce_demo/features/wish_list/ui/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import '../../features/Address/ui/addresss_view.dart';
import '../../features/Address/ui/widgets/add_address.dart';

import '../../features/account/ui/screen/acount_detail.dart';
import '../../features/authentication/ui/screen/forget_password.dart';
import '../../features/authentication/ui/screen/login.dart';
import '../../features/authentication/ui/screen/reset_password.dart';
import '../../features/cart/ui/screen/check_out_view.dart';
import '../../features/product/ui/screen/all_product_view.dart';
import '../../features/product/ui/screen/product_review.dart';
import '../../features/product/ui/screen/products_section_view.dart';
import '../../utils/constants/image_strings.dart';
import '../provider/bloc_provider.dart';
import 'redirections.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final AppRedirectRepository appRedirectRepository = AppRedirectRepository();

  GoRouter get router => GoRouter(
        initialLocation: '/on-board',
        navigatorKey: _rootNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
              path: '/disconnect_internet',
              name: 'DisConnectPage',
              builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.networkCubit,
                    child: const NetworkDisconnectPage(),
                  )),
          StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) => DashBoardBottomMenu(
                    navigationShell: navigationShell,
                  ),
              branches: <StatefulShellBranch>[
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/home',
                    name: 'Home',
                    builder: (context, state) => MultiBlocProvider(providers: [
                      BlocProvider.value(
                        value: AppProvidersAndRepos.networkCubit,
                      ),
                      BlocProvider.value(
                          value: AppProvidersAndRepos.autoCompleteCubit),
                      BlocProvider.value(
                          value: AppProvidersAndRepos.dashboardBloc),
                      BlocProvider.value(
                          value: AppProvidersAndRepos.productBloc),
                      BlocProvider.value(
                          value: AppProvidersAndRepos.wishListBloc),
                      BlocProvider.value(value: AppProvidersAndRepos.cartBloc),
                    ], child: const DashBoardScreen()),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: '/store',
                      name: 'Store',
                      builder: (context, state) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: AppProvidersAndRepos.storeBloc,
                              ),
                              BlocProvider.value(
                                value: AppProvidersAndRepos.networkCubit,
                              ),
                              BlocProvider.value(
                                  value:
                                      AppProvidersAndRepos.autoCompleteCubit),
                              BlocProvider.value(
                                  value: AppProvidersAndRepos.cartBloc),
                              BlocProvider.value(
                                  value: AppProvidersAndRepos.wishListBloc)
                            ],
                            child: const StoreScreen(),
                          ),
                      routes: [
                        GoRoute(
                            path: 'brands',
                            name: 'all_brands',
                            builder: (context, state) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: AppProvidersAndRepos.storeBloc,
                                    ),
                                  ],
                                  child: AllBrandsView(
                                    brands: state.extra as List<BrandModel>,
                                  ),
                                ),
                            routes: [
                              GoRoute(
                                path: ':name',
                                builder: (context, state) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: AppProvidersAndRepos.productBloc,
                                    ),
                                    BlocProvider.value(
                                        value: AppProvidersAndRepos.storeBloc),
                                    BlocProvider.value(
                                        value:
                                            AppProvidersAndRepos.wishListBloc)
                                  ],
                                  child: BrandSelectedProducts(
                                      brand: state.extra as BrandModel),
                                ),
                              )
                            ]),
                      ]),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/wish_list',
                    name: 'WishList',
                    builder: (context, state) => BlocProvider.value(
                      value: AppProvidersAndRepos.wishListBloc,
                      child: const WishListView(),
                    ),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: '/account',
                      name: 'Account',
                      builder: (context, state) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: AppProvidersAndRepos.accountBloc,
                              ),
                              BlocProvider.value(
                                value: AppProvidersAndRepos.authBloc,
                              ),
                              BlocProvider.value(
                                  value: AppProvidersAndRepos.cartBloc),
                            ],
                            child: const AccountScreen(),
                          ),
                      routes: [
                        GoRoute(
                            path: 'address',
                            name: 'Address',
                            builder: (context, state) => BlocProvider.value(
                                  value: AppProvidersAndRepos.addressBloc,
                                  child: const AddressScreen(),
                                ),
                            routes: [
                              GoRoute(
                                path: 'add-address',
                                name: 'Add_Address',
                                builder: (context, state) => BlocProvider.value(
                                  value: AppProvidersAndRepos.addressBloc,
                                  child: const AddNewAddressScreen(),
                                ),
                              )
                            ]),
                        GoRoute(
                            path: 'account-detail',
                            name: 'AccountDetail',
                            builder: (context, state) => BlocProvider.value(
                                  value: AppProvidersAndRepos.accountBloc,
                                  child: const AccountInfoView(),
                                )),
                        GoRoute(
                          path: 'order',
                          name: 'Order',
                          builder: (context, state) => BlocProvider.value(
                            value: AppProvidersAndRepos.orderBloc,
                            child: const OrderScreen(),
                          ),
                        )
                      ])
                ])
              ]),
          GoRoute(
            path: '/on-board',
            builder: (context, state) => BlocProvider.value(
              value: AppProvidersAndRepos.onBoardCubit,
              child: const OnboardingScreen(),
            ),
            redirect: (context, state) =>
                appRedirectRepository.onBoardRedirectPath,
          ),
          GoRoute(
              path: '/login',
              name: 'login',
              builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.authBloc,
                    child: const LoginScreen(),
                  ),
              redirect: (context, state) =>
                  appRedirectRepository.getLoginRedirectPath,
              routes: [
                GoRoute(
                  path: 'forget-password',
                  name: 'forget_password',
                  builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.authBloc,
                    child: const ForgetPasswordScreen(),
                  ),
                ),
                GoRoute(
                  path: 'reset-success',
                  name: 'reset_success',
                  builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.authBloc,
                    child: const ResetPasswordScreen(),
                  ),
                )
              ]),
          GoRoute(
              path: '/signup',
              builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.authBloc,
                    child: const SignUpScreen(),
                  ),
              routes: [
                GoRoute(
                  path: 'verify-email',
                  builder: (context, state) => BlocProvider.value(
                    value: AppProvidersAndRepos.authBloc,
                    child: VerifyEmailScreen(
                      email: state.uri.queryParameters['email'],
                    ),
                  ),
                ),
                GoRoute(
                    path: 'verify-success',
                    name: 'verify_email_success',
                    builder: (context, state) =>
                        const VerifyEmailSuccessScreen())
              ]),
          GoRoute(
            path: '/product-detail/:id',
            name: 'product_detail',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: AppProvidersAndRepos.productBloc,
                    ),
                    BlocProvider.value(
                        value: AppProvidersAndRepos.wishListBloc),
                    BlocProvider.value(value: AppProvidersAndRepos.cartBloc),
                  ],
                  child: ProductDetailScreen(
                    id: id!,
                  ));
            },
          ),
          GoRoute(
              path: '/review',
              name: 'product_review',
              builder: (context, state) => const ProductReviewScreen()),
          GoRoute(
              path: '/product-section',
              name: 'products_section',
              builder: (context, state) => const ProductsSectionView()),
          GoRoute(
              path: '/all-product-view',
              name: 'AllProductsView',
              builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: AppProvidersAndRepos.productBloc,
                      ),
                      BlocProvider.value(
                        value: AppProvidersAndRepos.wishListBloc,
                      ),
                    ],
                    child: const AllProductScreen(),
                  )),
          GoRoute(
              path: '/cart',
              name: 'cart',
              builder: (context, state) {
                if (state.extra != null) {
                  return BlocProvider.value(
                    value: AppProvidersAndRepos.cartBloc,
                    child: CartScreen(
                      cartItems: state.extra as List<CartItemModel>,
                    ),
                  );
                } else {
                  return BlocProvider.value(
                    value: AppProvidersAndRepos.cartBloc,
                    child: const CartScreen(),
                  );
                }
              },
              routes: [
                GoRoute(
                    path: 'check-out',
                    name: 'CheckOut',
                    builder: (context, state) {
                      final checkData = state.extra as Map<String, dynamic>;
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: AppProvidersAndRepos.addressBloc,
                          ),
                          BlocProvider.value(
                            value: AppProvidersAndRepos.orderBloc,
                          ),
                        ],
                        child: CheckOutScreen(
                          cartData: checkData['cartData'],
                          totalPrice: checkData['totalPrice'],
                        ),
                      );
                    })
              ]),
          GoRoute(
              path: '/payment-success',
              name: 'paymentSuccess',
              builder: (context, state) => SuccessScreen(
                  image: AppImages.successfulPaymentIcon,
                  title: 'Payment Success!',
                  subTitle: 'Your item will be shipped soon!',
                  onPressed: () {
                    context.goNamed('Home');
                  }))
        ],
      );
}
