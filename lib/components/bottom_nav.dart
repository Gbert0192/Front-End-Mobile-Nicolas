import 'package:flutter/material.dart';

class ResponsiveBottomNav extends StatefulWidget {
  final List<Map<String, dynamic>> tabs;

  const ResponsiveBottomNav(this.tabs);

  @override
  State<ResponsiveBottomNav> createState() => _ResponsiveBottomNavState();
}

class _ResponsiveBottomNavState extends State<ResponsiveBottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.tabs.map((tab) => tab['screen'] as Widget).toList(),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.tabs.length, (index) {
            final tab = widget.tabs[index];
            final IconData icon = tab['icon'];
            final Color activeColor = tab['color'] ?? Colors.black;

            return IconButton(
              onPressed: () => _onItemTapped(index),
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  icon,
                  color: _selectedIndex == index ? activeColor : Colors.black,
                ),
              ),
              iconSize: 50,
            );
          }),
        ),
      ),
    );
  }
}
