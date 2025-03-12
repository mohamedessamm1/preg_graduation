import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:pregnant_care/core/shared/Dio/app_dio.dart';
import 'package:pregnant_care/feature/auth/login/presentation/manager/login_cubit.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';

import '../../../../../core/shared/Cache/local_cache.dart';
import '../../../../layout/presentation/pages/HomeLayout.dart';
import '../../data/models/create_user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController numberController = TextEditingController();


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
  
  register({required BuildContext context}) async{
    emit(RegisterLoadingState());
    try {
      await AppDioHelper.postData(url: "auth/register",data: {

        "email": emailController.text,
        "password": passwordController.text,
        "username": usernameController.text,
      }).then(
        (value) {
          CacheHelper.savedata(key: 'email', value: emailController.text);
          CacheHelper.savedata(key: 'TOKEN', value: value.data['token'].toString());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
          print(value.data['TOKEN'].toString());
          createUser(
              password: passwordController.text,
              email: emailController.text,
              context: context,
              uid: value.data['TOKEN'].toString(),
              name: usernameController.text
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login successfully'),
              backgroundColor: Colors.green,
            ),
          );
          emit(RegisterSuccessState());

        },
      );
    }catch(e) {
      PanaraInfoDialog.show(
        color: Colors.red,
        context,
        message: "your email or username is already exist",
        buttonText: "try again",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: false, // optional parameter (default is true)
      );

      emit(RegisterErrorState());
    }
    
  }
  
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    numberController.dispose();
    return super.close();
  }


  createUser(
      {
        required String password,
        required String email,
        required context,
        required uid,
        required String name}) {
    CreateUserModel createUserModel = CreateUserModel(
      name: name,
      email: email,
      password: password,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid.toString())
        .set(createUserModel.tojson())
        .then((value) {});

  }
}
