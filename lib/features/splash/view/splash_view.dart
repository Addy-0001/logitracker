import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logitracker/core/constant/app_defaults.dart';
import 'package:logitracker/core/constant/image_const.dart';
import 'package:logitracker/core/database/hive_service.dart';
import 'package:logitracker/core/routes/routes.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/services/core/preference_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _pulseController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    processNavigation();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // Background animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    // Pulse animation for logo
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    _backgroundController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _pulseController.repeat(reverse: true);
  }

  processNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    // TODO: Fix hive service and fix this.
    HiveService().init();
    final prefs = locator<PreferenceService>();
    late final String toPage;
    if (prefs.accessToken.isEmpty) {
      toPage = Routes.loginPage;
    } else {
      toPage = Routes.homePage;
    }

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(toPage);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5 * _backgroundAnimation.value,
                colors: [
                  Colors.red[400]!.withOpacity(0.1),
                  Colors.red[50]!,
                  Colors.white,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background circles
                ...List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _backgroundAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: 100 + (index * 200),
                        left: -50 + (index * 100),
                        child: Transform.scale(
                          scale: _backgroundAnimation.value,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withOpacity(
                                0.05 - (index * 0.01),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _logoScaleAnimation,
                          _logoOpacityAnimation,
                          _pulseAnimation,
                        ]),
                        builder: (context, child) {
                          return Transform.scale(
                            scale:
                                _logoScaleAnimation.value *
                                _pulseAnimation.value,
                            child: Opacity(
                              opacity: _logoOpacityAnimation.value,
                              child: Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red[400]!,
                                      Colors.red[600]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Stack(
                                    children: [
                                      // Shimmer effect
                                      AnimatedBuilder(
                                        animation: _pulseController,
                                        builder: (context, child) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white.withOpacity(0.0),
                                                  Colors.white.withOpacity(0.3),
                                                  Colors.white.withOpacity(0.0),
                                                ],
                                                stops: const [0.0, 0.5, 1.0],
                                                transform: GradientRotation(
                                                  _pulseController.value * 6.28,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Logo image
                                      Center(
                                        child: Image.asset(
                                          ImageConst.appLogo,
                                          width: 60.w,
                                          height: 60.h,
                                          fit: BoxFit.contain,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 40.h),

                      // App name with slide animation
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _textOpacityAnimation,
                          _textSlideAnimation,
                        ]),
                        builder: (context, child) {
                          return SlideTransition(
                            position: _textSlideAnimation,
                            child: FadeTransition(
                              opacity: _textOpacityAnimation,
                              child: Column(
                                children: [
                                  Text(
                                    AppDefaults.appName,
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.bold,
                                      foreground:
                                          Paint()
                                            ..shader = LinearGradient(
                                              colors: [
                                                Colors.red[600]!,
                                                Colors.red[800]!,
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0.0,
                                                0.0,
                                                200.0,
                                                70.0,
                                              ),
                                            ),
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Logistics Made Simple',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 60.h),

                      // Loading indicator
                      AnimatedBuilder(
                        animation: _textOpacityAnimation,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _textOpacityAnimation,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  height: 40.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.red[600]!,
                                    ),
                                    backgroundColor: Colors.red[100],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
