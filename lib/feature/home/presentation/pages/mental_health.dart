import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  MentalHealthScreenState createState() => MentalHealthScreenState();
}

class MentalHealthScreenState extends State<MentalHealthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ph,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  SizedBox(width: 10.w),
                  Text(
                    'Mental Health',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  Image.asset('assets/images/mental_health.png', height: 240.h),
                  SizedBox(height: 10.h),
                  Text(
                    'The psychological health of the mother affects the future of the child',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'The experience of pregnancy is a beautiful journey, and its impact can completely change your life. It can also lead to many changes and challenges in a woman’s life. Whether you are pregnant for the first time or have previous experiences, it is important to obtain the necessary support and information to have a healthy and happy pregnancy experience.',
                    style: TextStyle(fontSize: 15.sp),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildExpandableTile(
                'Understanding the impact of psychological stress on the pregnant woman',
                'Psychological stress during pregnancy can significantly impact both the mother and the developing baby. Chronic stress may lead to hormonal imbalances, increased blood pressure, and even complications like preterm birth or low birth weight. Managing stress through relaxation, physical activity, and emotional support is essential for a healthy pregnancy.',
              ),
              _buildExpandableTile(
                'Reducing Psychological Stress During Pregnancy',
                'To reduce stress during pregnancy, practice mindfulness, engage in breathing exercises, and maintain a balanced diet. Surround yourself with supportive people, talk about your feelings, and ensure you get enough sleep. Seeking professional help if stress becomes overwhelming is also important.',
              ),
              _buildExpandableTile(
                'Changes in the psychology of the pregnant woman during the first trimester',
                'During the first trimester, hormonal changes can lead to mood swings, increased anxiety, and fatigue. It is common to feel emotional instability, but maintaining a positive mindset and practicing self-care can help manage these changes effectively.',
              ),
              _buildExpandableTile(
                'Changes in the psychology of the pregnant woman during the second trimester',
                'The second trimester is often considered the most emotionally stable period. However, some women may still experience anxiety about upcoming responsibilities. Engaging in prenatal education and relaxation techniques can help improve emotional well-being.',
              ),
              _buildExpandableTile(
                'Changes in the psychology of the pregnant woman during the third trimester',
                'As labor approaches, it is normal to feel anxious and overwhelmed. The fear of childbirth, body image concerns, and sleep disturbances may arise. Communicating with healthcare providers and preparing for delivery can help reduce anxiety.',
              ),
              _buildExpandableTile(
                'What causes mood swings during pregnancy?',
                'Mood swings are primarily caused by hormonal fluctuations, physical discomfort, and emotional stress. Changes in estrogen and progesterone levels impact brain chemistry, leading to shifts in mood. Proper rest, a healthy diet, and stress management can help regulate emotions.',
              ),
              _buildExpandableTile(
                'Ways to improve your mood during pregnancy',
                'To boost your mood during pregnancy, engage in activities you enjoy, exercise regularly, maintain a nutritious diet, and seek emotional support from loved ones. Practicing gratitude and meditation can also enhance emotional well-being.',
              ),
              _buildExpandableTile(
                'Tips to help maintain the psychological health of the pregnant woman',
                'Ensuring psychological well-being during pregnancy involves maintaining a healthy lifestyle, seeking prenatal education, and avoiding stress triggers. Connecting with other mothers, attending prenatal yoga, and engaging in relaxation techniques can contribute to a positive pregnancy experience.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableTile(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.w),
          child: Text(
            content,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
