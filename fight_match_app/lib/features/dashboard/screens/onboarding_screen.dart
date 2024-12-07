// import 'dart:io';

// import 'package:bottom_picker/bottom_picker.dart';
// import 'package:bottom_picker/resources/arrays.dart';
// import '../../../core/notifiers/loader_notifier.dart';
// import '../../../core/utils/snackbar.dart';
// import '../../auth/notifiers/auth_notifier.dart';
// import '../notifiers/profile_notifier.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import '../../../core/constants/svgs.dart';
// import '../../../core/utils/pickers.dart';

// class OnboardingScreen extends ConsumerStatefulWidget {
//   const OnboardingScreen({
//     super.key,
//   });

//   @override
//   ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
//   // -------------------------------------------------
//   final fullNameController = TextEditingController();
//   // -------------------------------------------------
//   int? _selectedGender;
//   void setGender(int i) {
//     setState(() {
//       _selectedGender = i;
//     });
//   }

//   // -------------------------------------------------
//   DateTime? _selectedDob;
//   // -------------------------------------------------
//   final professionController = TextEditingController();
//   // -------------------------------------------------
//   final _countryController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _zipController = TextEditingController();
//   // -------------------------------------------------
//   File? _selectedProfileImage;
//   File? _selectedCoverImage;
//   // -------------------------------------------------

//   @override
//   void dispose() {
//     fullNameController.dispose();
//     professionController.dispose();
//     _countryController.dispose();
//     _stateController.dispose();
//     _cityController.dispose();
//     _zipController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _showDatePickerBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       backgroundColor: Colors.white,
//       builder: (BuildContext context) {
//         return BottomPicker.date(
//           displayCloseIcon: false,
//           pickerTitle: const Text(
//             '',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//           dismissable: true,
//           height: MediaQuery.of(context).size.height * 0.3,
//           backgroundColor: const Color(0xFFf7f7f7),
//           displaySubmitButton: false,
//           dateOrder: DatePickerDateOrder.dmy,
//           initialDateTime: DateTime.now(),
//           maxDateTime: DateTime.now(),
//           minDateTime: DateTime(1920),
//           pickerTextStyle: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//           onChange: (index) {
//             setState(() {
//               _selectedDob = index;
//             });
//           },
//           bottomPickerTheme: BottomPickerTheme.heavyRain,
//         );
//       },
//     );
//   }

//   Future<void> onPickCover() async {
//     File? image = await openGalleryLegacy();
//     if (image != null) {
//       setState(() {
//         _selectedCoverImage = image;
//       });
//     }
//   }

//   Future<void> onPickImage() async {
//     File? image = await openGalleryLegacy();
//     if (image != null) {
//       setState(() {
//         _selectedProfileImage = image;
//       });
//     }
//   }

