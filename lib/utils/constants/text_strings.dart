import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

/// This class contains all the App Text in String formats.
class AppDefineTexts {
  // -- GLOBAL Texts
  static const String and = "and";
  static const String skip = "Skip";
  static const String done = "Done";
  static const String submit = "Submit";
  static const String appName = "T-Store";
  static const String tContinue = "Continue";

  // -- OnBoarding Texts
  static const String onBoardingTitle1 = "Choose your product";
  static const String onBoardingTitle2 = "Select Payment Method";
  static const String onBoardingTitle3 = "Deliver at your door step";

  static const String onBoardingSubTitle1 =
      "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!";
  static const String onBoardingSubTitle2 =
      "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!";
  static const String onBoardingSubTitle3 =
      "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!";

  // -- Authentication Forms
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "E-Mail";
  static const String password = "Password";
  static const String newPassword = "New Password";
  static const String username = "Username";
  static const String phoneNo = "Phone Number";
  static const String rememberMe = "Remember Me";
  static const String forgetPassword = "Forget Password?";
  static const String signIn = "Sign In";
  static const String createAccount = "Create Account";
  static const String orSignInWith = "or sign in with";
  static const String orSignUpWith = "or sign up with";
  static const String iAgreeTo = "I agree to";
  static const String privacyPolicy = "Privacy Policy";
  static const String termsOfUse = "Terms of use";
  static const String verificationCode = "verificationCode";
  static const String resendEmail = "Resend Email";
  static const String resendEmailIn = "Resend email in";

  // -- Authentication Headings
  static const String loginTitle = "Welcome back,";
  static const String loginSubTitle =
      "Discover Limitless Choices and Unmatched Convenience.";
  static const String signupTitle = "Let’s create your account";
  static const String forgetPasswordTitle = "Forget password";
  static const String forgetPasswordSubTitle =
      "Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.";
  static const String changeYourPasswordTitle = "Password Reset Email Sent";
  static const String changeYourPasswordSubTitle =
      "Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.";
  static const String confirmEmail = "Verify your email address!";
  static const String confirmEmailSubTitle =
      "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.";
  static const String emailNotReceivedMessage =
      "Didn’t get the email? Check your junk/spam or resend it.";
  static const String yourAccountCreatedTitle =
      "Your account successfully created!";
  static const String yourAccountCreatedSubTitle =
      "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!";

  // -- Product
  static const String popularProducts = "Popular Products";

  // -- Home
  static const String homeAppbarTitle = "Good day for shopping";
  static const String homeAppbarSubTitle = "Tarek Flutter E-commerce App";

  static List<Map<String, dynamic>> settingList = [
    {
      'icon': Iconsax.safe_home,
      'title': 'My Address',
      'subTitle': 'set Your delivery Address',
      'onTap': (BuildContext context) {
        context.pushNamed('Address');
      }
    },
    {
      'icon': Iconsax.shopping_cart,
      'title': 'My Cart',
      'subTitle': 'Add, remove products and move to checkout',
      'onTap': (BuildContext context) {
        context.pushNamed(
          'cart',
        );
      }
    },
    {
      'icon': Iconsax.bag_tick,
      'title': 'My Orders',
      'subTitle': 'In-progress and Completed Orders',
      'onTap': (BuildContext context) {
        context.pushNamed('Order');
      }
    },
    {
      'icon': Iconsax.bank,
      'title': 'Bank Account',
      'subTitle': 'Withdraw balance to registered bank account',
      'onTap': (BuildContext context) {}
    },
    {
      'icon': Iconsax.discount_shape,
      'title': 'My Coupons',
      'subTitle': 'List of all the discounted coupons',
      'onTap': (BuildContext context) {}
    },
    {
      'icon': Iconsax.notification,
      'title': 'Notifications',
      'subTitle': 'set any kind of notification message',
      'onTap': (BuildContext context) {}
    },
    {
      'icon': Iconsax.security_card,
      'title': 'Account Privacy',
      'subTitle': 'Manage data usage and connected accounts',
      'onTap': (BuildContext context) {}
    }
  ];

  static List<Map<String, dynamic>> settingListWithToggle = [
    {
      'icon': Iconsax.location,
      'title': 'Geolocation',
      'subTitle': 'set recommendation based on location',
      'trailing': Switch(value: true, onChanged: (value) {})
    },
    {
      'icon': Iconsax.security_user,
      'title': 'Safe Mode',
      'subTitle': 'Search result is safe for all ages',
      'trailing': Switch(value: false, onChanged: (value) {})
    },
    {
      'icon': Iconsax.image,
      'title': 'HD Image Quality',
      'subTitle': 'Set image quality to be seen',
      'trailing': Switch(value: false, onChanged: (value) {})
    },
  ];
}
