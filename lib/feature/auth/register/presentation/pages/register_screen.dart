import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/core/shared/widget_shared/switch_login_signin_widget.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';
import 'package:pregnant_care/feature/auth/register/presentation/manager/register_cubit.dart';

import '../../../../../core/shared/widget_shared/custom_button_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            var email = RegisterCubit.get(context).emailController.text.toString();

            return Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Text(
                'sign up ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              centerTitle: true,
            ),
            backgroundColor: mainColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.ph,
                    Row(
                      children: [
                        Text(
                          'Please enter your username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ],
                    ),
                    5.ph,
                    CustomTextField(
                        fillColor: Colors.white,
                        prefixIconColor: mainColor,
                        suffixIconColor: mainColor,
                        hintText: 'Username',
                        borderColor: Colors.white,
                        controller: RegisterCubit.get(context).usernameController,
                        focusBorderColor: mainColor,
                        enabledBorderColor: mainColor),
                    30.ph,
                    Row(
                      children: [
                        Text(
                          'Please enter your email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ],
                    ),
                    5.ph,
                    CustomTextField(
                        fillColor: Colors.white,
                        prefixIconColor: mainColor,
                        suffixIconColor: mainColor,
                        hintText: '######@gmail.com',
                        borderColor: Colors.white,

                        controller:
                            RegisterCubit.get(context).emailController,
                        focusBorderColor: mainColor,
                        enabledBorderColor: mainColor),
                    30.ph,
                    Row(
                      children: [
                        Text(
                          'Please enter your password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ],
                    ),
                    5.ph,
                    CustomTextField(
                        fillColor: Colors.white,
                        prefixIconColor: mainColor,
                        suffixIconColor: mainColor,
                        hintText: '#########',
                        borderColor: Colors.white,
                        suffixTab: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        } ,
                        obscureText:  RegisterCubit.get(context).passwordVisible,
                        suffixIcon:  RegisterCubit.get(context).passwordIcon,
                        controller:
                            RegisterCubit.get(context).passwordController,
                        focusBorderColor: mainColor,
                        enabledBorderColor: mainColor),
                    30.ph,
                    Row(
                      children: [
                        Text(
                          'Please enter your phone number',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ],
                    ),
                    5.ph,
                    CustomTextField(
                        fillColor: Colors.white,
                        prefixIconColor: mainColor,
                        suffixIconColor: mainColor,
                        hintText: '01#########',
                        borderColor: Colors.white,
                        controller:
                        RegisterCubit.get(context).numberController,
                        focusBorderColor: mainColor,
                        enabledBorderColor: mainColor),
                    100.ph,
                    state is RegisterLoadingState? CircularProgressIndicator(color: Colors.brown,):
                    customButton(
                        onTap: () {
                          RegisterCubit.get(context).register(context: context);

                        }, text: 'Register', color: Colors.brown),
                    15.ph,
                    switchLoginSignInWidget(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        currentScreen: ''),
                  ],
                ),
              ),
            ),
          );
          },
        ));
  }
}
