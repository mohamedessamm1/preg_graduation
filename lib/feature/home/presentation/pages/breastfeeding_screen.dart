import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/all_body_video_tips.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/body_content_section.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/image_Section.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/list_video_tile.dart';

import '../../../../core/shared/Colors/colors.dart';

class BreastfeedingScreen extends StatelessWidget {
  BreastfeedingScreen({super.key});
  List videoTileList = [
    'basics of infant nutrition',
    'Positions for breastfeeding',
    'Combining breastfeeding and formula feeding',
    'Should I wake my baby to feed him?',
    'One feeding from one breast'
  ];
  List videoOnTapList = [
    'https://youtu.be/vP3ZjuCadoU?si=JsTFZ46ubwidmNqf',
    'https://youtu.be/9z3sJxG-6SU?si=8NitWu398bLuq3If',
    'https://youtu.be/rFtoThKzf9Y?si=raGfIHSxP6eXA4wZ',
    'https://youtu.be/XMT0xcSZtaI?si=XH5b3MBrj2BacD9Y',
    'https://youtu.be/icUQ7jec8yw?si=h21bJmy04j8kihEz'
  ];

  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,
      title: 'benefits of breastfeeding:',
      content:
          'complete nutrition provides all essential nutrients needed.boosts immunity helps protect the baby from illnesses. emotional bonding strengthens the connection between mother and baby.',
      imageUrl: 'assets/images/breastfeeding2.png',
    );
  }
}
