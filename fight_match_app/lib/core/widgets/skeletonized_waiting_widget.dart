import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../constants/palette.dart';

class SkeletonizedWaitingWIdget extends StatelessWidget {
  const SkeletonizedWaitingWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          backgroundColor: Palette.white,
          centerTitle: true,
          leading: const Icon(Icons.abc),
          title: const Text(
            'FIghtMatch',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.abc),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card.outlined(
                color: Palette.white,
                surfaceTintColor: Palette.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Header
                      const ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(
                          Icons.circle,
                          size: 40,
                        ),
                        title: Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '2 mins ago',
                              style:
                                  TextStyle(fontSize: 12, color: Palette.white),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    '●',
                                    style: TextStyle(
                                        fontSize: 8, color: Palette.white),
                                  ),
                                ),
                                Text(
                                  'Follow',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.more_vert),
                      ),
                      // Body
                      SizedBox(
                        child: Column(
                          children: [
                            const Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Palette.black,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Footer
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Icon(
                                      Icons.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.circle,
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.circle,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '900 Likes',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    '●',
                                    style: TextStyle(
                                        fontSize: 8, color: Palette.white),
                                  ),
                                ),
                                Text(
                                  '200 comments',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    '●',
                                    style: TextStyle(
                                        fontSize: 8, color: Palette.white),
                                  ),
                                ),
                                Text(
                                  '8 shares',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
