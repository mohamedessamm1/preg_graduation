import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/home/presentation/pages/breastfeeding_screen.dart';
import 'package:pregnant_care/feature/home/presentation/pages/diaper.dart';
import 'package:pregnant_care/feature/home/presentation/pages/growth_screen.dart';
import 'package:pregnant_care/feature/home/presentation/pages/sleeping_screen.dart';

import 'baby_eat.dart';




class BabyCareScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Breastfeeding', 'image': 'assets/images/breastFeeding.png','screen':BreastfeedingScreen()},
    {'title': 'Sleeping', 'image': 'assets/images/sleeping.png','screen':SleepingScreen()},
    {'title': 'Growth', 'image': 'assets/images/growth.png','screen':GrowthScreen()},
    {'title': 'Feeding', 'image': 'assets/images/feeding.png','screen':BabyEatScreen()},
    {'title': 'Diaper', 'image': 'assets/images/diaper.png','screen':DiaperScreen()},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text('Baby Care',),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,

      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => categories[index]['screen'],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.asset(
                              height: 140.h,
                              categories[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          10.ph,
                          Text(
                            categories[index]['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
