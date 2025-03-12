import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class VacattionScreen extends StatelessWidget {
   VacattionScreen({super.key});
  List videoTileList = ['VacattionScreen Tips', 'VacattionScreen Tips', 'VacattionScreen Tips', 'VacattionScreen Tips'];
  List videoOnTapList = ['VacattionScreen Tips', 'VacattionScreen Tips', 'VacattionScreen Tips', 'VacattionScreen Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,

      title: 'vaccinations',
      content: '',
      imageUrl: 'assets/images/vacittion.png',

    );
  }

}
