import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class HealthTrackerScreen extends StatelessWidget {
   HealthTrackerScreen({super.key});
  List videoTileList = [ 'Breastfeeding Tips', 'Health Tracker tips Tips', 'Breastfeeding Tips'];
  List videoOnTapList =[ 'Health Tracker tips Tips', 'Breastfeeding Tips', 'Health Tracker tips Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'Health Tracker tips:',
      content: 'growth and development deep sleep aids in the secretion of growth hormones. mood regulation quality sleep contributes to mood stability. immune support good sleep strengthens the immune system, helping protect the baby from illnesses. infants typically sleep between 14 to 17 hours a day, but this can vary with age.',
      imageUrl: 'assets/images/one.jpg',

    );
  }

}
