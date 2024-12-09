import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/notifiers/loader_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/pickers.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({
    super.key,
  });

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  // -------------------------------------------------
  File? _selectedCover;
  // -------------------------------------------------
  final _eventTitleController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _eventVenueController = TextEditingController();
  final _latitudeVenueController = TextEditingController();
  final _longitudeVenueController = TextEditingController();
  // -------------------------------------------------
  DateTime? _eventDateTime;
  TimeOfDay? _eventTime;
  bool _isTimePickerEnabled = false;

  // -------------------------------------------------

  @override
  void dispose() {
    _eventTitleController.dispose();
    _eventDescriptionController.dispose();
    _eventVenueController.dispose();
    _latitudeVenueController.dispose();
    _longitudeVenueController.dispose();
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
            'Event Date',
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
              _eventDateTime = index;
              _isTimePickerEnabled = true;
            });
          },
          bottomPickerTheme: BottomPickerTheme.heavyRain,
        );
      },
    );
  }

  void _showTimePickerBottomSheet(BuildContext context) {
    if (!_isTimePickerEnabled) return;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Palette.white,
      builder: (BuildContext context) {
        return BottomPicker.time(
          closeIconColor: Palette.black,
          displayCloseIcon: true,
          pickerTitle: const Text(
            'Event Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          dismissable: true,
          height: MediaQuery.of(context).size.height * 0.3,
          backgroundColor: Palette.white,
          displaySubmitButton: false,
          // initialDateTime: _eventDateTime ?? DateTime.now(),
          pickerTextStyle: const TextStyle(
            color: Palette.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          onChange: (time) {
            setState(() {
              _eventTime = TimeOfDay.fromDateTime(time);
            });
          },
          bottomPickerTheme: BottomPickerTheme.heavyRain, initialTime: null,
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loaderProvider);
    return Skeletonizer(
      enabled: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Create Event',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 10, bottom: 10),
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Create'),
                ),
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
                // Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Event title',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Palette.textField,
                        surfaceTintColor: Palette.textField,
                        child: TextField(
                          controller: _eventTitleController,
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
                    ],
                  ),
                ),
                // Description
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Event description',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Palette.textField,
                        surfaceTintColor: Palette.textField,
                        child: TextField(
                          controller: _eventDescriptionController,
                          maxLines: 10,
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
                    ],
                  ),
                ),
                // DateTime
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Card(
                              elevation: 0,
                              color: Palette.textField,
                              surfaceTintColor: Palette.textField,
                              child: ListTile(
                                onTap: () {
                                  _showDatePickerBottomSheet(context);
                                },
                                contentPadding: const EdgeInsets.only(left: 16),
                                leading: const Icon(CustomIcons.calendar),
                                title: _eventDateTime == null
                                    ? null
                                    : Text(
                                        DateFormat('dd MMM yyy')
                                            .format(_eventDateTime!),
                                        style: const TextStyle(
                                          color: Palette.darkGreen,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Zen',
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Card(
                              elevation: 0,
                              color: Palette.textField,
                              surfaceTintColor: Palette.textField,
                              child: ListTile(
                                onTap: _isTimePickerEnabled
                                    ? () {
                                        _showTimePickerBottomSheet(context);
                                      }
                                    : null,
                                contentPadding: const EdgeInsets.only(left: 16),
                                leading: Icon(
                                  CustomIcons.time,
                                  color: _isTimePickerEnabled
                                      ? Colors.black
                                      : Colors.grey, // Indicate disabled state
                                ),
                                title: _eventTime == null
                                    ? null
                                    : Text(
                                        _eventTime!.format(context),
                                        style: const TextStyle(
                                          color: Palette.darkGreen,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Zen',
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
                // Location
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Venue',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Palette.textField,
                        surfaceTintColor: Palette.textField,
                        child: TextField(
                          controller: _eventVenueController,
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
                    ],
                  ),
                ),
                // Lat, Lon
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Latitude',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Card(
                              elevation: 0,
                              color: Palette.textField,
                              surfaceTintColor: Palette.textField,
                              child: TextField(
                                controller: _latitudeVenueController,
                                keyboardType: TextInputType.number,
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Longitude',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Card(
                              elevation: 0,
                              color: Palette.textField,
                              surfaceTintColor: Palette.textField,
                              child: TextField(
                                controller: _longitudeVenueController,
                                keyboardType: TextInputType.number,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Cover
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Event cover',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      AspectRatio(
                        aspectRatio: 16 / 6,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
