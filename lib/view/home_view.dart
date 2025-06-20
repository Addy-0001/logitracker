import 'package:flutter/material.dart';
import 'package:logitracker/features/delivery/presentation/view/assigned_delivery_view.dart';
import 'package:logitracker/features/delivery/presentation/view/map_view.dart';
import 'package:logitracker/view/dashboard_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> pageList = [
    DashboardView(),
    AssignedDeliveryView(),
    MapView(),
  ];

  int selectedIndex = 0;

  void setSelectedIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logitracker"),

        actions: [Icon(Icons.person_outlined, color: Colors.white, size: 40)],
        actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      ),
      body: IndexedStack(index: selectedIndex, children: pageList),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
