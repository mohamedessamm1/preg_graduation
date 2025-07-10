import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class HealthTrackerScreen extends StatelessWidget {
  HealthTrackerScreen({super.key});
  List videoTileList = [
    'Ways to treat bloating and gas in infants',
    'Treating colic in infants',
    'Diseases affecting infants in the first year',
    'solution to get rid of heat rash or pimples in infants'
  ];
  List videoOnTapList = [
    'https://youtu.be/vXxxlPwdqm4?si=_Un0T8sv2bDdjNSE',
    'https://youtu.be/-IZeyosj-Eo?si=z4TBKoBfl1_-U3Px',
    'https://youtu.be/qWNlRijk-jI?si=qUDV0Dm_1i-_zcRa',
    'https://youtu.be/6btabpzRQ4I?si=fpSZbpMCcbPyGHnd'
  ];

  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,
      title: 'Health Tracker tips:',
      content:
          'growth and development deep sleep aids in the secretion of growth hormones. mood regulation quality sleep contributes to mood stability. immune support good sleep strengthens the immune system, helping protect the baby from illnesses. infants typically sleep between 14 to 17 hours a day, but this can vary with age.',
      imageUrl: 'assets/images/one.jpg',
    );
  }
}
