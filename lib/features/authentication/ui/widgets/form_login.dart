import 'package:ecommerce_demo/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class FormOfLogin extends StatefulWidget {
  const FormOfLogin({
    super.key,
  });

  @override
  State<FormOfLogin> createState() => _FormOfLoginState();
}

class _FormOfLoginState extends State<FormOfLogin> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  bool hidePassword = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
            key: _formSignInKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDefineSizes.spaceBtwSections),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) => FormValidator.validateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: AppDefineTexts.email),
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) => FormValidator.validatePassword(value),
                    obscureText: hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key_outlined),
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
                    height: AppDefineSizes.spaceBtwInputFields / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          const Text(AppDefineTexts.rememberMe)
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            context.pushNamed('forget_password');
                          },
                          child: const Text(AppDefineTexts.forgetPassword))
                    ],
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formSignInKey.currentState!.validate()) {
                          return;
                        }
                        context.read<AuthBloc>().add(LoginEvent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()));
                      },
                      child: const Text(AppDefineTexts.signIn),
                    ),
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.push('/signup');
                      },
                      child: const Text(AppDefineTexts.createAccount),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
