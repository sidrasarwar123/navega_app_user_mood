import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/core/routes/app_routes.dart';

import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/button/social_button.dart';
import 'package:navega_app/core/widgets/fields/custom_textfield.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_assets.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 Future<void> _handleLogin() async {
  setState(() => _isLoading = true);

  await Future.delayed(const Duration(seconds: 1));

  if (!mounted) return;

  setState(() => _isLoading = false);

  Get.offAllNamed(Routes.home);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               _HeaderImage(),
              Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sectionSpacing),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome To ',
                            style: AppTextStyles.heading,
                          ),
                          TextSpan(
                            text: 'Navega 2025',
                            style: AppTextStyles.headingAccent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Name field
                    const Text('Name', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'User name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    const Text('Password', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () =>
                              setState(() => _rememberMe = !_rememberMe),
                          child: Row(
                            children: [
                              Icon(
                                _rememberMe
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                size: 18,
                                color: _rememberMe
                                    ? AppColors.primaryBlue
                                    : AppColors.textGrey,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Remember me',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.forget);
                          },
                          child: const Text(
                            'Forget Password?',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    PrimaryButton(
                      label: 'Log In',
                      trailingIcon: Icons.arrow_forward,
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Divider with text
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(color: AppColors.divider)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Or Log In With',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                        Expanded(
                            child: Divider(color: AppColors.divider)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    Center(
                      child: SocialIconButton(
                        assetPath: AppImage.google,
                        onTap: () {
                          Get.offAllNamed(Routes.home);
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Don't have an Account?",
                            style: AppTextStyles.label,
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () {
                                Get.toNamed(Routes.signUp);
                            },
                            child: const Text(
                              'Create Account',
                              style: AppTextStyles.link,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BottomCurveClipper(),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Image.asset(
        AppImage.login,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.splashGradientTop, AppColors.primaryBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Icon(
              Icons.directions_boat_filled,
              size: 64,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}