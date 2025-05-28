import 'package:bloc_project/bloc/login_bloc.dart';
import 'package:bloc_project/model/user/user_model.dart';
import 'package:bloc_project/utils/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserModel userModel = UserModel();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  final _formLogin = GlobalKey<FormState>();
  bool obscurePassword = true;
  late LoginBloc _loginBloc;
  @override
  void initState() {
    


    // emailController.text ='eve.holt@reqres.in';
    // passwordController.text ='1234567';

       emailController.text ='Monu8273@gmail.com"';
     passwordController.text ='1234567';

    _loginBloc = LoginBloc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: BlocProvider(
          create: (context) => _loginBloc,
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formLogin,
                child: Column(children: [
                  10.heightBox,

                  ///Form fill Section
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Sign In "),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Enter your email address and passwords to Sign in !"),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Email textfield
                  EmailInputWidget(
                      controller: emailController,
                      focusNode: focusNodeEmail,
                      obscureText: false,
                      hintText: "Enter Email",
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        if (!Validation.emailValidator(value)) {
                          return 'Please enter Valid Email';
                        }
                        return null;
                      },
                      widget: Container(),
                      isWidgetRequired: false,
                      keyboardType: TextInputType.text),
                  10.heightBox,

                  ///passwords textfield
                  PasswordInputWidget(
                      controller: passwordController,
                      focusNode: focusNodePassword,
                      obscureText: true,
                      hintText: "Enter Password",
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        if (value.length < 6) {
                          return 'Please enter  Password  greater then 6';
                        }
                        return null;
                      },
                      isWidgetRequired: true,
                      widget: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword; // Toggle password visibility
                          });
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color:
                              Colors.grey, // Choose your preferred icon color
                        ),
                      ),
                      keyboardType: TextInputType.text),

                  const SizedBox(height: 30),

                  ///Elevated Button
                  ElevatedButtonWidget(formKey: _formLogin)
                ]),
              ),
            )),
          ),
        )));
  }
}
