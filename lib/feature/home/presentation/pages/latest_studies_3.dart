import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

class PelvicPainScreen extends StatelessWidget {
  final List<Map<String, String>> sections = [
    {
      "title": "Causes",
      "content": "Pelvic pain during early pregnancy can be a normal symptom or an indication of a serious issue such as an ectopic pregnancy or miscarriage. Other causes may include hormonal changes, stretching of ligaments, or urinary tract infections."
    },
    {
      "title": "Evaluation",
      "content": "Doctors perform a pelvic exam, measure blood pressure, and conduct blood and hormone tests to determine the possible cause of pelvic pain. In some cases, ultrasound imaging is required to assess the condition of the uterus and ovaries."
    },
    {
      "title": "Treatment",
      "content": "Treatment depends on the underlying cause. It may include pain relievers, antibiotics for infections, or surgical intervention in emergency cases such as ectopic pregnancy. Lifestyle adjustments, hydration, and rest can also help alleviate symptoms."
    },
    {
      "title": "Key Points",
      "content": "Medical consultation is necessary if there is vaginal bleeding, persistent severe pain, dizziness, or general weakness to prevent serious complications. Early diagnosis and treatment can improve outcomes."
    },
    {
      "title": "Risk Factors",
      "content": "Risk factors include a history of miscarriage, smoking, drug use, uterine abnormalities, previous pelvic infections, or sexually transmitted diseases. Other conditions like endometriosis or fibroids can also contribute to pelvic pain."
    },
    {
      "title": "Required Examinations",
      "content": "Diagnostic tests include blood tests, ultrasound imaging, urine analysis to check for infections, and hormone level assessments. In some cases, laparoscopy may be necessary for further evaluation."
    },
    {
      "title": "Preventive Measures",
      "content": "Regular pregnancy exercises, avoiding heavy lifting, improving sleeping posture, wearing supportive clothing, and maintaining a balanced diet can help reduce pelvic pain. Proper hydration and stress management also play a significant role."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pelvic Pain During Pregnancy"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 500 + (index * 200)),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    sections[index]["title"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        sections[index]["content"]!,
                        style: TextStyle(fontSize: 16),
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
