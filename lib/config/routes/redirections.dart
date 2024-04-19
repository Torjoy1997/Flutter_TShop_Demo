import 'package:ecommerce_demo/config/local_store/local_storage.dart';
import 'package:firebase_authentication_repository/authentication_repository.dart';

import '../../utils/constants/enums.dart';

class AppRedirectRepository {
  final AuthRepository _authRepository = AuthRepository();

  AuthenticationStatus setAppStatus() {
    final user = _authRepository.getCurrentUser();
    AuthenticationStatus authenticationStatus =
        AuthenticationStatus.unAuthenticated;
    if (user != null) {
      authenticationStatus = user.emailVerified
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.authenticatedNotVerified;
    }

    return authenticationStatus;
  }

  String? get getLoginRedirectPath {
    if (setAppStatus() == AuthenticationStatus.authenticated) {
      return '/home';
    } else if (setAppStatus() ==
        AuthenticationStatus.authenticatedNotVerified) {
      return '/signup/verify-email';
    } else {
      return null;
    }
  }

  String? get onBoardRedirectPath {
    if (LocalStorageService.getBool('onBoardFinish') != null &&
        LocalStorageService.getBool('onBoardFinish')!) {
      return setAppStatus() == AuthenticationStatus.authenticated
          ? '/home'
          : setAppStatus() == AuthenticationStatus.authenticatedNotVerified
              ? '/signup/verify-email'
              : '/login';
    } else {
      return null;
    }
  }
}
