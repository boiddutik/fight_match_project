import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/notifiers/create_profile_notifier.dart';

class CreateProfileLocationScreen extends ConsumerStatefulWidget {
  const CreateProfileLocationScreen({super.key});

  @override
  ConsumerState<CreateProfileLocationScreen> createState() =>
      _CreateProfileLocationScreenState();
}

class _CreateProfileLocationScreenState
    extends ConsumerState<CreateProfileLocationScreen> {
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _zipController.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'Location',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Palette.darkGreen),
                ),
              ),
              TextField(
                controller: _zipController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'Aileron',
                      fontWeight: FontWeight.w600,
                      color: Palette.black,
                      fontSize: 24,
                    ),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(32),
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'Aileron',
                        fontWeight: FontWeight.w600,
                        color: Palette.darkGreen,
                        fontSize: 24,
                      ),
                  fillColor: Palette.textField,
                  focusColor: Palette.textField,
                  hoverColor: Palette.textField,
                  hintText: 'United States',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Palette.darkGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Palette.darkGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Palette.darkGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Palette.darkGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
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
            final zip = _zipController.text.trim();

            if (zip.isEmpty) {
              showSnackbar(context, 'Please enter your location (country)!');
              return;
            }
            ref.read(createProfileProvider.notifier).addLocation(context, zip);
          },
          child: SvgPicture.asset(Svgs.fourtyPercent),
        ),
      ],
    );
  }
}
