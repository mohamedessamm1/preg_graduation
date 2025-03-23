import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/constant.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';
import 'package:pregnant_care/feature/favourite/presentation/pages/favourite_screen.dart';
import 'package:pregnant_care/feature/profile/presentation/pages/change_password.dart';
import '../manager/profule_cubit.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ProfuleCubit()..fetchMyData(),
      child: BlocBuilder<ProfuleCubit, ProfuleState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! FetchMyDataLoadingState,
            builder: (context) => Scaffold(
              backgroundColor: mainColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp, // Responsive font size
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB08E76),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          CircleAvatar(
                            radius: 50.r, // Responsive radius
                            backgroundImage: AssetImage("assets/images/user.png"),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            accountModel?.username ?? "",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Divider(color: Colors.white38, thickness: 0.5.h, indent: 20.w, endIndent: 20.w),
                          _buildMenuItem(Icons.person, "Edit Profile", context, const EditProfileScreen()),
                          _buildMenuItem(Icons.favorite, "Favorite", context, FavouriteScreen()),
                          _buildMenuItem(Icons.lock, "Change Password", context, ChangePasswordPage()),
                          SizedBox(height: 20.h),
                          _buildLogoutButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context, Widget? page) {
    return InkWell(
      onTap: page != null
          ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => page))
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 21.sp),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 15.sp, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

Widget _buildLogoutButton(BuildContext context) {
  return SizedBox(
    width: 170.w,
    child: ElevatedButton.icon(
      onPressed: () => _showLogoutDialog(context),
      icon: Icon(Icons.exit_to_app, color: Colors.red, size: 15.sp),
      label: Text(
        "Logout",
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
  );
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: mainColor,
        title: Text("Logout", style: TextStyle(fontSize: 15.sp)),
        content: Text("Are you sure you want to log out?", style: TextStyle(fontSize: 13.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 13.sp)),
          ),
          TextButton(
            onPressed: () {
              CacheHelper.removedata(key: 'TOKEN');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout successfully', style: TextStyle(fontSize: 11.sp)),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 13.sp)),
          ),
        ],
      );
    },
  );
}