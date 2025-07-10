import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import '../../../home/presentation/widgets/item_grid_view_home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return HomeCubit.get(context).homeList.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      50.ph,
                      Lottie.asset('assets/lottie/empty.json',
                          repeat: true, width: 250.w, height: 250.h),
                      Text(
                        'No Favourite',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                : SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Favourite',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              HomeCubit.get(context).favoriteItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomeCubit.get(context)
                                              .favoriteItems![index]['screen']!,
                                    ));
                              },
                              child: ItemGridViewHome(
                                index: index,
                                id: 'fav',
                                title: HomeCubit.get(context)
                                    .favoriteItems?[index]["title"],
                                image: HomeCubit.get(context)
                                    .favoriteItems?[index]['image'],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
