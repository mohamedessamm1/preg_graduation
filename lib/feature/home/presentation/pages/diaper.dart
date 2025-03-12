import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class DiaperScreen extends StatelessWidget {
   DiaperScreen({super.key});
  List videoTileList = ['DiaperScreen Tips', 'DiaperScreen Tips', 'DiaperScreen Tips', 'DiaperScreen Tips'];
  List videoOnTapList = ['DiaperScreen Tips', 'DiaperScreen Tips', 'DiaperScreen Tips', 'DiaperScreen Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'Diaper Tips:',
      content: 'diapering your baby',
      imageUrl: 'assets/images/four.jpg',

    );
  }

}