//   //createProfile
//   Future<void> createProfile() async {
//     if (_selectedProfileImage == null ||
//         fullNameController.text.trim().isEmpty ||
//         professionController.text.trim().isEmpty ||
//         _selectedGender == null ||
//         _selectedDob == null ||
//         _countryController.text.trim().isEmpty ||
//         _stateController.text.trim().isEmpty ||
//         _zipController.text.trim().isEmpty) {
//       showSnackbar(context, "Please fill in all required fields.");
//       return;
//     }
//     final auth = ref.read(authProvider);
//     ref.read(profileProvider.notifier).createProfile(
//           context: context,
//           userId: auth!.userId,
//           userName: auth.userName,
//           jwt: auth.jwt,
//           coverPhoto: _selectedCoverImage,
//           profilePhoto: _selectedProfileImage,
//           fullName: fullNameController.text.trim(),
//           profession: professionController.text.trim(),
//           gender: _selectedGender == 1 ? 'Male' : 'Female',
//           dob: _selectedDob!,
//           country: _countryController.text.trim(),
//           geoState: _stateController.text.trim(),
//           city: _cityController.text.trim(),
//           zipCode: _zipController.text.trim(),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = ref.watch(loaderProvider);
//     return Skeletonizer(
//       enabled: isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           title: Text(
//             'Create Profile',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: TextButton(
//                 onPressed: createProfile,
//                 style: TextButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     side: const BorderSide(color: Colors.black, width: 2),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 child: Text(
//                   'Submit',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Image Widget
//                 Stack(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: GestureDetector(
//                         onTap: onPickCover,
//                         child: Card(
//                           elevation: 0,
//                           color: const Color(0xFFf7f7f7),
//                           surfaceTintColor: const Color(0xFFf7f7f7),
//                           child: _selectedCoverImage == null
//                               ? const Center(
//                                   child:
//                                       Icon(Icons.add_photo_alternate_outlined),
//                                 )
//                               : ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image.file(
//                                     _selectedCoverImage!,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 10,
//                       bottom: 10,
//                       child: GestureDetector(
//                         onTap: onPickImage,
//                         child: SizedBox(
//                           height: 100,
//                           width: 100,
//                           child: Card(
//                             elevation: 5,
//                             color: const Color(0xFFf7f7f7),
//                             surfaceTintColor: const Color(0xFFf7f7f7),
//                             child: _selectedProfileImage == null
//                                 ? const Center(
//                                     child: Icon(Icons.photo_outlined),
//                                   )
//                                 : ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.file(
//                                       _selectedProfileImage!,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Name WIdget
//                 Card(
//                   elevation: 0,
//                   color: const Color(0xFFf7f7f7),
//                   surfaceTintColor: const Color(0xFFf7f7f7),
//                   child: TextField(
//                     controller: fullNameController,
//                     onTapOutside: (event) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Aileron',
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                     decoration: const InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                       hintText: 'Full name',
//                       hintStyle: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'Aileron',
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF666666),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 // Profession WIdget
//                 Card(
//                   elevation: 0,
//                   color: const Color(0xFFf7f7f7),
//                   surfaceTintColor: const Color(0xFFf7f7f7),
//                   child: TextField(
//                     controller: professionController,
//                     onTapOutside: (event) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Aileron',
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                     decoration: const InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                       hintText: 'Profession',
//                       hintStyle: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'Aileron',
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF666666),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 // Gender Widget
//                 AspectRatio(
//                   aspectRatio: 16 / 5,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             setGender(1);
//                           },
//                           child: Card(
//                             elevation: 0,
//                             color: _selectedGender == 1
//                                 ? const Color(0xFF173430)
//                                 : const Color(0xFFf6f7f7),
//                             surfaceTintColor: const Color(0xFF173430),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SvgPicture.asset(
//                                     Svgs.male,
//                                     height: 40,
//                                     colorFilter: ColorFilter.mode(
//                                         _selectedGender == 1
//                                             ? Colors.white
//                                             : Colors.black,
//                                         BlendMode.srcIn),
//                                   ),
//                                   Text(
//                                     'Male',
//                                     style: TextStyle(
//                                       color: _selectedGender == 1
//                                           ? Colors.white
//                                           : const Color(0xFF617d79),
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Zen',
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             setGender(0);
//                           },
//                           child: Card(
//                             elevation: 0,
//                             color: _selectedGender == 0
//                                 ? const Color(0xFF173430)
//                                 : const Color(0xFFf6f7f7),
//                             surfaceTintColor: const Color(0xFF173430),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SvgPicture.asset(
//                                     Svgs.female,
//                                     height: 40,
//                                     colorFilter: ColorFilter.mode(
//                                         _selectedGender == 0
//                                             ? Colors.white
//                                             : Colors.black,
//                                         BlendMode.srcIn),
//                                   ),
//                                   Text(
//                                     'Female',
//                                     style: TextStyle(
//                                       color: _selectedGender == 0
//                                           ? Colors.white
//                                           : const Color(0xFF617d79),
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Zen',
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Dob Widget
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     AspectRatio(
//                       aspectRatio: 16 / 5,
//                       child: Card(
//                         elevation: 0,
//                         color: const Color(0xFFf7f7f7),
//                         surfaceTintColor: const Color(0xFFf7f7f7),
//                         child: Center(
//                           child: _selectedDob == null
//                               ? Text(
//                                   DateFormat('dd').format(DateTime.now()),
//                                   style: const TextStyle(
//                                     color: Color(0xFF617d79),
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Zen',
//                                     fontSize: 52,
//                                   ),
//                                 )
//                               : Text(
//                                   DateFormat('dd').format(_selectedDob!),
//                                   style: const TextStyle(
//                                     color: Color(0xFF143030),
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Zen',
//                                     fontSize: 52,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                     Card(
//                       elevation: 0,
//                       color: const Color(0xFFf7f7f7),
//                       surfaceTintColor: const Color(0xFFf7f7f7),
//                       child: ListTile(
//                         title: _selectedDob == null
//                             ? Text(
//                                 DateFormat('MMMM / dd / yyyy')
//                                     .format(DateTime.now()),
//                                 style: const TextStyle(
//                                   color: Color(0xFF617d79),
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Zen',
//                                 ),
//                               )
//                             : Text(
//                                 DateFormat('MMMM / dd / yyyy')
//                                     .format(_selectedDob!),
//                                 style: const TextStyle(
//                                   color: Color(0xFF143030),
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Zen',
//                                 ),
//                               ),
//                         trailing: IconButton(
//                           onPressed: () {
//                             _showDatePickerBottomSheet(context);
//                           },
//                           icon: SvgPicture.asset(Svgs.calendar),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Location Picker Widget
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Card(
//                             elevation: 0,
//                             color: const Color(0xFFf7f7f7),
//                             surfaceTintColor: const Color(0xFFf7f7f7),
//                             child: TextField(
//                               controller: _countryController,
//                               onTapOutside: (event) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                               },
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: 'Aileron',
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 12),
//                                 hintText: 'Country',
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Aileron',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF666666),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Card(
//                             elevation: 0,
//                             color: const Color(0xFFf7f7f7),
//                             surfaceTintColor: const Color(0xFFf7f7f7),
//                             child: TextField(
//                               controller: _stateController,
//                               onTapOutside: (event) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                               },
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: 'Aileron',
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 12),
//                                 hintText: 'State',
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Aileron',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF666666),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Card(
//                             elevation: 0,
//                             color: const Color(0xFFf7f7f7),
//                             surfaceTintColor: const Color(0xFFf7f7f7),
//                             child: TextField(
//                               controller: _cityController,
//                               onTapOutside: (event) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                               },
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: 'Aileron',
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 12),
//                                 hintText: 'City',
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Aileron',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF666666),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Card(
//                             elevation: 0,
//                             color: const Color(0xFFf7f7f7),
//                             surfaceTintColor: const Color(0xFFf7f7f7),
//                             child: TextField(
//                               controller: _zipController,
//                               onTapOutside: (event) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                               },
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: 'Aileron',
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 12),
//                                 hintText: 'zip code',
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Aileron',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF666666),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
