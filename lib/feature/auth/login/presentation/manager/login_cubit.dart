import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Dio/app_dio.dart';

import '../../../../layout/presentation/pages/HomeLayout.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  IconData passwordIcon = Icons.visibility_off;
  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    if(passwordVisible==true) {
      passwordIcon = Icons.visibility_off;
    } else {
      passwordIcon = Icons.visibility;
    }
    emit(ChangePasswordVisibilityState());
  }
  login({required context})async{
    emit(LoginLoadingState());
    try{
      await AppDioHelper.postData(url: 'https://grad-app-back-end.vercel.app/api/auth/login',
          data: {
            "email": emailController.text,
            "password": passwordController.text,
          }
      ).then( (response) {
        CacheHelper.savedata(key: 'email', value: emailController.text);

        CacheHelper.savedata(key: 'token', value: response.data['token'].toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout(),));
        print(response.data['token']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successfully'),
            backgroundColor: Colors.green,
          ),
        );
        emit(LoginSuccessState());
      })
      ;
    }catch(e){
      PanaraInfoDialog.show(
        color: Colors.red,
        context,
        message: "your email or password is wrong",
        buttonText: "try again",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: false, // optional parameter (default is true)
      );

      print(e.toString());
      emit(LoginErrorState());

    }

  }



  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
  

  
}
