import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/snackbar.dart';
import '../notifiers/auth_notifier.dart';
import '../widgets/auth_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? email;
  const LoginScreen({super.key, this.email});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    if (widget.email != null) {
      _emailController.text = widget.email.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    // Collect the field values
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || password.length < 8) {
      showSnackbar(context, 'Please enter valid credentials');
      return;
    }

    ref.read(authProvider.notifier).login(
          context: context,
          email: email,
          password: password,
        );
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
                  'Log in with email',
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
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: ElevatedButton(
            onPressed: login,
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }
}
