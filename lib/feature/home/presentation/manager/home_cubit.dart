import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/shared/Cache/local_cache.dart';
import '../../../../core/shared/Dio/app_dio.dart';
import '../../../../core/shared/constant.dart';
import '../../../../core/shared/model/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  changeFav() {
    emit(FavoritePressState());
  }
  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
  Map<String, dynamic>? foundItem={};

  getSearch(){
    String searchTitle =
        "${searchController.text}"; // Change this to search for another item

    // Find item by title
     foundItem =
    homeList.firstWhere(
          (item) => item["title"] == searchTitle,
      orElse: () => {},
    );

    if (foundItem!.isNotEmpty) {
      print("Item found: $foundItem");
      print("Title: ${foundItem?['title']}");
      print("Status: ${foundItem?['status']}");
      print("Image Path: ${foundItem?['image']}");
      print("ID: ${foundItem?['id']}");
    } else {
      print(
          "Item with title '$searchTitle' not found!");
    }
    emit(SearchState());
  }
  Future<void> openUrl(String link) async {
    // Use WhatsApp Web URL
    final Uri url = Uri.parse(
       link );

    // Check if the URL can be launched
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch';
    }
  }
  fetchMyData()async{

    emit(FetchMyDataLoadingState());
    try{
      await AppDioHelper.getData(url: 'users/profile',token:"Bearer ${CacheHelper.getdata(key: 'TOKEN')}").then(
            (value) {
          accountModel = AccountModel.fromJson(value.data);
          print(accountModel?.username);
          print(accountModel?.username);
          print(accountModel?.username);
          print(accountModel?.username);
          emit(FetchMyDataSuccessState());
        },
      );
    }catch(e){
      print(e.toString());
      emit(FetchMyDataErrorState());
    }
  }
}
