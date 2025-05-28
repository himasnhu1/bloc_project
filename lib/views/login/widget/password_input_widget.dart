import 'package:bloc_project/bloc/login_bloc.dart';
import 'package:bloc_project/views/login/widget/Input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInputWidget extends StatelessWidget {
  TextEditingController controller;
  FocusNode focusNode;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  bool obscureText;
  String hintText;
  bool isWidgetRequired;
  Widget widget;
  PasswordInputWidget(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.validator,
      required this.keyboardType,
      required this.obscureText,
      required this.hintText,
      required this.isWidgetRequired,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => previous.passwords != current.passwords,
      builder: (context, state) {
        print("Passwords");
        return TextFormField(
            focusNode: focusNode,
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChanged(password: value));
            },
            // onTap: onPressed,
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: buildInputDecoration(
                hintText: hintText,
                widget: widget,
                isWidgetRequired: isWidgetRequired));
      },
    );
  }
}
