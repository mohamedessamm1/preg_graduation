import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

import '../../../home/presentation/manager/home_cubit.dart';
import '../manager/home_layout_cubit.dart';

class HomeLayout extends StatelessWidget {
  final PageController pageController = PageController();

  HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: mainColor,
                  bottomNavigationBar: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    child: ConditionalBuilder(
                        condition: state is! FetchMyDataLoadingState,
                        builder: (context) => BottomNavigationBar(
                            selectedItemColor: Colors.white,
                            unselectedItemColor:  mainColor,
                            backgroundColor: mainColor,
                            items: [
                              BottomNavigationBarItem(
                                backgroundColor: Colors.brown,
                                icon: Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                backgroundColor: Colors.brown,
                                icon: Icon(Icons.favorite),
                                label: 'Favourite',
                              ),
                              BottomNavigationBarItem(
                                backgroundColor: Colors.brown,
                                icon: Icon(Icons.chat),
                                label: 'Chat',
                              ),
                              BottomNavigationBarItem(
                                backgroundColor: Colors.brown,
                                icon: Icon(Icons.person),
                                label: 'Profile',
                              ),
                            ],
                            currentIndex: HomeLayoutCubit.get(context).currentIndex,
                            onTap: (index) {
                              HomeLayoutCubit.get(context).changeNavBarIndex(index);
                            }),
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                        )
                    )
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
                    child: HomeLayoutCubit.get(context)
                        .screens[HomeLayoutCubit.get(context).currentIndex],
                  ));
            },
          );
  }
}
