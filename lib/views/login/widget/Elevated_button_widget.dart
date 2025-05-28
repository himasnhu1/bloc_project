import 'package:bloc_project/bloc/login_bloc.dart';
import 'package:bloc_project/utils/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final formKey;
  const ElevatedButtonWidget({super.key, this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(listener: (context, state) {
      if (state.postApiStatus == PostApiStatus.error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
      }
      if (state.postApiStatus == PostApiStatus.success) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
      }
      if (state.postApiStatus == PostApiStatus.initial) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("Submitting.....")));
      }
    }, child: BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return ElevatedButton(
            child: Text('Sign In'),
            onPressed: () async {
              if (formKey.currentState.validate() == false) {
                // return null;
              } else {
                if (state.passwords.length < 4) {
                  print(state.passwords.length);
                  if (kDebugMode) {
                    print('Enter Password  greater then 6');
                  }
                } else {
                  context.read<LoginBloc>().add(LoginApi());
                }
              }
            });
      },
    ));
  }
}
