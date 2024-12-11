import 'package:fight_match_app/core/constants/icons.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(CustomIcons.back),
            ),
            const SizedBox(width: 16),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Palette.black,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Palette.white,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.textField,
                  backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/262333/pexels-photo-262333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Jonathan')
          ],
        ),
        actions: [
          const Icon(CustomIcons.audioCall),
          const SizedBox(width: 16),
          const Icon(CustomIcons.videoCall),
          const SizedBox(width: 16),
          const Icon(CustomIcons.moreVert),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            // Chat Area
            const Expanded(child: SizedBox()),
            // Input Area
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Icon(
                    CustomIcons.attachment,
                    size: 40,
                  ),
                  Expanded(
                    child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          CustomIcons.arrowUp,
                          size: 40,
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Palette.textFieldHeader),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Palette.textFieldHeader),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Palette.textFieldHeader),
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
    );
  }
}
