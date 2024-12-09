import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/snackbar.dart';
import '../notifiers/create_profile_notifier.dart';

class CreateProfileGenderScreen extends ConsumerStatefulWidget {
  const CreateProfileGenderScreen({super.key});

  @override
  ConsumerState<CreateProfileGenderScreen> createState() =>
      _CreateProfileGenderScreenState();
}

class _CreateProfileGenderScreenState
    extends ConsumerState<CreateProfileGenderScreen> {
  int? _selectedGender;
  void setGender(int i) {
    setState(() {
      _selectedGender = i;
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'What is your gender?',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Palette.darkGreen),
                ),
              ),
              // Gender Widget
              AspectRatio(
                aspectRatio: 16 / 7,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setGender(1);
                        },
                        child: Card(
                          elevation: 0,
                          color: _selectedGender == 1
                              ? Palette.darkGreen
                              : Palette.textField,
                          surfaceTintColor: Palette.darkGreen,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Svgs.male,
                                  height: 50,
                                  colorFilter: ColorFilter.mode(
                                      _selectedGender == 1
                                          ? Colors.white
                                          : Colors.black,
                                      BlendMode.srcIn),
                                ),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    color: _selectedGender == 1
                                        ? Colors.white
                                        : Palette.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zen',
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setGender(0);
                        },
                        child: Card(
                          elevation: 0,
                          color: _selectedGender == 0
                              ? Palette.darkGreen
                              : Palette.textField,
                          surfaceTintColor: Palette.darkGreen,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Svgs.female,
                                  height: 50,
                                  colorFilter: ColorFilter.mode(
                                      _selectedGender == 0
                                          ? Colors.white
                                          : Colors.black,
                                      BlendMode.srcIn),
                                ),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    color: _selectedGender == 0
                                        ? Colors.white
                                        : Palette.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zen',
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        GestureDetector(
          onTap: () {
            final gender = _selectedGender == 0 ? 'Female' : 'Male';

            if (_selectedGender == null) {
              showSnackbar(context, 'Please choose your gender!');
              return;
            }
            ref.read(createProfileProvider.notifier).addGender(context, gender);
          },
          child: SvgPicture.asset(Svgs.twentyPercent),
        ),
      ],
    );
  }
}
