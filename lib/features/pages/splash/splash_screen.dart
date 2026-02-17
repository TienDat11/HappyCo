import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Initialize auth state - check if user is logged in and fetch user data
    final authBloc = GetIt.I<AuthBloc>();
    authBloc.add(OnAuthInitialize());

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.router.replace(const MainRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Center(
        child: Image.asset(
          UIImages.logo,
          width: UISizes.width.w200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
