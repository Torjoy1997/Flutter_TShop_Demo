import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/constants/colors.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/auth_info_detail.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;
  const VerifyEmailScreen({super.key, this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late Timer _timer;
  int counter = 60;
  bool disableButton = false;
  void resendEmail(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        _timer.cancel();
        context.read<AuthBloc>().add(AuthStatusChangeEvent(
            user: AuthUser(
                id: user.uid,
                email: user.email,
                emailVerified: user.emailVerified,
                name: user.displayName)));
      } else {
        if (counter != 0) {
          setState(() {
            counter -= 1;
            disableButton = true;
          });
        } else {
          setState(() {
            counter = 60;
            disableButton = false;
          });
          _timer.cancel();
        }
      }
    });
  }

  @override
  void initState() {
    context
        .read<AuthBloc>()
        .add(SendEmailVerificationEvent(email: widget.email));
    resendEmail(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserStatus) {
          if (state.authUserStatus != null &&
              state.authUserStatus!.emailVerified) {
            context.pushReplacement(
                Uri(path: '/signup/verify-success').toString());
          }
        }

        if (state is SendEmailVerificationFinished) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MessageBar.successSnackBar(
                title: 'Success',
                message: 'A verification mail sent to your email'),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ));
        } else if (state is EmailVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MessageBar.errorSnackBar(
                title: 'Oh! Snap', message: state.errorMessage),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(CupertinoIcons.clear))
              ],
            ),
            body: AuthInfoSection(
              email: widget.email,
              imageUrl: AppImages.deliveredEmailIllustration,
              title: AppDefineTexts.confirmEmail,
              isSubHead: true,
              subTitle: AppDefineTexts.confirmEmailSubTitle,
              buttonList: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state is AuthUserStatus) {
                        context.read<AuthBloc>().add(
                            AuthStatusChangeEvent(user: state.authUserStatus));
                      }
                    },
                    child: const Text(AppDefineTexts.tContinue),
                  ),
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: disableButton
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                const SendEmailVerificationEvent(
                                    email: 'islamtarek4@gmail.com'));
                            resendEmail(context);
                          },
                    child: const Text(AppDefineTexts.resendEmail),
                  ),
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwItems / 2,
                ),
                if (disableButton)
                  Text(
                    'Resend Email after $counter seconds',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: AppDefineColors.primary),
                  )
              ],
            ));
      },
    );
  }
}
