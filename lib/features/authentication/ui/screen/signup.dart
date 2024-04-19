import 'package:ecommerce_demo/core/common_widgets/divider_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/form_footer.dart';
import '../widgets/form_sign_up.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.read<AuthBloc>().add(SendEmailVerificationEvent(email: state.email));
          context.push(Uri(path: '/signup/verify-email',queryParameters: {'email': state.email}).toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MessageBar.successSnackBar(
                title: 'Verify mail', message: 'A verify email has been sent your mail. please verify your email'),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ));

        }


        if (state is SignUpFailure) {
          if(state.errorCode == 'email-already-in-use'){

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.errorSnackBar(
                  title: state.errorCode!, message: 'please verify your email'),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
            context.read<AuthBloc>().add(const SendEmailVerificationEvent());

            context.go(Uri(path: '/signup/verify-email',queryParameters: {'email': state.email}).toString());

          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.errorSnackBar(
                  title: 'Error', message: state.errorMessage),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
          }

        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                AppDefineTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              const FormOfSignUp(),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              TextBetweenDivider(
                  syMode: AppHelperFunctions.isDarkMode(context),
                  dividerText: AppDefineTexts.orSignUpWith),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              const FormOfFooter()
            ]),
          ),
        ),
      ),
    );
  }
}
