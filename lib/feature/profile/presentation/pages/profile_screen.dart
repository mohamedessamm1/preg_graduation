import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/constant.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';
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
                title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/images/user.png"),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            accountModel?.username ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.white38, thickness: 0.5, indent: 20, endIndent: 20),
                          _buildMenuItem(Icons.person, "Edit Profile", context, const EditProfileScreen()),
                          _buildMenuItem(Icons.favorite, "Favorite", context, null),
                          _buildMenuItem(Icons.lock, "Change Password", context, ChangePasswordPage()),
                          _buildLogoutButton(context)
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
Widget _buildLogoutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () => _showLogoutDialog(context),
      icon: const Icon(Icons.exit_to_app, color: Colors.red),
      label: const Text(
        "Logout",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",style: TextStyle(color: Colors.white),),
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
                const SnackBar(
                  content: Text('Logout successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
