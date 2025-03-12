import 'package:flutter/material.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/all_body_video_tips.dart';

class SleepingScreen extends StatelessWidget {
   SleepingScreen({super.key});
  List videoTileList = [ 'Breastfeeding Tips', 'SleepingScreen Tips', 'Breastfeeding Tips'];
  List videoOnTapList =[ 'SleepingScreen Tips', 'Breastfeeding Tips', 'SleepingScreen Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'importance of sleep for infants:',
      content: 'growth and development deep sleep aids in the secretion of growth hormones. mood regulation quality sleep contributes to mood stability. immune support good sleep strengthens the immune system, helping protect the baby from illnesses. infants typically sleep between 14 to 17 hours a day, but this can vary with age.',
      imageUrl: 'assets/images/sleeping_baby.png',

    );
  }

}
