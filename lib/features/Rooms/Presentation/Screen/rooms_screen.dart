import 'package:flutter/material.dart';
import 'package:homecontrol/features/Home/Model/room_model.dart';
import 'package:homecontrol/features/Rooms/Presentation/Widgets/room_card.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rooms',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            Text('Main Residence · ${roomList.length} rooms', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double cardWidth = constraints.maxWidth;
          const double cardHeight = 160; // adjust to match your card's content height
          final double aspectRatio = cardWidth / cardHeight;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: aspectRatio,
            ),
            itemCount: roomList.isEmpty ? 1 : roomList.length,
            itemBuilder: (context, index) {
              if (roomList.isEmpty) {
                return const Center(child: Text('No Devices Found'));
              }
              final data = roomList[index];
              return roomCard(
                RoomModel(
                  name: data.name,
                  icon: data.icon,
                  allDevice: data.allDevice,
                ),
              );
            },
          );
        },
      ),
    );
  }
}