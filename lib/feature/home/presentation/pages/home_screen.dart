import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/model/user_model.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/feature/chat/chat_bot.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/home/presentation/pages/information.dart';
import 'package:pregnant_care/feature/home/presentation/pages/latest_studies/latest_studies.dart';
import 'package:pregnant_care/feature/home/presentation/pages/mental_health.dart';
import 'package:pregnant_care/feature/home/presentation/pages/pregnancy.dart';
import 'package:pregnant_care/feature/home/presentation/pages/vacattion.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/item_grid_widget.dart';

import '../../../../core/shared/constant.dart';
import '../widgets/item_grid_view_home.dart';
import 'activity.dart';
import 'health_tracker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Debounce timer for search
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Fade animation for main content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Slide animation for header
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Scale animation for grid items
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Debounce search to improve performance
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      HomeCubit.get(context).getSearch();
    });
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: _buildFloatingActionButton(),
          backgroundColor: mainColor,
          body: SafeArea(
            child: ConditionalBuilder(
              condition: state is! FetchMyDataLoadingState,
              builder: (context) => _buildMainContent(context),
              fallback: (context) => _buildLoadingWidget(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _navigateToScreen(GeminiChatScreen()),
      backgroundColor: Colors.white,
      elevation: 8,
      heroTag: 'chat_fab',
      child: Icon(                Icons.smart_toy_rounded,
          color: mainColor), // Use heroTag instead of wrapping with Hero
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 20.h),
            _buildSearchSection(context),
            SizedBox(height: 20.h),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Row(
        children: [
          Hero(
            tag: 'user_avatar',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 28.r,
                backgroundImage: const AssetImage('assets/images/user.png'),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    final clampedValue = value.clamp(0.0, 1.0);
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - clampedValue)),
                      child: Opacity(
                        opacity: clampedValue,
                        child: Text(
                          'Welcome,',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18.sp,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 4.h),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    final clampedValue = value.clamp(0.0, 1.0);
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - clampedValue)),
                      child: Opacity(
                        opacity: clampedValue,
                        child: Text(
                          accountModel?.username ?? 'User',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CustomTextField(
                    controller: HomeCubit.get(context).searchController,
                    onChanged: _onSearchChanged,
                    hintText: 'Search for health tips...',
                    prefixIcon: Icons.search,
                    prefixIconColor: mainColor,
                    suffixIconColor: mainColor,
                    fillColor: Colors.white,
                    borderColor: Colors.white,
                    focusBorderColor: mainColor.withOpacity(0.3),
                    enabledBorderColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.r),
                    onTap: () => HomeCubit.get(context).getSearch(),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 24.sp,
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

  Widget _buildContent(BuildContext context) {
    final cubit = HomeCubit.get(context);
    final hasSearchResult = cubit.foundItem?['title'] != null;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: hasSearchResult
          ? _buildSearchResults(context, cubit)
          : _buildMainCategories(context, cubit),
    );
  }

  Widget _buildMainCategories(BuildContext context, HomeCubit cubit) {
    return Column(
      key: const ValueKey('main_categories'),
      children: [
        // Carousel Image with parallax effect
        Container(
          height: 250.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/crousal.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Categories Header
        Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                final clampedValue = value.clamp(0.0, 1.0);
                return Transform.translate(
                  offset: Offset(-30 * (1 - clampedValue), 0),
                  child: Opacity(
                    opacity: clampedValue,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Animated Grid
        _buildAnimatedGrid(cubit.gridItems),
        SizedBox(height: 35.h),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context, HomeCubit cubit) {
    return Column(
      key: const ValueKey('search_results'),
      children: [
        Row(
          children: [
            Text(
              'Search Results',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _buildAnimatedGrid([cubit.foundItem!]),
      ],
    );
  }

  Widget _buildAnimatedGrid(List<dynamic> items) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: 0.85,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 600 + (index * 100)),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              // Clamp the value to ensure it's within valid range
              final clampedValue = value.clamp(0.0, 1.0);

              return Transform.scale(
                scale: clampedValue,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - clampedValue)),
                  child: Opacity(
                    opacity: clampedValue,
                    child: _buildGridItem(item, index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildGridItem(dynamic item, int index) {
    return Hero(
      tag: 'grid_item_${item['id']}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            if (item['screen'] != null) {
              _navigateToScreen(item['screen']!);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ItemGridViewHome(
              index: index,
              id: item['id'].toString(),
              title: item['title'],
              image: item['image'],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              final clampedValue = value.clamp(0.0, 1.0);
              return Transform.scale(
                scale: 0.5 + (clampedValue * 0.5),
                child: Opacity(
                  opacity: clampedValue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
          Text(
            'Loading your personalized content...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}