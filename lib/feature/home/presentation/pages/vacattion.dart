import 'package:flutter/material.dart';

import '../widgets/all_body_video_tips.dart';

class VacattionScreen extends StatelessWidget {
  VacattionScreen({super.key});
  List videoTileList = [
    'my liver is in infants /oral polio from birth to 2months',
    "How to Handle a Child After Vaccination",
    'BCG taste /oral polio 2months',
    'Dealing with fever and all about the 2 months vaccination',
    'Vaccination at 4 and 6 months and treatment of fever and leg swelling after vaccination',
    'Five taste /oral polio /polio injection 9months',
    'One-year vaccination for children | Measles, German measles, mumps and polio vaccination',
    '18 months Vaccinated against 7 diseases',
  ];
  List videoOnTapList = [
    'https://youtu.be/ZxmR5xipTEI?si=ceJW9fD-lMI4_dYQ',
    'https://youtu.be/0l6JZLYuGs0?si=7pYMtSkGezbhB7Wf',
    'https://youtu.be/OwDA2p2my8I?si=vtxMoyd0ITEajx10',
    'https://youtu.be/Px5tQtRejIE?si=MgZ7C7F-OIqCAIA_',
    'https://youtu.be/OFxbrH38gLI?si=Nx-ruVOgIL7rcQu9',
    'https://youtu.be/LSQ7BF93LSU?si=c0xT9xdKnGNLX8OI',
    'https://youtu.be/8L57DxcaAY8?si=6ExgkAtSv0Kmrr7i',
    'https://youtu.be/UF17KXMPYjs?si=Gksh9mKKF28rdQKk',
  ];

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
