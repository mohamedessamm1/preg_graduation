import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class BabyEatScreen extends StatelessWidget {
  BabyEatScreen({super.key});
  List videoTileList = [
    'When Baby Eat Yogurt?',
    'Conditions for Introducing Food to Infants',
    'When Baby Eat Cerelac?',
    'When Baby Start Eating Solids? And What Should He Eat?',
    'Babies With Food Allergy',
  ];
  List videoOnTapList = [
    'https://youtu.be/2oRXSg5BnVQ?si=w71XHtcYL70gDzRo',
    'https://youtu.be/J6-p_t5xK4Q?si=cuVt9mHGvXI4b7HM',
    'https://youtu.be/59D3_3KIAUU?si=R9r22lE9N14rC8Ni',
    'https://youtu.be/3XDodPuSIbo?si=bEwEnunyvGN7buL9',
    'https://youtu.be/NZ3XC7s50TE?si=I-wu8nVmvD2f9rA4'
  ];

  @override
  Widget build(BuildContext context) {
    return AllBodyVideoTips(
      videoOnTapList: videoOnTapList,
      videoTileList: videoTileList,
      title: 'common questions about feeding babies?',
      content:
          'what are the best first foods for the baby? how can i tell if my baby is ready for solids? feeding your baby when starting solids:',
      imageUrl: 'assets/images/baby_eat.png',
    );
  }
}
