import 'package:ecommerce_demo/features/authentication/ui/widgets/form_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../core/common_widgets/divider_text.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';


import '../../../../utils/helpers/helper_functions.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/form_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.goNamed('Home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.errorSnackBar(
                  title: 'Oh! Snap', message: state.errorMessage),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: AppDefineSizes.appBarHeight,
                left: AppDefineSizes.defaultSpace,
                bottom: AppDefineSizes.defaultSpace,
                right: AppDefineSizes.defaultSpace),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        height: 150,
                        image: AssetImage(mode
                            ? AppImages.lightAppLogo
                            : AppImages.darkAppLogo)),
                    Text(
                      AppDefineTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: AppDefineSizes.sm,
                    ),
                    Text(
                      AppDefineTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                // Login Form
                const FormOfLogin(),

                //Divider
                TextBetweenDivider(
                  syMode: mode,
                  dividerText: AppDefineTexts.orSignInWith,
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwSections,
                ),

                //Footer
                const FormOfFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
