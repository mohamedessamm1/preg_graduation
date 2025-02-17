import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

import '../../../home/presentation/widgets/item_grid_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: SizedBox(
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

              GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 15,
              ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: CacheHelper.getActiveDays().length,
                itemBuilder: (context, index) {
                  return ItemGridWidget(
                    title: CacheHelper.getActiveDays()[index]['title'],
                    image: CacheHelper.getActiveDays()[index]['image'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
