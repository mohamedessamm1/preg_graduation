import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/home/presentation/pages/my_friends_community.dart';

import '../../../chat/presentation/pages/baby_name.dart';
import '../../../chat/presentation/pages/chat_list.dart';
import '../../../chat/presentation/pages/mom_group.dart';
import '../../../chat/presentation/pages/yoga.dart';
import 'group_community.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text("Community", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Welcome To Community",
                      style: TextStyle(color: Colors.orange, fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Make Friends, Share Your Experience and get support in the Mama Mentor Community",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListCommunityScreen()));
                            }
                            ,child: _buildCategoryCard("My Friends", Icons.people)),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupCommunityScreen()));
                            }
                            ,child: _buildCategoryCard("My Groups", Icons.group),),

                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Suggested Topics",
                    style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(color: Colors.orange, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                InkWell(
 onTap: () {
   Navigator.push(context, MaterialPageRoute(builder: (context) => MomGroupScreen()));
 },
                     child: _buildTopicCard( title:'Moms Group',subtitle: '159 Members' )),
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BabyScreen()));
                    },
                    child: _buildTopicCard( title: 'Baby Names',subtitle: '85 Members' )),
                InkWell(

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YogaScreen()));
                    },
                    child: _buildTopicCard( title: 'Yoga & Sports',subtitle: '45 Members' )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50.sp),
            SizedBox(height: 5.h),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard({String? title, String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          title: Text(
            title!,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          subtitle: Text(subtitle!, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
          trailing: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            child: Text("Join", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ),
        ),
      ),
    );
  }
}
