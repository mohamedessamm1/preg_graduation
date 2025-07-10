import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class GrowthScreen extends StatelessWidget {
  GrowthScreen({super.key});
  List videoTileList = [
    'Newborn Baby Month 1 ',
    'Newborn Baby Month 2 ',
    'Newborn Baby Month 3 ',
    'Newborn Baby Month 4 ',
    'Newborn Baby Month 5 ',
    'Newborn Baby Month 6 ',
    'Newborn Baby Month 7 ',
    'Newborn Baby Month 8 ',
    'Newborn Baby Month 9 ',
    'Newborn Baby Month 10 ',
  ];
  List videoOnTapList = [
    'https://youtu.be/8K8kDjjUqLI',
    'https://youtu.be/1KnSdQPh-PA',
    'https://youtu.be/ZvCoCwsApfY',
    'https://youtu.be/QY-lvLAK0T8',
    'https://youtu.be/D2JLO1xsd70',
    'https://youtu.be/znyKk6MR62U',
    'https://youtu.be/Il9BIqnI12k',
    'https://youtu.be/liPBdLLkmmE',
    'https://youtu.be/nGWT6o34ZuU',
    'https://youtu.be/_v397Qg1wo4'
  ];

  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,
      title: 'Tips for Growth:',
      content: 'stages of child growth:',
      imageUrl: 'assets/images/two.jpg',
    );
  }
}
