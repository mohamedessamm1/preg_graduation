import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/mom_group.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/yoga.dart';

import 'baby_name.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Community',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Divider(
              color: Colors.brown.shade300,
            ),
            Text('Groups',style:  TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.brown),),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mom_screen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Row(
                  children: [
                    CircleAvatar(                      backgroundColor: Colors.white,

                      radius: 30.r,
                      backgroundImage: NetworkImage(
                          'https://s3-alpha-sig.figma.com/img/52b5/1a95/8dc010147ef1c430192350c1e934a4ec?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Xtg2ClXLg5-FzDoI4ueBvKctEC9D4D3w0MNxphVT3e45I9spMp042-ep1VfRvsYqg2vQ~ACSqBwrKnOQj4gqAPonyMLy0OVifL1zoJn5-ZFBHUu~AyZWlvbBIYtZ1yr0RCnP0y~nz3Dd23I72ce9Lv0Ax5JgwOEAvJQ8SKGlbF47Fr6VrF~ZwXHTvjLlAYgPQ0yCInZ~M1N8vR~L-GOZKM4kSbXR-GzJxpJ07A2SvqT2MtOQeQmf0GaDurQi-6nw-ziWG5p8sjZseNpXPLzKKuu8fSqJrjD1xb-U8DtmcdSw3AnkomXbi9pf2jbBFMer5hWm0aG8bFMxuBun9OW1IA__'),
                    ),
                    15.pw,
                    Text(
                      'moms group',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BabyScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,

                      radius: 30.r,
                      backgroundImage: NetworkImage(
                          'https://s3-alpha-sig.figma.com/img/d686/0ee9/89f317a18fb30cb707f956cd549d36c1?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=PdywJ1Ixjhkpsa1qEy5ePi5Or8rOu~gQzseNI~3Ok8zqqs5ptY-U9pyCIbdZMACAKOETj7cQGdvKMSPIIcOwyGxdhp~1gQCJjHGWb9IkYBLNU5oEw27XJdxM5wHa2tBcpkFELeX0b~pOisZyDY~Tm9FhF-DeWkGlsbAUiiWJas1Dia30NM3AfRF5O~Ndm~l2gJrVEMsjfOA5fHLBZwjxtNCBfxJNoX9KL3n~jzWVF8r8RhbF~gcj7BGm-Iy491zsjgA6neToTmaVE-Rf0eGmnCGNVBfYi59l62-2PGA8lb1YLdjVIrQa0Bt1-KdaZGZh-1Vt-FO0GmfaEcMo8FgOOQ__'),
                    ),
                    15.pw,
                    Text(
                      'baby names',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YogaScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30.r,
                      backgroundImage: NetworkImage(
                        'https://s3-alpha-sig.figma.com/img/7716/1368/cbeb8cc7100728c7e3ecc80f9cc3f59d?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=AoBlfojG0MX5UfyydXJOC6mnP9I1uuolZvLrxphtpI9xMe6u9DjvNsm8uxfTCiE7eFS-dGkUZmnef7JgYAIwb8tLn3Dny5EoqvLC1OlGbjVZiH7S5T8XNe42iVGbtWg~zLZ0urheUm4AThBtFRcQdJWMYmgQh6Bu0cBtumfVZqT4wmsAJja7xhew-aEJRSc5GHOLvq~Q1WWmcoFCaMpjjLJ03I1FRGGst-iX8WT1GBIEKbt8bheqL91ROLCKL8Su~qNFy9d2SWjgPpPHBx0ezJVOmIVFg2WC22sboziRyAMLAL9L~yPwVfQTp4Sg8Jwn60irrp4lKmbknK68QaDeHg__'
                      ),
                    ),
                    15.pw,
                    Text(
                      'yoga & sports',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Text('chats',style:  TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.brown),),

          ],
        ),
      ),
    );
  }
}
