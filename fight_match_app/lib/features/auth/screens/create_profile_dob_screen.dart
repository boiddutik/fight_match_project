import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/icons.dart';
import '../../../core/utils/snackbar.dart';
import '../notifiers/create_profile_notifier.dart';

class CreateProfileDobScreen extends ConsumerStatefulWidget {
  const CreateProfileDobScreen({super.key});

  @override
  ConsumerState<CreateProfileDobScreen> createState() =>
      _CreateProfileDobScreenState();
}

class _CreateProfileDobScreenState
    extends ConsumerState<CreateProfileDobScreen> {
  final _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  DateTime? _selectedDob;
  void _showDatePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Palette.white,
      builder: (BuildContext context) {
        return BottomPicker.date(
          closeIconColor: Palette.black,
          // closeIconSize: 40,
          displayCloseIcon: true,
          pickerTitle: const Text(
            'Date of birth',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          dismissable: true,
          height: MediaQuery.of(context).size.height * 0.3,
          backgroundColor: Palette.white,
          displaySubmitButton: false,
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: DateTime.now(),
          maxDateTime: DateTime.now(),
          minDateTime: DateTime(1920),
          pickerTextStyle: const TextStyle(
            color: Palette.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          onChange: (index) {
            setState(() {
              _selectedDob = index;
            });
          },
          bottomPickerTheme: BottomPickerTheme.heavyRain,
        );
      },
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'Your date of birth?',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Palette.darkGreen),
                ),
              ),
              // Dob Widget
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 6,
                    child: Card(
                      elevation: 0,
                      color: Palette.textField,
                      surfaceTintColor: Palette.textField,
                      child: Center(
                        child: _selectedDob == null
                            ? Text(
                                DateFormat('dd').format(DateTime.now()),
                                style: const TextStyle(
                                  color: Palette.textFieldHeader,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Zen',
                                  fontSize: 52,
                                ),
                              )
                            : Text(
                                DateFormat('dd').format(_selectedDob!),
                                style: const TextStyle(
                                  color: Palette.darkGreen,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Zen',
                                  fontSize: 52,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Palette.textField,
                    surfaceTintColor: Palette.textField,
                    child: ListTile(
                      title: _selectedDob == null
                          ? Text(
                              DateFormat('MMMM / dd / yyyy')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                color: Palette.textFieldHeader,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Zen',
                              ),
                            )
                          : Text(
                              DateFormat('MMMM / dd / yyyy')
                                  .format(_selectedDob!),
                              style: const TextStyle(
                                color: Palette.darkGreen,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Zen',
                              ),
                            ),
                      trailing: IconButton(
                        onPressed: () {
                          _showDatePickerBottomSheet(context);
                        },
                        // icon: SvgPicture.asset(Svgs.calendar),
                        icon: const Icon(CustomIcons.calendar),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        GestureDetector(
          onTap: () {
            final dob = _selectedDob;

            if (_selectedDob == null) {
              showSnackbar(context, 'Please enter your date of birth!');
              return;
            }
            ref.read(createProfileProvider.notifier).addDob(context, dob!);
          },
          child: SvgPicture.asset(Svgs.thirtyPercent),
        ),
      ],
    );
  }
}
