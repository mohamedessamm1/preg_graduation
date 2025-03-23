import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

class NewbornCareScreen extends StatelessWidget {
  const NewbornCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Newborn Care Guide"),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedSection(
              "✅ Signs of a Healthy Newborn",
              "- Feeds every 2-4 hours, whether breastfed or formula-fed.\n"
                  "- Soaks 6-10 diapers daily, with 4-6 wet ones.\n"
                  "- Has regular breathing and pinkish skin without abnormal blue or yellow patches.\n"
                  "- Cries when hungry or needs a diaper change, and stops once satisfied.",
              Icons.health_and_safety,
            ),
            _buildAnimatedSection(
              "⚠️ Warning Signs Requiring a Doctor Visit",
              "- Continuous, inconsolable crying.\n"
                  "- Refuses to feed or appears too weak to suck properly.\n"
                  "- Skin turns blue, purple, or deep yellow.\n"
                  "- Shows difficulty breathing, such as grunting or frequent pauses.\n"
                  "- Has fewer wet diapers than expected, indicating dehydration.",
              Icons.warning,
            ),
            _buildAnimatedSection(
              "🩹 Umbilical Cord Care",
              "- Clean the umbilical cord gently with warm water and let it dry.\n"
                  "- Do not pull or attempt to remove the cord manually; it will fall off naturally in 1-2 weeks.\n"
                  "- Keep the diaper folded below the navel to avoid irritation.\n"
                  "- Avoid applying alcohol or antiseptics unless prescribed.\n"
                  "- Seek medical help if the area turns red, has a foul odor, or oozes pus.",
              Icons.medical_services,
            ),
            _buildAnimatedSection(
              "🌞 Jaundice in Newborns",
              "- Physiological jaundice appears on the third day and resolves within 2-3 weeks.\n"
                  "- Jaundice above 12% requires medical attention.\n"
                  "- Severe symptoms include difficulty feeding, extreme drowsiness, dark urine, or pale stools.\n"
                  "- Frequent feeding helps reduce bilirubin levels.\n"
                  "- Severe cases may need phototherapy or, in extreme cases, a blood transfusion.",
              Icons.light_mode,
            ),
            _buildAnimatedSection(
              "🍼 Proper Diaper Changing Tips",
              "- Change the diaper immediately after bowel movements to prevent infections.\n"
                  "- Use fragrance-free baby wipes or warm water and mild soap.\n"
                  "- Dry the skin thoroughly before applying a new diaper.\n"
                  "- Apply a diaper rash cream containing zinc oxide for protection.\n"
                  "- Give your baby diaper-free time daily to allow the skin to breathe.",
              Icons.baby_changing_station,
            ),
            _buildAnimatedSection(
              "🛁 Safe Bathing Guidelines",
              "- Before the umbilical cord falls off: Use a damp sponge for cleaning.\n"
                  "- After the umbilical cord falls off: Bathe in a small tub 2-3 times a week.\n"
                  "- Use lukewarm water (not hot) and mild, fragrance-free baby soap.\n"
                  "- Support the baby’s head during bathing and avoid water in the ears.\n"
                  "- Dry the baby gently and dress warmly after the bath.",
              Icons.bathtub,
            ),
            _buildAnimatedSection(
              "😴 Feeding and Sleeping Habits",
              "- Newborns need feeding every 2-3 hours, about 8-12 times daily.\n"
                  "- Breastfeeding enhances immunity and reduces infection risks.\n"
                  "- Babies sleep between 10.5 to 18 hours a day in short cycles.\n"
                  "- Always place babies on their backs while sleeping to reduce the risk of SIDS.\n"
                  "- Keep the crib free of pillows and toys to prevent suffocation.",
              Icons.nightlight_round,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, String content, IconData icon) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.orangeAccent, size: 30),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                content,
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}