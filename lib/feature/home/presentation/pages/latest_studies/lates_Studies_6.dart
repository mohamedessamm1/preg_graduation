import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

class ChildMentalHealthScreen extends StatelessWidget {
  final List<Map<String, String>> sections = [
    {
      "title": "Understanding Your Child",
      "content": "Parents can support their child's mental health by paying close attention to verbal and non-verbal cues. Recognizing when a child needs support or someone to talk to helps create a safe emotional environment. Children thrive when they feel secure and understood."
    },
    {
      "title": "Building a Healthy Relationship",
      "content": "A strong parent-child relationship is a key protective factor against mental health disorders. Instead of simply calming a child during emotional outbursts, parents should identify the root cause, whether it’s hunger, fatigue, or a stressful day at school."
    },
    {
      "title": "Allowing Your Child to Experience Failure",
      "content": "Parents often want to protect their children from distress, but overcoming failure builds resilience, promotes growth, and fosters empathy. Letting children experience setbacks helps them develop problem-solving skills and confidence."
    },
    {
      "title": "Engaging in Activities to Prevent Boredom",
      "content": "Boredom can be beneficial as it teaches children how to manage conflicts, solve problems, and develop self-control. Rather than over-scheduling, allowing free play helps enhance creativity and independence."
    },
    {
      "title": "Setting Boundaries for Daily Activities",
      "content": "Establishing rules for bedtime, screen time, and respectful behavior provides structure and communicates care. While flexibility is important, consistent boundaries help children feel safe and understood."
    },
    {
      "title": "Encouraging Social Interaction",
      "content": "Social well-being is a vital part of mental health. Developing friendships and social skills is essential. Studies suggest that for every hour of online interaction, children need 30 minutes of face-to-face communication to maintain a healthy balance."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Child Mental Health"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 500 + (index * 200)),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ExpansionTile(
                  title: Text(
                    sections[index]["title"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Text(
                        sections[index]["content"]!,
                        style: TextStyle(fontSize: 16.sp),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
