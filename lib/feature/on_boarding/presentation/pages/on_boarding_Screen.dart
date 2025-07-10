import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_button_widget.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';
import '../../../../core/shared/Colors/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _currentIndex = 0;
  static const Duration _animationDuration = Duration(milliseconds: 600);

  static const List<OnboardingData> _onboardingPages = [
    OnboardingData(
      title: 'Welcome to the Mothers',
      description: 'Your journey to confident parenting starts here.',
      imagePath: 'assets/images/one.jpg',
    ),
    OnboardingData(
      title: 'Benefits Overview',
      description:
      'Discover valuable resources, expert advice, and a supportive community tailored for new mothers.',
      imagePath: 'assets/images/two.jpg',
    ),
    OnboardingData(
      title: 'How to Work',
      description:
      'Easily navigate through articles, consultations, and forums designed just for you.',
      imagePath: 'assets/images/three.jpg',
    ),
    OnboardingData(
      title: 'Join Our Community',
      description:
      'Share the app with other mothers and help build a strong, supportive community!',
      imagePath: 'assets/images/four.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pageController = PageController();

    _fadeController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _slideController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start initial animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _restartAnimations();
  }

  void _restartAnimations() {
    _fadeController.reset();
    _slideController.reset();
    _fadeController.forward();
    _slideController.forward();
  }

  void _nextPage() {
    if (_currentIndex < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToLogin() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          _buildBackgroundImages(),
          _buildGradientOverlay(),
          _buildContent(),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImages() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _onboardingPages.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
            }

            return Transform.scale(
              scale: Curves.easeOut.transform(value),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_onboardingPages[index].imagePath),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.3, 0.7, 1.0],
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      bottom: 120.h,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildContentForCurrentPage(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentForCurrentPage() {
    final currentPage = _onboardingPages[_currentIndex];
    final isLastPage = _currentIndex == _onboardingPages.length - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          if (!isLastPage) ...[
            _buildTitle(currentPage.title),
            SizedBox(height: 16.h),
          ],
          _buildDescription(currentPage.description),
          SizedBox(height: 32.h),
          _buildActionButtons(isLastPage),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescription(String description) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              constraints: BoxConstraints(maxWidth: 320.w),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade300,
                  height: 1.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(bool isLastPage) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 40 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isLastPage
                      ? _buildGetStartedButton()
                      : _buildNextButton(),
                ),
                if (!isLastPage) ...[
                  SizedBox(height: 16.h),
                  _buildSkipButton(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      key: const ValueKey('get_started'),
      width: double.infinity,
      child: customButton(
        onTap: _navigateToLogin,
        text: 'Get Started',
        icon: Icons.arrow_forward_ios_rounded,
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      key: const ValueKey('next'),
      width: double.infinity,
      child: customButton(
        onTap: _nextPage,
        text: 'Next',
      ),
    );
  }

  Widget _buildSkipButton() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _currentIndex == _onboardingPages.length - 1 ? 0.0 : 1.0,
      child: TextButton(
        onPressed: _navigateToLogin,
        child: Text(
          'Skip',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 60.h,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _currentIndex == _onboardingPages.length - 1 ? 0.0 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _onboardingPages.length,
                (index) => _buildIndicatorDot(index),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicatorDot(int index) {
    final isActive = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: isActive
            ? Colors.white
            : Colors.white.withOpacity(0.4),
      ),
    );
  }
}