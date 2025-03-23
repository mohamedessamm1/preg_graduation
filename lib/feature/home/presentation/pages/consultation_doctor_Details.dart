import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/chat_screen2.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsScreen extends StatefulWidget {
  String doctorName;
  String doctorSpeciality;
  String doctorEmail;

  DoctorDetailsScreen(
      {super.key,
      required this.doctorName,
      required this.doctorSpeciality,
      required this.doctorEmail});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState(
      doctorName: doctorName,
      doctorSpeciality: doctorSpeciality,
      doctorEmail: doctorEmail);
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  String doctorName;
  String doctorSpeciality;
  String doctorEmail;
  _DoctorDetailsScreenState({
    required this.doctorName,
    required this.doctorSpeciality,
    required this.doctorEmail,
  });
  int selectedDayIndex = 0;
  String? selectedTime;

  List<String> getNext7Days() {
    return List.generate(7, (index) {
      DateTime date = DateTime.now().add(Duration(days: index));
      return DateFormat('EEE dd').format(date);
    });
  }

  List<String> availableTimes = [
    '03:00 pm',
    '02:15 pm',
    '3:13 pm',
    '4:50 pm',
    '2:30 pm'
  ];

  @override
  Widget build(BuildContext context) {
    List<String> next7Days = getNext7Days();
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: AssetImage('assets/images/dr.png'),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Dr. ${doctorName}',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '${doctorSpeciality}',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white70),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.call, color: Colors.white),
                            onPressed: () async {

                              final Uri phoneUri = Uri(scheme: 'tel', path: '01065661450');
                              if (await canLaunchUrl(phoneUri)) {
                              await launchUrl(phoneUri);
                              } else {
                              throw 'Could not launch $phoneUri';
                              }

                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.video_call, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.mark_unread_chat_alt_outlined, color: Colors.white),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsScreen2(
                                email: doctorEmail,
                                name: doctorName,
                                uid: '',
                              )));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Highly experienced and qualified medical professionals dedicated to providing exceptional patient care. Our doctors specialize in various fields, ensuring the best treatment and consultation services for all your healthcare needs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Select a Date',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              Wrap(
                children: next7Days.map((day) {
                  int index = next7Days.indexOf(day);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: _buildDayItem(day, index == selectedDayIndex),
                  );
                }).toList(),
              ),
              SizedBox(height: 15.h),
              Text(
                'Select a Time',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: availableTimes.map((time) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: _buildTimeSlot(time, selectedTime == time),
                  );
                }).toList(),
              ),
              SizedBox(height: 100.h),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                  onPressed: () {
                    if (selectedTime != null) {
                      HomeCubit.get(context).sendMessageUser(
                        context: context,
                          date: DateTime.now(),
                          text: 'Appointment booked on ${next7Days[selectedDayIndex]} at $selectedTime',
                          sender: CacheHelper.getdata(key: 'email'),
                          receiverEmail: doctorEmail.toString(),
                          );
                    } else {
                      print('Please select a time slot.');
                    }
                  },
                  child: Text(
                    'Book An Appointment',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          day,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        time,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.orange),
      ),
    );
  }
}
