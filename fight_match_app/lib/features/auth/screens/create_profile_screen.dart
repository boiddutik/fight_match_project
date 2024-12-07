import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/notifiers/loader_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../notifiers/auth_notifier.dart';

import '../../../core/constants/svgs.dart';
import '../../../core/utils/pickers.dart';
import '../../../core/utils/snackbar.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;
  const CreateProfileScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  // -------------------------------------------------
  final fullNameController = TextEditingController();
  // -------------------------------------------------
  int? _selectedGender;
  void setGender(int i) {
    setState(() {
      _selectedGender = i;
    });
  }

  // -------------------------------------------------
  DateTime? _selectedDob;
  // -------------------------------------------------
  final professionController = TextEditingController();
  // -------------------------------------------------
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  // -------------------------------------------------
  File? _selectedAvatar;
  File? _selectedCover;
  // -------------------------------------------------

  @override
  void dispose() {
    fullNameController.dispose();
    professionController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

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

  Future<void> onPickCover() async {
    File? image = await openGalleryLegacy();
    if (image != null) {
      setState(() {
        _selectedCover = image;
      });
    }
  }

  Future<void> onPickAvatar() async {
    File? image = await openGalleryLegacy();
    if (image != null) {
      setState(() {
        _selectedAvatar = image;
      });
    }
  }

  //createProfile
  Future<void> createProfile() async {
    // Ensure all required fields are filled
    if (_selectedAvatar == null ||
        fullNameController.text.trim().isEmpty ||
        professionController.text.trim().isEmpty ||
        _selectedGender == null ||
        _selectedDob == null ||
        _countryController.text.trim().isEmpty ||
        _stateController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty) {
      showSnackbar(context, "Please fill in all required fields.");
      return;
    }

    // Collect the field values
    final String email = widget.email;
    final String password = widget.password;
    final String profession = professionController.text.trim();
    final String fullName = fullNameController.text.trim();
    final String gender = _selectedGender == 0 ? 'Female' : 'Male';
    final String country = _countryController.text.trim();
    final String geoState = _stateController.text.trim();
    final String city = _cityController.text.trim();
    final DateTime dob = _selectedDob!;
    final File avatar = _selectedAvatar!;
    final File? cover = _selectedCover;
    ref.read(authProvider.notifier).createUser(
          context: context,
          email: email,
          password: password,
          profession: profession,
          fullName: fullName,
          gender: gender,
          country: country,
          geoState: geoState,
          city: city,
          dob: dob,
          avatar: avatar,
          cover: cover,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loaderProvider);
    return Skeletonizer(
      enabled: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Profile',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: createProfile,
              child: SvgPicture.asset(
                Svgs.go,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Widget
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: GestureDetector(
                        onTap: onPickCover,
                        child: Card(
                          elevation: 0,
                          color: Palette.textField,
                          surfaceTintColor: Palette.textField,
                          child: _selectedCover == null
                              ? const Center(
                                  child: Icon(CustomIcons.cover),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    _selectedCover!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: onPickAvatar,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Card(
                            elevation: 5,
                            color: Palette.textField,
                            surfaceTintColor: Palette.textField,
                            child: _selectedAvatar == null
                                ? const Center(
                                    child: Icon(CustomIcons.avatar),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      _selectedAvatar!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Name WIdget
                Card(
                  elevation: 0,
                  color: Palette.textField,
                  surfaceTintColor: Palette.textField,
                  child: TextField(
                    controller: fullNameController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Aileron',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: 'Full name',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Aileron',
                        fontWeight: FontWeight.w600,
                        color: Palette.textFieldHeader,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Profession WIdget
                Card(
                  elevation: 0,
                  color: Palette.textField,
                  surfaceTintColor: Palette.textField,
                  child: TextField(
                    controller: professionController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Aileron',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: 'Profession',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Aileron',
                        fontWeight: FontWeight.w600,
                        color: Palette.textFieldHeader,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Gender Widget
                AspectRatio(
                  aspectRatio: 16 / 6,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                // Location Picker Widget
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: Palette.textField,
                            surfaceTintColor: Palette.textField,
                            child: TextField(
                              controller: _countryController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Aileron',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: 'Country',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Aileron',
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textFieldHeader,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: Palette.textField,
                            surfaceTintColor: Palette.textField,
                            child: TextField(
                              controller: _stateController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Aileron',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: 'State',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Aileron',
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textFieldHeader,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: Palette.textField,
                            surfaceTintColor: Palette.textField,
                            child: TextField(
                              controller: _cityController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Aileron',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: 'City',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Aileron',
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textFieldHeader,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
