import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/all_body_video_tips.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/body_content_section.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/image_Section.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/list_video_tile.dart';

import '../../../../core/shared/Colors/colors.dart';

class BreastfeedingScreen extends StatelessWidget {
   BreastfeedingScreen({super.key});
List videoTileList = ['Breastfeeding Tips', 'Breastfeeding Tips', 'Breastfeeding Tips', 'Breastfeeding Tips'];
List videoOnTapList = ['Breastfeeding Tips', 'Breastfeeding Tips', 'Breastfeeding Tips', 'Breastfeeding Tips'];


  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
        videoTileList: videoTileList,

      title: 'benefits of breastfeeding:',
      content: 'complete nutrition provides all essential nutrients needed.boosts immunity helps protect the baby from illnesses. emotional bonding strengthens the connection between mother and baby.',
    imageUrl: 'assets/images/breastfeeding2.png',

    );
  }


}
