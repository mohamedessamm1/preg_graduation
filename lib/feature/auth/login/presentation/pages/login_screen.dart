import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/core/shared/widget_shared/switch_login_signin_widget.dart';
import 'package:pregnant_care/feature/auth/login/presentation/manager/login_cubit.dart';
import 'package:pregnant_care/feature/auth/register/presentation/pages/register_screen.dart';

import '../../../../../core/shared/widget_shared/custom_button_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Text(
                'Login',
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
                    Image.asset('assets/images/logo.png',height: 200.h,),
                    10.ph,
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
                        hintText: 'Email',
                        borderColor: Colors.white,
                        controller: LoginCubit.get(context).emailController,
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
                        hintText: 'Password',
                        borderColor: Colors.white,
                        obscureText: LoginCubit.get(context).passwordVisible,
                        suffixIcon: LoginCubit.get(context).passwordIcon,
                        suffixTab: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        controller: LoginCubit.get(context).passwordController,
                        focusBorderColor: mainColor,
                        enabledBorderColor: mainColor),
                    100.ph,
                    state is LoginLoadingState
                        ? const CircularProgressIndicator():
                    customButton(onTap: () {
                      LoginCubit.get(context).login(context: context);
                    }, text: 'Login',color: Colors.brown),
                    15.ph,
                    switchLoginSignInWidget(onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));

                    }, currentScreen: 'login'),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
