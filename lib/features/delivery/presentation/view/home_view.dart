import 'package:flutter/material.dart';
import 'assigned_delivery_view.dart';
import 'dashboard_view.dart';
import 'map_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> pageList = [
    const DashboardView(),
    const AssignedDeliveryView(),
    const MapView(),
  ];

  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logitracker"),
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon(Icons.person_outlined, color: Colors.white, size: 40),
          ),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pageList),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.punch_clock),
            label: "Assigned Deliveries",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        ],
        onTap: setSelectedIndex,
        currentIndex: selectedIndex,
      ),
    );
  }
}
