import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/palette.dart';
import '../../../core/utils/snackbar.dart';
import '../widgets/auth_field.dart';
import 'create_profile_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(Svgs.backButton),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'Create an Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              AuthField(
                label: 'Email',
                hintText: 'example@email.com',
                controller: _emailController,
              ),
              const SizedBox(height: 18),
              AuthField(
                label: 'Password',
                hintText: '********',
                controller: _passwordController,
                isObscure: !_isPasswordVisible,
                suffixIcon: _isPasswordVisible
                    ? CustomIcons.showPassword
                    : CustomIcons.hidePassword,
                onSuffixIconPressed: _togglePasswordVisibility,
              ),
              const SizedBox(height: 4),
              Text(
                'Password must be at least 8 characters long and include at least one uppercase letter, one symbol, and one number.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: 'Aileron',
                      fontWeight: FontWeight.w600,
                      color: Palette.textFieldHeader,
                    ),
              ),
              const SizedBox(height: 18),
              AuthField(
                label: 'Re-type Password',
                hintText: '********',
                controller: _confirmPasswordController,
                isObscure: !_isPasswordVisible,
                suffixIcon: _isPasswordVisible
                    ? CustomIcons.showPassword
                    : CustomIcons.hidePassword,
                onSuffixIconPressed: _togglePasswordVisibility,
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: ElevatedButton(
            onPressed: () {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();
              final confirmPassword = _confirmPasswordController.text.trim();

              if (!email.contains('@')) {
                showSnackbar(context, 'Please enter a valid email!');
                return;
              }

              if (password != confirmPassword) {
                showSnackbar(context, 'Passwords do not match!');
                return;
              }

              if (password.length < 8) {
                showSnackbar(
                    context, 'Password must be at least 8 characters long!');
                return;
              }

              // Check for at least one uppercase letter and one symbol
              final hasUppercase = password.contains(RegExp(r'[A-Z]'));
              final hasSpecialChar =
                  password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

              if (!hasUppercase) {
                showSnackbar(context,
                    'Password must contain at least one uppercase letter!');
                return;
              }

              if (!hasSpecialChar) {
                showSnackbar(context,
                    'Password must contain at least one special character!');
                return;
              }
              navigateAndRemoveUntil(
                  context,
                  CreateProfileScreen(
                    email: email,
                    password: password,
                  ));
            },
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}
