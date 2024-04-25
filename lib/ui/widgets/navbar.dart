import 'package:flutter/material.dart';
import 'package:home_test_app/ui/pages/mapping_screen.dart';
import 'package:home_test_app/ui/pages/visualization_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int activeNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  // NAVIGATION CONTROLLER
  Widget getBody() {
    return IndexedStack(
      index: activeNav,
      children: const [
        MappingScreen(),
        VisualizationScreen(),
      ],
    );
  }

  // ICON CONTROLLER
  Widget getFooter() {
    List items = [
      Icons.map,
      Icons.view_sidebar_outlined,
    ];
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
              icon: Icon(
                items[index],
                color: activeNav == index ? Colors.white : Colors.orange[800],
              ),
              onPressed: () {
                setState(() {
                  activeNav = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }
}
