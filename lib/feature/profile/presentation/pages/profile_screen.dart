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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _menuController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late List<Animation<Offset>> _menuItemAnimations;
  late Animation<double> _avatarScaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Main animation controller for container and avatar
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Menu items animation controller
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Fade animation for the main container
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Slide animation for the container
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
    ));

    // Scale animation for the container
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    // Avatar scale animation with bounce effect
    _avatarScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    // Menu items staggered animations
    _menuItemAnimations = List.generate(3, (index) {
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _menuController,
        curve: Interval(
          0.1 + (index * 0.15),
          0.4 + (index * 0.15),
          curve: Curves.easeOutBack,
        ),
      ));
    });
  }

  void _startAnimations() {
    _mainController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _menuController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _menuController.dispose();
    super.dispose();
  }

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
                title: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                      ),
                    );
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _fadeAnimation,
                        _slideAnimation,
                        _scaleAnimation,
                      ]),
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: _buildProfileContainer(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Loading Profile...",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFFB08E76),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15.r,
            spreadRadius: 2.r,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10.r,
            spreadRadius: -2.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
          _buildAnimatedAvatar(),
          SizedBox(height: 10.h),
          _buildAnimatedUsername(),
          SizedBox(height: 20.h),
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Divider(
                  color: Colors.white38,
                  thickness: 0.5.h,
                  indent: 20.w,
                  endIndent: 20.w,
                ),
              );
            },
          ),
          _buildAnimatedMenuItems(),
          SizedBox(height: 20.h),
          _buildAnimatedLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildAnimatedAvatar() {
    return AnimatedBuilder(
      animation: _avatarScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _avatarScaleAnimation.value,
          child: Hero(
            tag: 'profile_avatar',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage("assets/images/user.png"),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedUsername() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Text(
                  accountModel?.username ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAnimatedMenuItems() {
    final menuItems = [
      {'icon': Icons.person, 'title': 'Edit Profile', 'page': const EditProfileScreen()},
      {'icon': Icons.favorite, 'title': 'Favorite', 'page': FavouriteScreen()},
      {'icon': Icons.lock, 'title': 'Change Password', 'page': ChangePasswordPage()},
    ];

    return Column(
      children: List.generate(menuItems.length, (index) {
        return AnimatedBuilder(
          animation: _menuItemAnimations[index],
          builder: (context, child) {
            return SlideTransition(
              position: _menuItemAnimations[index],
              child: FadeTransition(
                opacity: _menuController,
                child: _buildMenuItem(
                  menuItems[index]['icon'] as IconData,
                  menuItems[index]['title'] as String,
                  context,
                  menuItems[index]['page'] as Widget?,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildAnimatedLogoutButton() {
    return AnimatedBuilder(
      animation: _menuController,
      builder: (context, child) {
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: _buildLogoutButton(context),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context, Widget? page) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: page != null
                    ? () => _navigateWithAnimation(context, page)
                    : null,
                onTapDown: (_) => setState(() {}),
                onTapCancel: () => setState(() {}),
                child: Container(
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
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Icon(
                            Icons.arrow_forward_ios,
                            size: 15.sp,
                            color: Colors.white54,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: SizedBox(
            width: 170.w,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton.icon(
                onPressed: () => _showAnimatedLogoutDialog(context),
                icon: Icon(Icons.exit_to_app, color: Colors.red, size: 15.sp),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black26,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAnimatedLogoutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
          child: AlertDialog(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Are you sure you want to log out?",
              style: TextStyle(fontSize: 13.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: TextButton(
                  onPressed: () {
                    CacheHelper.removedata(key: 'TOKEN');
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}