import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/button/social_button.dart';
import 'package:navega_app/core/widgets/fields/custom_textfield.dart';
import 'package:navega_app/core/widgets/fields/dropdown_field.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_assets.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _month;
  String? _date;
  String? _year;

  bool _agreedToTerms = false;
  bool _isLoading = false;

  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static final _dates = List.generate(31, (i) => '${i + 1}');
  static final _years = List.generate(
    80,
    (i) => '${DateTime.now().year - i}',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 Future<void> _handleSignUp() async {
  if (!_agreedToTerms) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please agree to the Terms and Conditions to continue.',
        ),
      ),
    );
    return;
  }

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
              const CurvedHeaderImage(
                assetPath: 'assets/images/kayak_header.png',
                fallbackIcon: Icons.kayaking_outlined,
              ),
              Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sectionSpacing),
                    const Text('Create Your Account', style: AppTextStyles.heading),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // First name
                    const Text('First Name', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'First name',
                      controller: _firstNameController,
                    ),
                    const SizedBox(height: 20),

                    // Last name
                    const Text('Last Name', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'Last name',
                      controller: _lastNameController,
                    ),
                    const SizedBox(height: 20),

                    // Email
                    const Text('Enter Email', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'email@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    // Phone
                    const Text('Phone Number', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: '+92 3455555555',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    // Password
                    const Text('Password', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),

                    // Birthday
                    const Text('Birthday', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Month',
                            items: _months,
                            value: _month,
                            onChanged: (v) => setState(() => _month = v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Date',
                            items: _dates,
                            value: _date,
                            onChanged: (v) => setState(() => _date = v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Year',
                            items: _years,
                            value: _year,
                            onChanged: (v) => setState(() => _year = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Terms checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _agreedToTerms,
                            activeColor: AppColors.primaryBlue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (v) =>
                                setState(() => _agreedToTerms = v ?? false),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodySmall,
                              children: [
                                const TextSpan(text: 'By registering, I agree to the '),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: AppTextStyles.link.copyWith(fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: AppTextStyles.link.copyWith(fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    PrimaryButton(
                      label: 'Sign Up',
                      trailingIcon: Icons.arrow_forward,
                      isLoading: _isLoading,
                      onPressed: _handleSignUp,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Divider with text
                    Row(
                      children: const [
                        Expanded(child: Divider(color: AppColors.divider)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Or Sign In With', style: AppTextStyles.bodySmall),
                        ),
                        Expanded(child: Divider(color: AppColors.divider)),
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
                            "Already have an Accoun",
                            style: AppTextStyles.label,
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () {
                                Get.toNamed(Routes.login);
                            },
                            child: const Text(
                              'Log In',
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



class CurvedHeaderImage extends StatelessWidget {
  final String assetPath;
  final double height;
  final IconData fallbackIcon;
 
  const CurvedHeaderImage({
    super.key,
    required this.assetPath,
    this.height = 220,
    this.fallbackIcon = Icons.image_outlined,
  });
 
  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    return ClipPath(
      clipper: _BottomCurveClipper(),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.asset(
          AppImage.sinupImage,
          fit: BoxFit.cover,
        
          cacheWidth: (MediaQuery.of(context).size.width * dpr).round(),
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, error, stackTrace) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.splashGradientTop, AppColors.primaryBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Icon(fallbackIcon, size: 64, color: AppColors.white),
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