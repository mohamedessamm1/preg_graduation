import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

import 'consultation_doctor_Details.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC4A08E),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            25.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),),
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Doctor Appointment',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search For Doctor',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFE6D0C7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),


            SizedBox(height: 20.h),
            Text(
              'Top Doctors',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView(
                children: [
                  InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(

                      doctorEmail: 'dr2@gmail.com',
                      doctorName: 'ayman',
                      doctorSpeciality: 'Dental',
                    )));
                  }, child: _buildDoctorItem('Dr. ayman', 'Dental', 'assets/images/dr.png', true)),
                  InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
                      doctorEmail: 'dr3@gmail.com',
                      doctorName: 'ahmed adel',
                      doctorSpeciality: 'Brain',
                    )));
                  },child: _buildDoctorItem('Dr. ahmed adel', 'Brain', 'assets/images/dr.png', false)),

                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
                      doctorEmail: 'dr1@gmail.com',
                      doctorName: 'mohamed essam',
                      doctorSpeciality: 'Heart',
                    )));
                  },  child: _buildDoctorItem('Dr. mohamed essam', 'Heart', 'assets/images/dr.png', true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDoctorItem(String name, String specialty, String image, bool isOnline) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Color(0xFFE6D0C7),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: AssetImage(image),
              ),
              if (isOnline)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 6.r,
                    backgroundColor: Colors.green,
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                specialty,
                style: TextStyle(fontSize: 14.sp, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
