/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

/// Switch of Custom Brand-Text-Size Widget
enum TexAppDefineSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered }

enum ConnectionType { wifi, mobile, none }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}

enum AutoCompleteType { product, brand }

enum AuthenticationStatus {
  authenticated,
  authenticatedNotVerified,
  unAuthenticated
}

enum ProductType { single, variable }

enum RoutePath {
  home(path: '/home'),
  store(path: '/store'),
  wishList(path: '/wishList'),
  account(path: '/account'),
  login(path: '/login'),
  signUp(path: '/sign_up');

  const RoutePath({required this.path});
  final String path;
}
