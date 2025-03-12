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
    return BlocProvider(create: (context) => ProfuleCubit()..fetchMyData(),
    child: BlocBuilder<ProfuleCubit, ProfuleState>(builder: (context, state) {
      return ConditionalBuilder(condition:state is! FetchMyDataLoadingState,
          builder: (context) => Scaffold(
            backgroundColor: mainColor, // Dark background
            appBar: AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Row(
                    children: [
                      const Icon(Icons.exit_to_app, color: Colors.red),
                      10.pw,
                      Text('Logout', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  onPressed: () {
                    CacheHelper.removedata(key: 'TOKEN');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                )
              ],
              title: const Text("Profile"),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB08E76), // Brownish color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "profile",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            "assets/images/user.png"), // Replace with actual image
                      ),
                      const SizedBox(height: 10),
                      Text(
                        accountModel?.username ?? "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                          color: Colors.white38,
                          thickness: 0.5,
                          indent: 20,
                          endIndent: 20),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfileScreen()));
                          },
                          child: _buildMenuItem(Icons.person, "Edit Profile")),
                      _buildMenuItem(Icons.favorite, "Favorite"),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage(),));
                          },
                          child: _buildMenuItem(Icons.settings, "Settings")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()));

    }),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}
