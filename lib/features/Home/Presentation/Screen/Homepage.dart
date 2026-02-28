import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/features/Home/Providers/ActiveDeviceController.dart';
import 'package:homecontrol/features/Home/Providers/ThemeController.dart';
import 'package:homecontrol/features/Home/Data/widgetData.dart';
import 'package:homecontrol/features/Home/Model/TypeModel.dart';
import 'package:homecontrol/features/Home/Presentation/Widgets/appbar_widget.dart';
import 'package:homecontrol/features/Home/Presentation/Widgets/card_widget.dart';
import 'package:homecontrol/features/Rooms/Providers/roomController.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomProvider);
    final allDevices = rooms
        .where((room) => room.isOn)
        .expand((room) => room.allDevice)
        .toList();
    final activeCount = ref.watch(activeDeviceCountProvider);

    List<int> active = [activeCount, 0, 0];

    return Scaffold(
      appBar: appBarWidget(ref),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
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
              Container(
                width: double.infinity,
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
              Text(
                'Rooms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listType.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(listType[index].icon, size: 20),
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
              Text(
                'Devices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: allDevices.length,
                  itemBuilder: (context, index) {
                    final item = allDevices[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            Text(item.name),
                            Switch(
                              value: item.isActive,
                              onChanged: (value) {
                                final updatedRooms = rooms.map((room) {
                                  final updatedDevices = room.allDevice.map((
                                    d,
                                  ) {
                                    if (d.name == item.name) {
                                      return d.copyWith(isActive: value);
                                    }
                                    return d;
                                  }).toList();

                                  return room.copyWith(
                                    allDevice: updatedDevices,
                                  );
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final isLight = ref.read(themeProvider.notifier);
          if (isLight.state.brightness == Brightness.light) {
            ref.read(themeProvider.notifier).state = ThemeData.dark();
          } else {
            ref.read(themeProvider.notifier).state = ThemeData.light();
          }
        },
        child: Icon(Icons.light_mode_outlined),
      ),
    );
  }
}
