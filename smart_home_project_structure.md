# 🏠 Smart Home Flutter — Project Structure (Riverpod)

---

## 📦 pubspec.yaml — Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # ── State Management ──────────────────────────
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  # ── Navigation ────────────────────────────────
  go_router: ^13.2.0

  # ── Networking ────────────────────────────────
  dio: ^5.4.3
  retrofit: ^4.1.0

  # ── MQTT (IoT) ────────────────────────────────
  mqtt_client: ^10.0.0

  # ── Local Storage ─────────────────────────────
  flutter_secure_storage: ^9.0.0
  hive_flutter: ^1.1.0

  # ── Push Notifications ────────────────────────
  firebase_messaging: ^14.9.0
  flutter_local_notifications: ^17.0.0

  # ── Charts ────────────────────────────────────
  fl_chart: ^0.67.0

  # ── Utilities ─────────────────────────────────
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  intl: ^0.19.0
  logger: ^2.3.0
  equatable: ^2.0.5

dev_dependencies:
  build_runner: ^2.4.8
  riverpod_generator: ^2.4.0
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  retrofit_generator: ^8.1.0
```

---

## 🗂️ Full Project Structure

```
lib/
│
├── main.dart                          # App entry point
├── app.dart                           # MaterialApp + Riverpod ProviderScope
│
├── core/                              # App-wide shared utilities
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   ├── app_sizes.dart
│   │   ├── api_endpoints.dart         # Base URL, all endpoint paths
│   │   └── mqtt_topics.dart           # MQTT topic builders
│   │
│   ├── network/
│   │   ├── dio_client.dart            # Dio setup + interceptors
│   │   ├── api_response.dart          # Generic ApiResponse<T> wrapper
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart  # Attach JWT token
│   │       └── error_interceptor.dart # Parse HTTP errors
│   │
│   ├── storage/
│   │   ├── secure_storage.dart        # Token storage (flutter_secure_storage)
│   │   └── hive_storage.dart          # Local cache (Hive)
│   │
│   ├── mqtt/
│   │   ├── mqtt_service.dart          # Connect, subscribe, publish
│   │   └── mqtt_topics.dart           # Topic string builders
│   │
│   ├── errors/
│   │   ├── app_exception.dart         # Custom exception types
│   │   └── error_handler.dart         # Map errors → user messages
│   │
│   ├── router/
│   │   ├── app_router.dart            # go_router config + all routes
│   │   └── route_names.dart           # Route name constants
│   │
│   └── utils/
│       ├── validators.dart
│       ├── date_formatter.dart
│       └── extensions.dart            # String, DateTime, etc. extensions
│
│
├── features/                          # Feature-first organization
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart            # @freezed + @JsonSerializable
│   │   │   │   ├── login_request.dart
│   │   │   │   └── auth_response.dart         # JWT + user data
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart  # Retrofit API calls
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart       # Calls datasource, maps errors
│   │   │
│   │   ├── providers/
│   │   │   ├── auth_provider.dart             # @riverpod AuthNotifier
│   │   │   └── auth_state.dart                # @freezed AuthState
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   └── register_screen.dart
│   │       └── widgets/
│   │           ├── auth_text_field.dart
│   │           └── social_login_button.dart
│   │
│   │
│   ├── homes/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── home_model.dart            # id, name, address, owner_id
│   │   │   │   └── home_member_model.dart     # user_id, role (admin/member/guest)
│   │   │   ├── datasources/
│   │   │   │   └── homes_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── homes_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── homes_provider.dart            # List<HomeModel>
│   │   │   ├── selected_home_provider.dart    # Currently active home
│   │   │   ├── home_members_provider.dart
│   │   │   └── homes_state.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── homes_list_screen.dart     # Select or add home
│   │       │   ├── create_home_screen.dart
│   │       │   └── manage_members_screen.dart
│   │       └── widgets/
│   │           ├── home_card.dart
│   │           └── member_tile.dart
│   │
│   │
│   ├── rooms/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── room_model.dart            # id, home_id, name, icon
│   │   │   ├── datasources/
│   │   │   │   └── rooms_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── rooms_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── rooms_provider.dart            # rooms by homeId
│   │   │   └── rooms_state.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── rooms_screen.dart          # Grid of all rooms
│   │       │   ├── room_detail_screen.dart    # Devices in a room
│   │       │   └── create_room_screen.dart
│   │       └── widgets/
│   │           ├── room_card.dart
│   │           └── room_device_summary.dart
│   │
│   │
│   ├── devices/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── device_model.dart          # id, room_id, type, status, power_state
│   │   │   │   ├── device_command_model.dart  # command_type, value, status
│   │   │   │   └── device_type.dart           # Enum: smartLight, fan, doorLock...
│   │   │   ├── datasources/
│   │   │   │   └── devices_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── devices_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── devices_provider.dart          # devices by roomId
│   │   │   ├── device_detail_provider.dart    # single device + its commands
│   │   │   ├── device_command_provider.dart   # send command + track status
│   │   │   ├── device_realtime_provider.dart  # MQTT stream → device state
│   │   │   └── devices_state.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── devices_screen.dart        # All devices list
│   │       │   └── device_detail_screen.dart  # Controls + chart + commands
│   │       └── widgets/
│   │           ├── device_card.dart           # On/off toggle + icon
│   │           ├── device_control_panel.dart  # Sliders, color picker, etc.
│   │           ├── command_history_list.dart
│   │           └── device_type_icon.dart      # Maps DeviceType → icon
│   │
│   │
│   ├── sensors/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── sensor_reading_model.dart  # device_id, value, unit, recorded_at
│   │   │   ├── datasources/
│   │   │   │   └── sensor_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── sensor_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── sensor_data_provider.dart      # time-series data for a device
│   │   │   └── live_sensor_provider.dart      # MQTT real-time stream
│   │   │
│   │   └── presentation/
│   │       └── widgets/
│   │           ├── sensor_chart.dart          # fl_chart line graph
│   │           ├── sensor_value_card.dart     # Temperature / Humidity badge
│   │           └── sensor_mini_sparkline.dart # Mini inline chart
│   │
│   │
│   ├── automations/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── automation_rule_model.dart # trigger, condition, action, is_active
│   │   │   ├── datasources/
│   │   │   │   └── automations_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── automations_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── automations_provider.dart      # List<AutomationRuleModel>
│   │   │   ├── toggle_rule_provider.dart      # Enable / disable a rule
│   │   │   └── automations_state.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── automations_screen.dart    # Rules list
│   │       │   └── create_rule_screen.dart    # Form: pick trigger + action
│   │       └── widgets/
│   │           ├── rule_card.dart             # IF → THEN flow display
│   │           └── condition_selector.dart    # Pick operator + value
│   │
│   │
│   ├── notifications/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── notification_model.dart    # user_id, message, type, is_read
│   │   │   ├── datasources/
│   │   │   │   └── notifications_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── notifications_repository.dart
│   │   │
│   │   ├── providers/
│   │   │   ├── notifications_provider.dart    # List<NotificationModel>
│   │   │   ├── unread_count_provider.dart     # Badge counter
│   │   │   └── mark_read_provider.dart
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── notifications_screen.dart
│   │       └── widgets/
│   │           ├── notification_tile.dart
│   │           └── notification_type_badge.dart
│   │
│   │
│   └── dashboard/
│       ├── providers/
│       │   └── dashboard_provider.dart        # Aggregates homes + rooms + devices
│       └── presentation/
│           ├── screens/
│           │   └── dashboard_screen.dart      # Main home screen
│           └── widgets/
│               ├── home_selector_bar.dart
│               ├── summary_strip.dart
│               ├── room_chip_row.dart
│               └── device_grid.dart
│
│
└── shared/                            # Reusable across ALL features
    ├── widgets/
    │   ├── app_scaffold.dart          # Common scaffold + bottom nav
    │   ├── app_button.dart
    │   ├── app_text_field.dart
    │   ├── app_loading.dart           # Shimmer / spinner
    │   ├── app_error_widget.dart      # Error state with retry
    │   ├── app_empty_widget.dart      # Empty state illustration
    │   ├── status_badge.dart          # Online / Offline / Pending
    │   ├── toggle_switch.dart         # Custom styled toggle
    │   └── bottom_nav_bar.dart
    │
    └── providers/
        ├── mqtt_provider.dart         # Global MQTT connection provider
        └── connectivity_provider.dart # Network status
