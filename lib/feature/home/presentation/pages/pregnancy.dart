import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PregnancyScreen extends StatefulWidget {
  @override
  _PregnancyScreenState createState() => _PregnancyScreenState();
}

class _PregnancyScreenState extends State<PregnancyScreen> {
  int selectedMonth = 7; // Default month
  PageController _pageController = PageController(initialPage: 6);

  final List<dynamic> pregnancyData = [
    {
      'month': 1,
      'heartbeat': 'No heartbeat yet',
      'weight': 'Tiny, <1g',
      'size': '0.1 in',
      'growth': 'Embryo begins forming.',
      'food': [
        'Folic Acid - Essential for early neural tube development',
        'Oranges - High in vitamin C and folate',
        'Leafy Greens - Rich in iron and folic acid',
      ],
    },
    {
      'month': 2,
      'heartbeat': 'Starts beating at 150 bpm',
      'weight': '1g',
      'size': '0.6 in',
      'growth': 'Major organs start developing.',
      'food': [
        'Spinach - Provides iron and folic acid',
        'Eggs - High in protein and choline',
        'Dairy Products - Rich in calcium for bone development',
      ],
    },
    {
      'month': 3,
      'heartbeat': 'Steady at 150 bpm',
      'weight': '14g',
      'size': '2.5 in',
      'growth': 'Facial features start forming.',
      'food': [
        'Avocado - Healthy fats for brain development',
        'Greek Yogurt - Supports digestion and bone strength',
        'Lean Meat - Provides protein and iron',
      ],
    },
    {
      'month': 4,
      'heartbeat': '140 bpm',
      'weight': '100g',
      'size': '5 in',
      'growth': 'Fingers, toes, and hair start growing.',
      'food': [
        'Salmon - Omega-3 for baby’s brain development',
        'Nuts and Seeds - Source of healthy fats and protein',
        'Bananas - Prevents leg cramps and supports digestion',
      ],
    },
    {
      'month': 5,
      'heartbeat': '135 bpm',
      'weight': '300g',
      'size': '10 in',
      'growth': 'Baby starts kicking, lanugo appears.',
      'food': [
        'Milk - Provides calcium for strong bones',
        'Lentils - High in protein and fiber',
        'Sweet Potatoes - Rich in vitamin A for baby’s growth',
      ],
    },
    {
      'month': 6,
      'heartbeat': '130 bpm',
      'weight': '600g',
      'size': '12 in',
      'growth': 'Eyes open, lungs begin to mature.',
      'food': [
        'Carrots - Improves baby’s eyesight',
        'Oatmeal - Maintains energy levels',
        'Walnuts - Enhances brain development',
      ],
    },
    {
      'month': 7,
      'heartbeat': '146 bpm',
      'weight': '2.79 kg',
      'size': '14.8 in',
      'growth': 'Brain rapidly develops, baby reacts to sound.',
      'food': [
        'Almonds - Supports baby’s memory and brain function',
        'Dates - Provides energy and aids digestion',
        'Dark Leafy Greens - Boosts iron levels',
      ],
    },
    {
      'month': 8,
      'heartbeat': '140 bpm',
      'weight': '2.3 kg',
      'size': '17 in',
      'growth': 'Baby gains fat, movements are stronger.',
      'food': [
        'Cheese - Strengthens baby’s bones',
        'Sweet Potato - Enhances immune system',
        'Protein-rich foods (chicken, tofu) - Supports muscle growth',
      ],
    },
    {
      'month': 9,
      'heartbeat': '130 bpm',
      'weight': '3.4 kg',
      'size': '20 in',
      'growth': 'Baby is ready for birth.',
      'food': [
        'Eggplant - Helps with natural labor',
        'Watermelon - Reduces swelling and keeps hydration',
        'Whole Grains - Sustains energy levels',
      ],
    },
  ];

  void onMonthSelected(int index) {
    setState(() {
      selectedMonth = index + 1;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Stack(
             alignment: Alignment.center,
             children: [
               Container(width: double.infinity,color: Colors.blue[100],height: 350.h,),

               Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [

                   Image.asset('assets/images/embryo.png', height: 190.h),
                   SizedBox(height: 10.h),
                   SizedBox(
                     height: 50.h,
                     child: ListView.builder(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemCount: 9,
                       itemBuilder: (context, index) {
                         return GestureDetector(
                           onTap: () => onMonthSelected(index),
                           child: Container(
                             width: 20.w,
                             margin: EdgeInsets.symmetric(horizontal: 8.w),
                             decoration: BoxDecoration(
                               color: selectedMonth == index + 1
                                   ? Colors.orange
                                   : Colors.white,
                               shape: BoxShape.circle,
                               border: Border.all(color: Colors.orange, width: 2.w),
                             ),
                             child: Center(
                               child: Text(
                                 '${index + 1}',
                                 style: TextStyle(
                                   fontSize: 12.sp,
                                   fontWeight: FontWeight.bold,
                                   color:
                                   selectedMonth == index + 1 ? Colors.white : Colors.orange,
                                 ),
                               ),
                             ),
                           ),
                         );
                       },
                     ),
                   ),
                 ],
               ),
             ],
           ),


            SizedBox(
              height: 800.h,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pregnancyData.length,
                      onPageChanged: (index) => onMonthSelected(index),
                      itemBuilder: (context, index) {
                        final data = pregnancyData[index];
                        return Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Month ${data['month']}",
                                      style: TextStyle(fontSize: 19.sp, color: Colors.orange,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Text(
                                "More Details",
                                style: TextStyle(
                                    fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(Icons.favorite, color: Colors.white),
                                            Text("Heartbeat",
                                                style: TextStyle(color: Colors.white)),
                                            Text(data['heartbeat'],
                                                style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.scale, color: Colors.white),
                                            Text("Weight",
                                                style: TextStyle(color: Colors.white)),
                                            Text(data['weight'],
                                                style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.straighten, color: Colors.white),
                                            Text("Size",
                                                style: TextStyle(color: Colors.white)),
                                            Text(data['size'],
                                                style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Healthy Food",
                                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/food.png', width: 50.w),
                                title: Text(data['food'][0]),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/food.png', width: 50.w),
                                title: Text(data['food'][1]),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/food.png', width: 50.w),
                                title: Text(data['food'][2]),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Video Tips",
                                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                              ),
                              InkWell(
                                onTap: () async {
                                  final Uri url = Uri.parse(
                                      'https://youtu.be/1zpV5rzWXMA' );

                                  // Check if the URL can be launched
                                  await launchUrl(url, mode: LaunchMode.externalApplication);                           },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/two.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 190.h,
                                  child: Center(
                                    child: Icon(Icons.play_circle_fill, color: Colors.brown, size: 50.w),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
