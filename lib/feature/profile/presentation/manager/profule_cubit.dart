import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Dio/app_dio.dart';
import 'package:http/http.dart' as http;
import 'package:pregnant_care/feature/home/presentation/pages/home_screen.dart';
import 'package:pregnant_care/feature/layout/presentation/manager/home_layout_cubit.dart';
import 'package:pregnant_care/feature/layout/presentation/pages/HomeLayout.dart';

import '../../../../core/shared/constant.dart';
import '../../../../core/shared/model/user_model.dart';

part 'profule_state.dart';

class ProfuleCubit extends Cubit<ProfuleState> {
  ProfuleCubit() : super(ProfuleInitial());
  static ProfuleCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  fetchMyData() async {
    emit(FetchMyDataLoadingState());
    try {
      await AppDioHelper.getData(
              url: 'users/profile',
              token: "Bearer ${CacheHelper.getdata(key: 'TOKEN')}")
          .then(
        (value) {
          accountModel = AccountModel.fromJson(value.data);
          print(accountModel?.username);
          print(accountModel?.username);
          print(accountModel?.username);
          print(accountModel?.username);
          emit(FetchMyDataSuccessState());
        },
      );
    } catch (e) {
      print(e.toString());
      emit(FetchMyDataErrorState());
    }
  }

  editProfile({context}) {
    emit(LoadingEditProfileState());

    try {
      AppDioHelper.putData(
        url: 'users/profile',
        token: 'Bearer ${CacheHelper.getdata(key: 'TOKEN').toString()}',
        data: {
          'username': nameController.text,
          'email': emailController.text,
        },
      ).then((value) {
        print(value);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.data['message'])));
        emit(SuccessEditProfileState());
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  Future<void> updateUser({required context}) async {
    emit(LoadingEditPassProfileState()); // Set loading state

    try {
      final url = Uri.parse(
          "https://grad-app-back-end-v2.vercel.app/api/users/change-password"); // Replace with real API

      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer ${CacheHelper.getdata(key: 'TOKEN')}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "oldPassword": oldPasswordController.text,
          "newPassword": newPasswordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLayout(),
            ));

        emit(SuccessEditProfileState());
      } else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
          backgroundColor: Colors.red,
        ));

        emit(FailureEditProfileState());
        print("get response:${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('something went wrong try again'),
        backgroundColor: Colors.red,
      ));

      print(e);
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    oldPasswordController.dispose();
    return super.close();
  }
}
