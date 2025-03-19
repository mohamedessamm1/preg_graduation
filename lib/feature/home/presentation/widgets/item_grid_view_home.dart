import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

import '../manager/home_cubit.dart';

class ItemGridViewHome extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  final int index;

  const ItemGridViewHome(
      {Key? key,
      required this.title,
      required this.image,
      required this.id,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.brown,
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.0),
                  Colors.grey.shade100,
                ],
                stops: [
                  0.0,
                  0.3,
                  1.0,
                ]),
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    )),
              ),
              10.ph,
              Text(
                title!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp),
              )
            ],
          ),
        ),
        if(id =='fav')...{
          SizedBox()
        }else...{        Positioned(
            right: 10.w,
            top: 10.h,
            child: InkWell(
              onTap: () async {
                await HomeCubit.get(context).changeFav(id.toString());
              },
              child: HomeCubit.get(context).homeList.contains(id.toString())?Lottie.asset('assets/lottie/fav.json',
                  repeat: false, width: 35.w, height: 35.w): Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 35.w,
              ),
            ))
        }
      ],
    );
  }
}
