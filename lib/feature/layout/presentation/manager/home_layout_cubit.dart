import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/chat_list.dart';
import 'package:pregnant_care/feature/favourite/presentation/pages/favourite_screen.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/home/presentation/pages/home_screen.dart';
import 'package:pregnant_care/feature/profile/presentation/pages/profile_screen.dart';

import '../../../chat/presentation/pages/mom_group.dart';
import '../pages/HomeLayout.dart';
part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());
  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }
  List screens = [
    HomeScreen(),
    FavouriteScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];


  }

