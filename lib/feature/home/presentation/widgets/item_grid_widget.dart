// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
// import 'package:pregnant_care/core/shared/extension/extencion.dart';
// import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
//
// import '../../../layout/presentation/manager/home_layout_cubit.dart';
//
// class ItemGridWidget extends StatelessWidget {
//   final String? image;
//   final String? title;
//   final String? toScreen;
//   const ItemGridWidget({super.key, this.image, this.title, this.toScreen});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.brown,
//                 spreadRadius: 0.5,
//                 blurRadius: 3,
//                 offset: Offset(0, 1), // changes position of shadow
//               ),
//             ],
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 colors: [
//                   Colors.white.withOpacity(0.0),
//                   Colors.white.withOpacity(0.0),
//                   Colors.grey.shade100,
//                 ],
//                 stops: [
//                   0.0,
//                   0.3,
//                   1.0,
//                 ]),
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 150.h,
//                 width: double.infinity,
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10.r),
//                     child: Image.asset(
//                       image!,
//                       fit: BoxFit.cover,
//                     )),
//               ),
//               10.ph,
//               Text(
//                 title!,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15.sp),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//           right: 10.w,
//           top: 10.h,
//           child: CacheHelper.getdata(key: title) == null
//               ? InkWell(
//             onTap: () {
//               HomeCubit.get(context).changeFav();
//             },
//             child: Icon(
//               Icons.favorite,
//               color: Colors.grey,
//               size: 35.w,
//             ),
//           )
//               : Lottie.asset('assets/lottie/fav.json',
//               repeat: false,
//               width: 35.w, height: 35.w),
//         )
//       ],
//     );
//   }
// }