```

---

## 🧩 Models (Freezed + JSON)

### `device_model.dart`
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required String id,
    required String roomId,
    required String name,
    required String type,        // 'smart_light', 'fan', 'door_lock', ...
    required String category,    // 'sensor' | 'actuator'
    required String mqttTopic,
    @Default('offline') String status,
    @Default(false) bool powerState,
    DateTime? lastSeen,
    Map<String, dynamic>? metadata,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
}
```

### `automation_rule_model.dart`
```dart
@freezed
class AutomationRuleModel with _$AutomationRuleModel {
  const factory AutomationRuleModel({
    required String id,
    required String homeId,
    required String name,
    required String triggerDeviceId,
    required Map<String, dynamic> condition,  // {"field":"temperature","operator":">","value":30}
    required String actionDeviceId,
    required Map<String, dynamic> actionValue, // {"command":"set_power","value":true}
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _AutomationRuleModel;

  factory AutomationRuleModel.fromJson(Map<String, dynamic> json) =>
      _$AutomationRuleModelFromJson(json);
}
```

### `notification_model.dart`
```dart
@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required String message,
    required String type,   // 'alert' | 'automation' | 'system'
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
```

---

## ⚡ Providers (Riverpod)

### `devices_provider.dart`
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'devices_provider.g.dart';

// Fetches devices for a given room
@riverpod
Future<List<DeviceModel>> devices(DevicesRef ref, String roomId) async {
  final repo = ref.watch(devicesRepositoryProvider);
  return repo.getDevices(roomId);
}

