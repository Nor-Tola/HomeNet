import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecontrol/features/Auth/presentation/Screen/login_screen.dart';
import 'package:homecontrol/features/Auth/presentation/Screen/signup_screen.dart';
import 'package:homecontrol/features/Home/Presentation/Screen/Homepage.dart';
import 'package:homecontrol/features/Rooms/Presentation/Screen/rooms_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends ConsumerStatefulWidget {
 const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late final PersistentTabController tabController;

  final List<Widget> pages = [
    Homepage(),
    RoomsScreen(),
    LoginScreen(),
    SignupScreen()
  ];

  final List<PersistentBottomNavBarItem> navItems = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.grid_view_rounded),
      title: 'Home',
      activeColorPrimary: Color(0xFF4F8CFF),
      inactiveColorPrimary: Color(0xFF6B7080),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.meeting_room_rounded),
      title: 'Rooms',
      activeColorPrimary: Color(0xFF4F8CFF),
      inactiveColorPrimary: Color(0xFF6B7080),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.bolt_rounded),
      title: 'Automations',
      activeColorPrimary: Color(0xFF4F8CFF),
      inactiveColorPrimary: Color(0xFF6B7080),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.settings),
      title: 'Setting',
      activeColorPrimary: Color(0xFF4F8CFF),
      inactiveColorPrimary: Color(0xFF6B7080),
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: PersistentTabView(
      context,
      controller: tabController,
      screens: pages,
      items: navItems,
      navBarStyle: NavBarStyle.style3, 
      ) 
    );
  }
}