import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

class PregnancySymptomsScreen extends StatelessWidget {
  final List<Map<String, String>> sections = [
    {
      "title": "Introduction",
      "content": "Pregnancy causes many changes in a woman's body. Most of these changes disappear after childbirth, but some may indicate disorders that require medical follow-up."
    },
    {
      "title": "Common Symptoms",
      "content": "These include nausea and vomiting, appetite changes, increased sense of smell, breast swelling, fatigue, back pain, and swelling of the feet and ankles. These symptoms are usually normal, but if they become severe, it is best to consult a doctor."
    },
    {
      "title": "Symptoms That May Raise Concerns About Pregnancy",
      "content": "If vaginal bleeding, abdominal pain or cramps, early contractions, amniotic fluid leakage, or decreased fetal movement after 24 weeks occur, there may be a risk to the pregnancy, and a doctor should be consulted immediately."
    },
    {
      "title": "Symptoms That May Raise Concerns About Other Disorders",
      "content": "These include fever, pain during urination, sharp back or flank pain, heartburn, dizziness, heart palpitations, persistent headaches, vision problems, facial or hand swelling, decreased urination, and any signs of infection. Pregnant women should see a doctor if these symptoms persist or worsen."
    },
    {
      "title": "When Should You Consult a Doctor?",
      "content": "If you experience any unusual symptoms such as severe pain, bleeding, sudden loss of fetal movement, or any concerning changes, you should contact your doctor immediately to avoid any potential complications."
    },
    {
      "title": "Potential Pregnancy Complications",
      "content": "Some pregnancies may develop complications such as gestational diabetes, high blood pressure, or preeclampsia. It is essential to monitor health indicators and follow medical advice to ensure a healthy pregnancy."
    },
    {
      "title": "Tips for a Healthy Pregnancy",
      "content": "Maintain a balanced diet, stay hydrated, engage in light exercise, get enough sleep, and attend regular prenatal checkups to ensure both mother and baby are healthy."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Pregnancy Symptoms"),
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
      },
    );
  }
}