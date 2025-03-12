import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class BabyEatScreen extends StatelessWidget {
   BabyEatScreen({super.key});
  List videoTileList = ['BabyEatScreen Tips', 'BabyEatScreen Tips', 'BabyEatScreen Tips', 'BabyEatScreen Tips'];
  List videoOnTapList = ['BabyEatScreen Tips', 'BabyEatScreen Tips', 'BabyEatScreen Tips', 'BabyEatScreen Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'common questions about feeding babies?',
      content: 'what are the best first foods for the baby? how can i tell if my baby is ready for solids? feeding your baby when starting solids:',
      imageUrl: 'assets/images/baby_eat.png',

    );
  }

}
