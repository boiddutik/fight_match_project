import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/widgets/pop_up_dialog.dart';
import '../notifiers/create_profile_notifier.dart';

class CreateProfileNameScreen extends ConsumerStatefulWidget {
  const CreateProfileNameScreen({super.key});

  @override
  ConsumerState<CreateProfileNameScreen> createState() =>
      _CreateProfileNameScreenState();
}

class _CreateProfileNameScreenState
    extends ConsumerState<CreateProfileNameScreen> {
  final _fullNameController = TextEditingController();
  bool _dialogShown = false;
  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      Future.microtask(() {
        showPopUpDialog(
          // ignore: use_build_context_synchronously
          context: context,
          iconPath: CustomIcons.globalSearch,
          iconSize: 80,
          title:
              'Would you like to set up your profile for optimal matches or would you prefer to explore first?',
        );
      });
    }
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
                  'What is your name?',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Palette.darkGreen),
                ),
              ),
              TextField(
                controller: _fullNameController,
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
                  hintText: 'Samantha Ruth',
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
            final name = _fullNameController.text.trim();

            if (name.length < 3) {
              showSnackbar(context, 'Please enter your full name!');
              return;
            }
            ref
                .read(createProfileProvider.notifier)
                .addFullname(context, _fullNameController.text.trim());
          },
          child: SvgPicture.asset(Svgs.zeroPercent),
        ),
      ],
    );
  }
}
