import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class DiaperScreen extends StatelessWidget {
  DiaperScreen({super.key});
  List videoTileList = [
    'Step by step .. How to change diapers',
    'Signs that indicate a change in diaper size',
    'How to treat diaper rash',
    'Step by step .. How to change diapers',
    'Signs that indicate a change in diaper size',
    'How to treat diaper rash',
  ];
  List videoOnTapList = [
    'https://youtu.be/JYI2YJA4D1M?si=tV_Jo_2HClhiT8Zw',
    'https://youtu.be/B_SMtilMeiA?si=gzMIYrA5UD5LByhf',
    'https://youtu.be/THw_wnPDUYw?si=xJzB0vTy_MmSxtPt',
    'https://youtu.be/JYI2YJA4D1M?si=tV_Jo_2HClhiT8Zw',
    'https://youtu.be/B_SMtilMeiA?si=gzMIYrA5UD5LByhf',
    'https://youtu.be/THw_wnPDUYw?si=xJzB0vTy_MmSxtPt',
  ];

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
