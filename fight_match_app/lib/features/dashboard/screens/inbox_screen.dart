import '../../../core/widgets/custom_regular_app_bar.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomRegularAppBar(title: 'Inbox'),
    );
  }
}
