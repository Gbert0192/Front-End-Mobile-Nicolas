import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/notification.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/parking&booking.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/profile.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/voucher.dart';

class TabModel {
  final IconData icon;
  final Color color;
  final Widget screen;

  TabModel({
    required this.icon,
    required this.screen,
    this.color = Colors.white,
  });
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final List<TabModel> tabs = [
    TabModel(icon: Icons.home, screen: Home()),
    TabModel(icon: Icons.notifications, screen: Notification_()),
    TabModel(icon: Icons.local_parking, screen: ParkingHistory()),
    TabModel(icon: Icons.discount, screen: Voucher()),
    TabModel(icon: Icons.person, screen: Profile()),
  ];

  void initState() {
    controller = TabController(length: tabs.length, vsync: this);
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: tabs.map((tab) => tab.screen).toList(),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1E5B),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            tabs: List.generate(tabs.length, (index) {
              return Tab(
                icon: CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      controller.index == index
                          ? Color(0xFFDC5F00)
                          : Color(0xFF5064A5),
                  child: Icon(tabs[index].icon, color: tabs[index].color),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
