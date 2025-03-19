import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestStudiesScreen extends StatefulWidget {
  const LatestStudiesScreen({super.key});

  @override
  State<LatestStudiesScreen> createState() => _LatestStudiesScreenState();
}

class _LatestStudiesScreenState extends State<LatestStudiesScreen> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/image1.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 350.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 20.h),
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 160.h),
                    Text(
                      'Newborn Feeding Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest studies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildStudyCard(
                    'assets/images/image2.png', 'Baby Growth and Development'),
                SizedBox(height: 10.h),
                _buildStudyCard(
                  'assets/images/image2.png',
                  'Baby Growth and Development',
                  subtitle: 'Top tips to help your baby\'s development',
                ),
                if (isMore) ...[
                  SizedBox(height: 10.h),
                  _buildStudyCard('assets/images/image2.png',
                      'Baby Growth and Development'),
                  SizedBox(height: 10.h),
                  _buildStudyCard('assets/images/image2.png',
                      'Baby Growth and Development'),
                ],
                SizedBox(height: 20.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMore = !isMore;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 50),
                      child: Text(
                        isMore ? 'Less' : 'More',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyCard(String imagePath, String title, {String? subtitle}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(imagePath,
              width: double.infinity, height: 160.h, fit: BoxFit.cover),
          Container(
            width: double.infinity,
            height: 160.h,
            padding: EdgeInsets.all(10),
            color: Colors.black.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
