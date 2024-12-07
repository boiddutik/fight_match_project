import 'package:fight_match_app/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/navigators.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to our',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Fight Matching',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'social app',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    navigate(context, const LoginScreen());
                  },
                  child: const Text('Login with email')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'OR',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    navigate(context, const SignupScreen());
                  },
                  child: const Text('Signup')),
            ],
          ),
        ),
      ],
    );
  }
}
