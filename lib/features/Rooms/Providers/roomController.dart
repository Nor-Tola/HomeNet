      import 'package:flutter_riverpod/legacy.dart';
import 'package:homecontrol/features/Home/Model/room_model.dart';

final roomProvider = StateProvider<List<RoomModel>>((ref) => roomList);
