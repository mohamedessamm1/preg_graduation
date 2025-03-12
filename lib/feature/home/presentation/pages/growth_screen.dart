import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class GrowthScreen extends StatelessWidget {
   GrowthScreen({super.key});
  List videoTileList = ['GrowthScreen Tips', 'GrowthScreen Tips', 'GrowthScreen Tips', 'GrowthScreen Tips'];
  List videoOnTapList = ['GrowthScreen Tips', 'GrowthScreen Tips', 'GrowthScreen Tips', 'GrowthScreen Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'Tips for Growth:',
      content: 'stages of child growth:',
      imageUrl: 'assets/images/baby.png',

    );
  }

}
