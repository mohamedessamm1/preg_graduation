import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/model/user_model.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/home/presentation/pages/information.dart';
import 'package:pregnant_care/feature/home/presentation/pages/latest_studies.dart';
import 'package:pregnant_care/feature/home/presentation/pages/mental_health.dart';
import 'package:pregnant_care/feature/home/presentation/pages/pregnancy.dart';
import 'package:pregnant_care/feature/home/presentation/pages/vacattion.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/item_grid_widget.dart';

import '../../../../core/shared/constant.dart';
import '../widgets/item_grid_view_home.dart';
import 'activity.dart';
import 'health_tracker.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
              child: ConditionalBuilder(
            condition: state is! FetchMyDataLoadingState,
            builder: (context) {
              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: mainColor,
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
                            'mr/ ${accountModel?.username}',
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
                          Icons.search_rounded,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  15.ph,
                  if (HomeCubit.get(context).foundItem?['title'] == null) ...{
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
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: HomeCubit.get(context).gridItems.length,
                      itemBuilder: (context, index) {
                        final item = HomeCubit.get(context).gridItems[index];

                        return InkWell(
                          onTap: () {
                            if (item['screen'] != null) {
                              print(item['screen']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => item['screen']!));
                            }
                          },
                          child: ItemGridViewHome(
                            index:  index,
                            id:  item['id'].toString(),
                            title: item['title'],
                            image: item['image'],
                          ),
                        );
                      },
                    ),
                    35.ph
                  } else ...{
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ItemGridViewHome(
                          index:  index,

                          id:  HomeCubit.get(context).foundItem!['id'].toString(),
                          title: HomeCubit.get(context).foundItem?['title'],
                          image: HomeCubit.get(context).foundItem?['image'],
                        );
                      },
                    ),
                  }
                ],
              );
            },
            fallback: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                330.ph,
                Center(child: CircularProgressIndicator()),
              ],
            ),
          )),
        );
      },
    );
  }
}
