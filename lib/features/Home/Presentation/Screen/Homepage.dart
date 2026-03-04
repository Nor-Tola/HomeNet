import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/Controller/mqttController.dart';
import 'package:homecontrol/Model/TypeModel.dart';
import 'package:homecontrol/Model/devices-model.dart';
import 'package:homecontrol/Model/room_model.dart';
import 'package:homecontrol/Controller/ThemeController.dart';
import 'package:homecontrol/Data/widgetData.dart';
import 'package:homecontrol/features/Home/Presentation/Widgets/appbar_widget.dart';
import 'package:homecontrol/features/Home/Presentation/Widgets/card_widget.dart';
import 'package:homecontrol/Controller/roomController.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomProvider);
    final mqttDevices = ref.watch(mqttDevicesProvider);
    final allDevices = rooms
        .expand(
          (room) =>
              room.allDevice.map((device) => {'room': room, 'device': device}),
        )
        .toList();
    final activeCount = rooms
        .expand((room) => room.allDevice)
        .where((device) => device.isActive)
        .length;
    final mqttActive = mqttDevices.where((d) => d.isActive).length;

    // include mqtt devices in summary
    List<int> active = [activeCount + mqttActive, 0, 0];

    return Scaffold(
      appBar: appBarWidget(ref),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ----------- TOP SUMMARY GRID -----------
              SizedBox(
                height: 140,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) => cardWidget1(
                    active[index],
                    widgetList[index].name,
                    Colors.black,
                  ),
                ),
              ),

              SizedBox(
                height: 200,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widgetList1.length,
                  itemBuilder: (context, index) => cardWidget2(
                    widgetList1[index].number,
                    widgetList1[index].name,
                    widgetList1[index].icon,
                    Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Rooms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              /// ----------- ROOM FILTER LIST -----------
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listType.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(listType[index].icon, size: 20),
                              SizedBox(width: 5),
                              Text(
                                listType[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Devices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // grid for built‑in room devices
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                ),
                itemCount: allDevices.length,
                itemBuilder: (ctx, index) {
                  final room = allDevices[index]['room'] as RoomModel;
                  final item = allDevices[index]['device'] as Device;
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: 40),
                          SizedBox(height: 20),
                          Text('${room.name}'),
                          SizedBox(height: 20),
                          Text(item.name),
                          Switch(
                            value: item.isActive,
                            onChanged: (value) {
                              final updatedRooms = rooms.map((room) {
                                final updatedDevices = room.allDevice.map((d) {
                                  if (d.id == item.id) {
                                    return d.copyWith(isActive: value);
                                  }
                                  return d;
                                }).toList();

                                return room.copyWith(allDevice: updatedDevices);
                              }).toList();

                              ref.read(roomProvider.notifier).state =
                                  updatedRooms;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // mqtt devices section
              if (mqttDevices.isNotEmpty) ...[
                SizedBox(height: 20),
                Text(
                  'MQTT Devices',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: mqttDevices.length,
                  itemBuilder: (context, i) {
                    final item = mqttDevices[i];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 40),
                            SizedBox(height: 20),
                            Text(item.name),
                            SizedBox(height: 20),
                            Switch(
                              value: item.isActive,
                              onChanged: (value) {
                                final list = mqttDevices.map((d) {
                                  if (d.id == item.id) {
                                    return d.copyWith(isActive: value);
                                  }
                                  return d;
                                }).toList();
                                ref.read(mqttDevicesProvider.notifier).state = list;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),

      /// ----------- THEME BUTTON -----------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final themeNotifier = ref.read(themeProvider.notifier);

          if (themeNotifier.state.brightness == Brightness.light) {
            themeNotifier.state = ThemeData.dark();
          } else {
            themeNotifier.state = ThemeData.light();
          }
        },
        child: Icon(Icons.light_mode_outlined),
      ),
    );
  }
}
