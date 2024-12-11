import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/features/chat/screens/chat_screen.dart';
import '../../../core/widgets/custom_regular_app_bar.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int _chatType = 0; // 0 = myChat; 1 = exploreChat

  void toggleChatType(int i) {
    setState(() {
      _chatType = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRegularAppBar(title: 'Inbox'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            // Header Buttons
            Card.filled(
              color: Palette.textField,
              surfaceTintColor: Palette.textField,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _chatType == 0
                          ? ElevatedButton(
                              onPressed: () => toggleChatType(0),
                              child: const Text('My Chat'),
                            )
                          : OutlinedButton(
                              onPressed: () => toggleChatType(0),
                              child: const Text('My Chat'),
                            ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _chatType == 1
                          ? ElevatedButton(
                              onPressed: () => toggleChatType(1),
                              child: const Text('Explore Chat'),
                            )
                          : OutlinedButton(
                              onPressed: () => toggleChatType(1),
                              child: const Text('Explore Chat'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            // My Chat
            _chatType == 0
                ? Expanded(
                    child: Column(
                      children: [
                        // Matches Chat
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Matches (9)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            navigate(
                                                context, const ChatScreen());
                                          },
                                          child: CircleAvatar(
                                            radius:
                                                30, // Reduced radius for better performance
                                            backgroundColor: Palette.black,
                                            child: CircleAvatar(
                                              radius: 28,
                                              backgroundColor: Palette.white,
                                              child: CircleAvatar(
                                                radius: 26,
                                                backgroundColor:
                                                    Palette.textField,
                                                backgroundImage: NetworkImage(
                                                  'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Recent Chat Placeholder
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Messages',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: ListTile(
                                        onTap: () {
                                          navigate(context, const ChatScreen());
                                        },
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 8),
                                        leading: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Palette.black,
                                            child: CircleAvatar(
                                              radius: 26,
                                              backgroundColor: Palette.white,
                                              child: CircleAvatar(
                                                radius: 24,
                                                backgroundColor:
                                                    Palette.textField,
                                                backgroundImage: NetworkImage(
                                                  'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          'Pheonix Fight Club',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Waiting for Match!!!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Palette.textFieldHeader,
                                              ),
                                        ),
                                        trailing: const Badge(
                                          backgroundColor: Palette.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                :
                // Explore Chat
                Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ListTile(
                            onTap: () {
                              navigate(context, const ChatScreen());
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            leading: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Palette.black,
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Palette.white,
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Palette.textField,
                                    backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/262333/pexels-photo-262333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              'Liberty Fight Club',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Where freedom meets fierce compitition in every round!!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textFieldHeader,
                                  ),
                            ),
                            trailing: const Badge(
                              backgroundColor: Palette.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
