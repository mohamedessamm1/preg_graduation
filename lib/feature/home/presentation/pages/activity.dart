import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  ActivitiesScreenState createState() => ActivitiesScreenState();
}

class ActivitiesScreenState extends State<ActivitiesScreen> {
  int selectedIndex = 0;
  final List<String> categories = ["Before", "During", "After"];

  final List<Map<String, String>> exercises0 = [
    {
      "title": "Cardio",
      "subtitle": "A high-energy workout that engages the entire body, improving stamina and heart health.",
      "image": "assets/images/cardio.png"
    },
    {
      "title": "Stretching",
      "subtitle": "Full-body stretches that enhance flexibility, reduce muscle stiffness, and prevent injuries.",
      "image": "assets/images/stretching.png"
    },
    {
      "title": "Yoga",
      "subtitle": "A blend of flexibility, breathing techniques, and relaxation to promote physical and mental well-being.",
      "image": "assets/images/yoga.png"
    },
    {
      "title": "Strength",
      "subtitle": "Resistance exercises designed to build muscle endurance, improve posture, and increase overall strength.",
      "image": "assets/images/exercise2.png"
    },
    {
      "title": "Leg Slides",
      "subtitle": "A core activation exercise that strengthens lower body muscles, improves balance, and enhances mobility.",
      "image": "assets/images/cardio.png"
    }
  ];
  final List<Map<String, String>> exercises1 = [
    {"title": "Walking", "subtitle": "A low-impact exercise that improves circulation and stamina.", "image": "assets/images/cardio.png"},
    {"title": "Prenatal Yoga", "subtitle": "Enhances flexibility, reduces stress, and improves breathing techniques.", "image": "assets/images/cardio.png"},
    {"title": "Pelvic Tilts", "subtitle": "Strengthens the lower back and helps with posture during pregnancy.", "image": "assets/images/cardio.png"},
    {"title": "Kegel Exercises", "subtitle": "Strengthens pelvic floor muscles, which helps during labor and postpartum recovery.", "image": "assets/images/cardio.png"},
    {"title": "Swimming", "subtitle": "A full-body workout that relieves joint pressure and improves endurance.", "image": "assets/images/cardio.png"},
    {"title": "Stationary Cycling", "subtitle": "A safe cardiovascular workout that maintains fitness levels.", "image": "assets/images/cardio.png"},
    {"title": "Leg Lifts", "subtitle": "Helps strengthen legs and improves blood circulation.", "image": "assets/images/cardio.png"},
    {"title": "Side-Lying Leg Raises", "subtitle": "Strengthens hips and improves balance.", "image": "assets/images/cardio.png"},
    {"title": "Prenatal Pilates", "subtitle": "Enhances core strength and stability, helping with posture and back pain.", "image": "assets/images/cardio.png"},
    {"title": "Arm and Shoulder Exercises", "subtitle": "Maintains upper body strength and reduces muscle tension.", "image": "assets/images/cardio.png"}
  ];
  final List<Map<String, String>> exercises2 = [
    {"title": "Postnatal Walking", "subtitle": "A gentle way to regain stamina and improve circulation.", "image": "assets/images/cardio.png"},
    {"title": "Pelvic Floor Exercises (Kegels)", "subtitle": "Strengthens pelvic muscles and helps in postpartum recovery.", "image": "assets/images/cardio.png"},
    {"title": "Gentle Yoga", "subtitle": "Improves flexibility and reduces stress while promoting relaxation.", "image": "assets/images/cardio.png"},
    {"title": "Deep Breathing with Abdominal Contraction", "subtitle": "Helps tone abdominal muscles and improve core strength.", "image": "assets/images/cardio.png"},
    {"title": "Pelvic Tilts", "subtitle": "Eases lower back pain and strengthens the core.", "image": "assets/images/cardio.png"},
    {"title": "Leg Slides", "subtitle": "Reactivates core muscles and improves lower body strength.", "image": "assets/images/cardio.png"},
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
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.brown : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: isSelected ? Colors.white : Colors.brown),
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
              Text("Exercises", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد العناصر في كل صف
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 0.8, // التحكم في أبعاد المربعات
                ),
                itemCount: selectedIndex==1 ? exercises1.length : 5,
                itemBuilder: (context, index) {
                if(selectedIndex==0){
                  return  _buildExerciseCard(

                    exercises0[index]["title"]!,
                    exercises0[index]["subtitle"]!,
                    exercises0[index]["image"]!,
                  );
                }
                if(selectedIndex==1){
                  return  _buildExerciseCard(

                    exercises1[index]["title"]!,
                    exercises1[index]["subtitle"]!,
                    exercises1[index]["image"]!,
                  );
                }
                if(selectedIndex==2){
                  return  _buildExerciseCard(

                    exercises2[index]["title"]!,
                    exercises2[index]["subtitle"]!,
                    exercises2[index]["image"]!,
                  );
                }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(String title, String subtitle, String imagePath) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, height: 100.h, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(maxLines: 2,title, style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
                Text(maxLines: 5,subtitle, style: TextStyle(fontSize: 14.sp, color: Colors.grey,overflow: TextOverflow.ellipsis

                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
