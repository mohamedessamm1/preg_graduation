import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pregnant_care/feature/chat/model/models/message_model.dart';
import 'package:pregnant_care/feature/home/presentation/pages/community.dart';
import 'package:pregnant_care/feature/home/presentation/pages/consultation.dart';
import 'package:pregnant_care/feature/home/presentation/pages/courses.dart';
import 'package:pregnant_care/feature/home/presentation/pages/health_tracker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/shared/Cache/local_cache.dart';
import '../../../../core/shared/Dio/app_dio.dart';
import '../../../../core/shared/constant.dart';
import '../../../../core/shared/model/user_model.dart';
import '../pages/activity.dart';
import '../pages/information.dart';
import '../pages/latest_studies.dart';
import '../pages/mental_health.dart';
import '../pages/pregnancy.dart';
import '../pages/vacattion.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  Set<String> homeList = {};
  List<Map<String, dynamic>>? favoriteItems;

   changeFav(String id) {
    print(homeList);

    homeList.contains(id.toString()) ? homeList.remove(id) : homeList.add(id);

    favoriteItems = gridItems.where((item) {
      return homeList.contains(item['id'].toString());
    }).toList();


    emit(FavoritePressState());
  }



  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
  Map<dynamic, dynamic>? foundItem={};

  getSearch(){
    String searchTitle =
        "${searchController.text}"; // Change this to search for another item

    // Find item by title
     foundItem =
         gridItems.firstWhere(
          (item) => item["title"] == searchTitle,
      orElse: () => {},
    );

    if (foundItem!.isNotEmpty) {
      print("Item found: $foundItem");
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



  List<Map<String, dynamic>> gridItems = [
    {
      'id': 1,
      'title': 'Information',
      'image': 'assets/images/information.png',
      'screen': BabyCareScreen(),
    },
    {
      'id': 2,
      'title': 'Pregnancy',
      'image': 'assets/images/preg.png',
      'screen': PregnancyScreen(),
    },
    {
      'id': 3,
      'title': 'Activate',
      'image': 'assets/images/activate.png',
      'screen': ActivitiesScreen(),
    },
    {
      'id': 4,
      'title': 'Consultation',
      'image': 'assets/images/consultation.png',
      'screen': ConsultationScreen(),
    },
    {
      'id': 5,
      'title': 'Course',
      'image': 'assets/images/course.png',
      'screen': CoursesScreen(),
    },
    {
      'id': 6,
      'title': 'Health',
      'image': 'assets/images/health.png',
      'screen': HealthTrackerScreen(),
    },
    {
      'id': 7,
      'title': 'Mental',
      'image': 'assets/images/mental.png',
      'screen': MentalHealthScreen(),
    },
    {
      'id': 8,
      'title': 'Vacation',
      'image': 'assets/images/reminder.png',
      'screen': VacattionScreen(),
    },
    {
      'id': 9,
      'title': 'Latest',
      'image': 'assets/images/latest.png',
      'screen': LatestStudiesScreen(),
    },
    {
      'id': 10,
      'title': 'Community',
      'image': 'assets/images/community.png',
      'screen': CommunityScreen(),
    },
  ];

  getMyDataFireStore() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getdata(key: 'TOKEN').toString())
        .get()
        .then((value) {
      print(CacheHelper.getdata(key: 'TOKEN').toString());
      print(value.data());
    });
  }
  var courses ;
  getCourses() async {
    AppDioHelper.getData(url: 'posts?page=1&limit=10&category=Courses').then(
      (value) {
        courses =value.data;
        print(value.data['groupedPosts']['Childhood'][1]['title']);

      },
    ).catchError(
      (error) {
        print(error.toString());
      },
    );
  }
  sendMessageUser(
      {required date,
        required text,
        required context,
        required sender,
        required receiverEmail,
        }) async {
    MessageModel messageModel =
    MessageModel(dateTime: date.toString(), sender: sender, text: text);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getdata(key: 'email').toString())
        .collection('chat')
        .doc(receiverEmail)
        .collection('message')
        .add(messageModel.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverEmail)
        .collection('chat')
        .doc(CacheHelper.getdata(key: 'email').toString())
        .collection('message')
        .add(messageModel.toJson())
        .then((value) async {
 Navigator.pop(context);
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You Have Booked Successfully'),backgroundColor: Colors.green,));

      emit(SuccessSendMessageState());
    }).catchError((Error) {
      emit(ErrorSendMessageState());
    });
  }

}
