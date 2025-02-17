import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';




class BabyCareScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Breastfeeding', 'image': 'assets/images/breastFeeding.png'},
    {'title': 'Sleeping', 'image': 'assets/images/sleeping.png'},
    {'title': 'Growth', 'image': 'assets/images/growth.png'},
    {'title': 'Feeding', 'image': 'assets/images/feeding.png'},
    {'title': 'Diaper', 'image': 'assets/images/diaper.png'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 220.h,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 100),
                    Text(
                      'Baby Care',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                    onTap: () {},
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
