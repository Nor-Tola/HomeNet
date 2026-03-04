import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/Controller/roomController.dart';
import 'package:homecontrol/features/Rooms/Presentation/Widgets/room_card.dart';

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rooms',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Main Residence · ${rooms.length} rooms',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double cardWidth = constraints.maxWidth;
          const double cardHeight = 160;
          final double aspectRatio = cardWidth / cardHeight;

          if (rooms.isEmpty) {
            return const Center(
              child: Text('No Rooms Found'),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: aspectRatio,
            ),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final data = rooms[index];

              return roomCard(data); // ✅ no need to recreate model
            },
          );
        },
      ),
    );
  }
}