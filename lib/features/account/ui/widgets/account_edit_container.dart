import 'package:ecommerce_demo/features/account/bloc/account_bloc.dart';
import 'package:ecommerce_demo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class AccountEditContainer extends StatefulWidget {
  const AccountEditContainer(
      {super.key,
      required this.title,
      required this.value,
      this.onPressed,
      this.formValidator});
  final String title;
  final String value;
  final Function(String?)? formValidator;
  final VoidCallback? onPressed;

  @override
  State<AccountEditContainer> createState() => _AccountEditContainerState();
}

class _AccountEditContainerState extends State<AccountEditContainer> {
  bool editable = false;
  final _formFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 4,
          child: editable
              ? TextFormField(
                  key: _formFieldKey,
                  controller: _editingController,
                  validator: widget.formValidator != null
                      ? (value) => widget.formValidator!(value)
                      : null,
                  style: const TextStyle(
                      fontSize: 12, height: 1, color: AppDefineColors.primary),
                  decoration: const InputDecoration().applyDefaults(
                      Theme.of(context).inputDecorationTheme.copyWith(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: AppDefineColors.darkGrey,
                              width: 0.5,
                            )),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppDefineColors.darkGrey, width: 1)),
                          )))
              : Text(
                  widget.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
        if (widget.title != 'Email' && widget.title != 'User_ID')
          Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  editable = !editable;
                });
                if (!editable) {
                  if (_formFieldKey.currentState != null &&
                      !_formFieldKey.currentState!.validate()) {

                    return;
                  }
                  context.read<AccountBloc>().add(UserDataUpdateEvent(
                          userJson: {
                            AppHelperFunctions.camelCase(widget.title):
                                _editingController.text.trim()
                          }));
                }
              },
              icon: editable
                  ? const Icon(Iconsax.tick_square)
                  : const Icon(Icons.edit_outlined),
            ),
          ),
        if (widget.title == 'Email' || widget.title == 'User_ID')
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.size),
            ),
          ),
      ],
    );
  }
}
