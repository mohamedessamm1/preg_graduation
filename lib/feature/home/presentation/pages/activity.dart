import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  ActivitiesScreenState createState() => ActivitiesScreenState();
}

class ActivitiesScreenState extends State<ActivitiesScreen> {
  int selectedIndex = 0;
  final List<String> categories = ["During", "After"];

  final List<Map<String, String>> exercises0 = [
    {
      "title": "Abdominal exercises for pregnant women",
      "subtitle":
          "A high-energy workout that engages the entire body, improving stamina and heart health.",
      "image": "assets/images/cardio.png",
      "url": "https://youtu.be/yLNx1VShPRU?si=reSMotUhlglfjvLz"
    },
    {
      "title": "Squatting exercises to facilitate childbirth",
      "image": "assets/images/stretching.png",
      "url": "https://youtu.be/oZZzNn5DIqE?si=EjZtF0mn4uw09aWi"
    },
    {
      "title": "Exercises to strengthen and open the pelvis",
      "image": "assets/images/exercise2.png",
      "url": "https://youtu.be/UDK6p7B_Ids?si=aq13plSV6bgZsocR"
    },
    {
      "title": "Yoga exercises for pregnant women",
      "image": "assets/images/yoga.png",
      "url": "https://youtu.be/pP1SvfbrllM?si=bjxs7Hpw-zDtqtJn"
    },
    {
      "title": "Leg exercises for pregnant women",
      "image": "assets/images/cardio.png",
      "url": "https://youtu.be/Z3HZpckXLz4?si=u3vyeL42dfPu_kCt"
    }
  ];
  final List<Map<String, String>> exercises1 = [
    {
      "title": "Exercises to tighten the abdomen after childbirth",
      "image": "assets/images/cardio.png",
      "url": "https://youtu.be/wV5vYo6DQTY?si=kDx-nwDb1G-VRO3q"
    },
    {
      "title": "Flat stomach after cesarean section",
      "image": "assets/images/exercise2.png",
      "url": "https://youtu.be/NY5xseeuwKY?si=7vqr6SbS9jeYn0Sy"
    },
    {
      "title": "Balanced breathing exercise",
      "image": "assets/images/exercise2.png",
      "url": "https://youtu.be/ACW6Tmfm1Uk?si=nAVBYg7mrmf2pLmI"
    },
    {
      "title": "Muscle separation exercises for women after childbirth",
      "image": "assets/images/exercise2.png",
      "url": "https://youtu.be/bNTgK7wDNW4?si=L5Loezom1zphM_MU"
    },
    {
      "title": "Pilates to close muscle separation",
      "image": "assets/images/exercise2.png",
      "url": "https://youtu.be/U7ks_hAYF1o?si=P5HGlG0XPJQUuwBs"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ph,
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.black)),
                  SizedBox(width: 10.w),
                  Text(
                    "Activities",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Category Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(categories.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.brown : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person,
                              color: isSelected ? Colors.white : Colors.brown),
                          SizedBox(width: 5.w),
                          Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.brown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h),

              // Exercises Section (GridView)
              Text("Exercises",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // عدد العناصر في كل صف
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1, // التحكم في أبعاد المربعات
                ),
                itemCount: selectedIndex == 1 ? exercises1.length : 5,
                itemBuilder: (context, index) {
                  if (selectedIndex == 0) {
                    return _buildExerciseCard(
                      exercises0[index]["title"]!,
                      exercises0[index]["image"]!,
                      exercises0[index]["url"]!,
                    );
                  }
                  if (selectedIndex == 1) {
                    return _buildExerciseCard(
                      exercises1[index]["title"]!,
                      exercises1[index]["image"]!,
                      exercises1[index]["url"]!,
                    );
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(String title, String imagePath, String url) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath,
                  height: 220.h, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      maxLines: 2,
                      title,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
