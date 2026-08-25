import 'package:flutter/material.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/fields/custom_textfield.dart';
import 'package:navega_app/Feature/auth/views/sign_up.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_assets.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendResetLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    // TODO: hook up real "forgot password" API call here.
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
   
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CurvedHeaderImage(
                assetPath: AppImage.forgetImage,
                fallbackIcon: Icons.directions_boat_filled,
                height: 200,
              ),
              Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sectionSpacing),
                    const Text('Reset password?', style: AppTextStyles.heading),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter the email address associated with your account "
                      "and we'll email you a link to reset your password.",
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),
                      
                    // Email field
                    const Text('Enter Email', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'email@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    PrimaryButton(
                      label: 'Send Reset Link',
                      trailingIcon: Icons.arrow_forward,
                      isLoading: _isLoading,
                      onPressed: _handleSendResetLink,
                    ),
                    const SizedBox(height: 18),

                    Center(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Log Back In',
                          style: AppTextStyles.link,
                        ),
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