// Manages sending commands + tracking state
@riverpod
class DeviceCommand extends _$DeviceCommand {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> send(String deviceId, String commandType, dynamic value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(devicesRepositoryProvider);
      await repo.sendCommand(deviceId, commandType, value);
      // Invalidate device cache to refetch fresh state
      ref.invalidate(devicesProvider);
    });
  }
}
```

### `device_realtime_provider.dart`
```dart
// Listens to MQTT messages and updates device state in real time
@riverpod
Stream<DeviceModel> deviceRealtime(DeviceRealtimeRef ref, String deviceId) {
  final mqtt = ref.watch(mqttProvider);
  return mqtt.topicStream(deviceId).map((payload) =>
      DeviceModel.fromJson(jsonDecode(payload)));
}
```

### `auth_provider.dart`
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial()      = _Initial;
  const factory AuthState.loading()      = _Loading;
  const factory AuthState.authenticated(UserModel user) = _Authenticated;
  const factory AuthState.unauthenticated()              = _Unauthenticated;
  const factory AuthState.error(String message)          = _Error;
}

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(secureStorageProvider).deleteToken();
    state = const AuthState.unauthenticated();
  }
}
```

### `automations_provider.dart`
```dart
@riverpod
Future<List<AutomationRuleModel>> automations(
  AutomationsRef ref,
  String homeId,
) async {
  final repo = ref.watch(automationsRepositoryProvider);
  return repo.getRules(homeId);
}

@riverpod
class ToggleRule extends _$ToggleRule {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> toggle(String ruleId, bool isActive) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(automationsRepositoryProvider);
      await repo.toggleRule(ruleId, isActive);
      ref.invalidate(automationsProvider);
    });
  }
}
```

---

## 🖥️ Screens Summary

| Screen | Route | Provider(s) Used |
|--------|-------|-----------------|
| `SplashScreen` | `/` | `authProvider` |
| `LoginScreen` | `/login` | `authProvider` |
| `RegisterScreen` | `/register` | `authProvider` |
| `DashboardScreen` | `/dashboard` | `selectedHomeProvider`, `devicesProvider`, `sensorDataProvider` |
| `HomesListScreen` | `/homes` | `homesProvider` |
| `CreateHomeScreen` | `/homes/create` | — |
| `ManageMembersScreen` | `/homes/:id/members` | `homeMembersProvider` |
| `RoomsScreen` | `/rooms` | `roomsProvider` |
| `RoomDetailScreen` | `/rooms/:id` | `devicesProvider(roomId)` |
| `CreateRoomScreen` | `/rooms/create` | — |
| `DevicesScreen` | `/devices` | `devicesProvider` |
| `DeviceDetailScreen` | `/devices/:id` | `deviceDetailProvider`, `deviceRealtimeProvider`, `sensorDataProvider` |
| `AutomationsScreen` | `/automations` | `automationsProvider` |
| `CreateRuleScreen` | `/automations/create` | `devicesProvider` |
| `NotificationsScreen` | `/notifications` | `notificationsProvider`, `unreadCountProvider` |

---

## 🗺️ Router (go_router)

```dart
// core/router/app_router.dart
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth = authState is _Authenticated;
      final isLogin = state.matchedLocation == '/login';
      if (!isAuth && !isLogin) return '/login';
      if (isAuth && isLogin) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
          GoRoute(path: '/rooms', builder: (_, __) => const RoomsScreen()),
          GoRoute(path: '/rooms/:id', builder: (c, s) => RoomDetailScreen(roomId: s.pathParameters['id']!)),
          GoRoute(path: '/devices/:id', builder: (c, s) => DeviceDetailScreen(deviceId: s.pathParameters['id']!)),
          GoRoute(path: '/automations', builder: (_, __) => const AutomationsScreen()),
          GoRoute(path: '/automations/create', builder: (_, __) => const CreateRuleScreen()),
          GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
        ],
      ),
    ],
  );
}
```

---

## 🔄 Data Flow Diagram

```
  IoT Device (MQTT)
       │
       ▼
  mqtt_service.dart  ──────────────────────────────────────┐
       │                                                    │
       ▼                                                    ▼
  device_realtime_provider           Backend REST API (Dio)
       │                                    │
       ▼                                    ▼
  devices_provider              sensor_data_provider
       │                                    │
       ▼                                    ▼
  DeviceDetailScreen  ◄──────  dashboard_provider
       │
       ▼
  DeviceControlPanel → device_command_provider → POST /devices/:id/command
                                │
                                ▼
                         MQTT publish to device
```

---

## 🛠️ Layer Responsibilities

| Layer | Responsibility |
|-------|---------------|
| **Model** (`data/models/`) | Immutable data classes (Freezed + JSON). No logic. |
| **Datasource** (`data/datasources/`) | Raw API calls via Retrofit. Returns models or throws. |
| **Repository** (`data/repositories/`) | Orchestrates datasource + cache. Error mapping. |
| **Provider** (`providers/`) | Riverpod state. Exposes data/actions to UI. |
| **Screen** (`presentation/screens/`) | Reads providers via `ref.watch`. No business logic. |
| **Widget** (`presentation/widgets/`) | Pure UI components. Receive data as constructor params. |

---

*Smart Home IoT Flutter — Riverpod Architecture · Feb 2026*
