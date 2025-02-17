import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/home/presentation/pages/information.dart';
import 'package:pregnant_care/feature/home/presentation/pages/pregnancy.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/item_grid_widget.dart';

import '../../../../core/shared/constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: mainColor,
            body: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: Colors.white,
                      ),
                      15.pw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.sp),
                          ),
                          Text(
                            'mr/ salma',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  15.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 330.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: CustomTextField(
                              controller:
                                  HomeCubit.get(context).searchController,
                              onChanged: (value) {
HomeCubit.get(context).getSearch();
                              },
                              hintText: 'Search',
                              prefixIcon: Icons.search,
                              prefixIconColor: mainColor,
                              suffixIconColor: mainColor,
                              fillColor: Colors.white,
                              borderColor: Colors.white,
                              focusBorderColor: Colors.white,
                              enabledBorderColor: Colors.white)),
                      Spacer(),
                      Container(
                        width: 70.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.filter_list_rounded,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  15.ph,
                 if(HomeCubit.get(context).foundItem?['title']==null)...{
                   Image.asset('assets/images/crousal.png'),
                   30.ph,
                   Row(
                     children: [
                       Text(
                         'Categories',
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 18.sp,
                             fontWeight: FontWeight.bold),
                       ),
                     ],
                   ),
                   GridView(
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 20,
                         mainAxisSpacing: 15,
                       ),
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       children: [
                         InkWell(
                           onTap: () {
                             Navigator.push(context,MaterialPageRoute(builder: (context) => BabyCareScreen(),));
                           },
                           child: ItemGridWidget(
                             title: 'information',
                             image: 'assets/images/information.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => PregnancyScreen(),));

          },
                           child: ItemGridWidget(
                             title: 'pregnancy',
                             image: 'assets/images/preg.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'activate',
                             image: 'assets/images/activate.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'consultation',
                             image: 'assets/images/consultation.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'course',
                             image: 'assets/images/course.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'health',
                             image: 'assets/images/health.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'mental',
                             image: 'assets/images/mental.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'reminder',
                             image: 'assets/images/reminder.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'latest',
                             image: 'assets/images/latest.png',
                           ),
                         ),
                         InkWell(
                           onTap: () {},
                           child: ItemGridWidget(
                             title: 'community',
                             image: 'assets/images/community.png',
                           ),
                         ),
                       ]),
                   35.ph
                 }else...{


                   GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 20,
                     mainAxisSpacing: 15,
                   ),
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: 1,
                     itemBuilder: (context, index) {
                       return ItemGridWidget(
                         title: HomeCubit.get(context).foundItem?['title'],
                         image: HomeCubit.get(context).foundItem?['image'],
                       );
                     },
                   ),
                 }

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
