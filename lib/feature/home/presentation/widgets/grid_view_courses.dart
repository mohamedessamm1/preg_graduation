import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class GridViewCourses extends  StatelessWidget {
  var course;
  var courseName;

   GridViewCourses({super.key, required this.course,this.courseName});
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return                 Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(courseName,style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: Colors.white),),

            ],
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: course.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _launchURL(course[index]['url']),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(course[index]['image'], height: 80,errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/logo.png', height: 80);
                    },),
                  ),
                  SizedBox(height: 4),
                  Text(
                    course[index]['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );

  }
}
