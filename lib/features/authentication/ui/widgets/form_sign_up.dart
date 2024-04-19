import 'package:ecommerce_demo/features/authentication/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../bloc/auth_bloc.dart';

class FormOfSignUp extends StatefulWidget {
  const FormOfSignUp({super.key});

  @override
  State<FormOfSignUp> createState() => _FormOfSignUpState();
}

class _FormOfSignUpState extends State<FormOfSignUp> {
  final _formSignUpKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _emailController = TextEditingController(),
      _phoneNoController = TextEditingController(),
      _passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
            key: _formSignUpKey,
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    //First && Last Name
                    child: TextFormField(
                      controller: _firstNameController,
                      validator: (value) =>
                          FormValidator.validateEmptyText('First Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppDefineTexts.firstName),
                    ),
                  ),
                  const SizedBox(
                    width: AppDefineSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (value) =>
                          FormValidator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppDefineTexts.lastName),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwInputFields,
              ),

              // Email
              TextFormField(
                controller: _emailController,
                validator: (value) => FormValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct),
                    labelText: AppDefineTexts.email),
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwInputFields,
              ),

              // Phone Number
              TextFormField(
                controller: _phoneNoController,
                validator: (value) => FormValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: AppDefineTexts.phoneNo),
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwInputFields,
              ),

              //password
              TextFormField(
                controller: _passwordController,
                validator: (value) => FormValidator.validatePassword(value),
                obscureText: hidePassword,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: AppDefineTexts.password,
                    suffixIcon: IconButton(
                      icon: hidePassword
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye),
                      onPressed: () => setState(() {
                        hidePassword = !hidePassword;
                      }),
                    )),
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),

              //button and other part
              Row(
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(value: true, onChanged: (value) {})),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${AppDefineTexts.iAgreeTo} ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: AppDefineTexts.privacyPolicy,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: AppHelperFunctions.isDarkMode(context)
                                  ? AppDefineColors.white
                                  : AppDefineColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  AppHelperFunctions.isDarkMode(context)
                                      ? AppDefineColors.white
                                      : AppDefineColors.primary,
                            )),
                    TextSpan(
                        text: ' ${AppDefineTexts.and} ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: AppDefineTexts.termsOfUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: AppHelperFunctions.isDarkMode(context)
                                  ? AppDefineColors.white
                                  : AppDefineColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  AppHelperFunctions.isDarkMode(context)
                                      ? AppDefineColors.white
                                      : AppDefineColors.primary,
                            )),
                  ]))
                ],
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formSignUpKey.currentState!.validate()) {
                      return;
                    }
                    context.read<AuthBloc>().add(SignUpEvent(
                      UserModel(firstName: _firstNameController.text.trim(),lastName: _lastNameController.text.trim(),email: _emailController.text.trim(),phoneNumber: _phoneNoController.text.trim(),password: _passwordController.text.trim(),profilePic: '')
                    ));
                  },
                  child: const Text(AppDefineTexts.createAccount),
                ),
              ),
            ]));
      },
    );
  }
}
