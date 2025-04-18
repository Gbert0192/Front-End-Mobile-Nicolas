import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

// Root of the app
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// CircleIconButton widget
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Widget destination;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.destination,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
      icon: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: color),
      ),
      iconSize: 50,
    );
  }
}

// ParkingSpot model
class ParkingSpot {
  final String name;
  final String imageUrl;
  final String price;

  ParkingSpot({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

// Main HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<ParkingSpot> spots = [
    ParkingSpot(name: 'A', imageUrl: 'https://via.placeholder.com/300', price: 'Rp 3.000 / hour'),
    ParkingSpot(name: 'B', imageUrl: 'https://via.placeholder.com/300', price: 'Rp 2.500 / hour'),
    ParkingSpot(name: 'C', imageUrl: 'https://via.placeholder.com/300', price: 'Rp 4.000 / hour'),
  ];

  void _nextSpot() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % spots.length;
    });
  }

  void _prevSpot() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + spots.length) % spots.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSpot = spots[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Halo, Lisa!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),                                     // avatarrr
                    radius: 30,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Colors.white),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Balance", style: TextStyle(color: Colors.white)),                                 // balance
                            Text("Rp 1.000.000",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Text("+ Top Up", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Recent Spots",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    currentSpot.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: _prevSpot,
                      icon: const Icon(Icons.arrow_left, size: 36)),
                  Column(
                    children: [
                      Text(
                        currentSpot.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentSpot.price,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {},                                                                   //this thing the parking
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                        child: const Text("Get Parking Now"),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: _nextSpot,
                      icon: const Icon(Icons.arrow_right, size: 36)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                  children: const [
                    CircleIconButton(icon: Icons.home, color: Colors.deepOrange, destination: HomeScreen()),  // go to whatever
                    CircleIconButton(icon: Icons.notifications, destination: HomeScreen()),
                    CircleIconButton(icon: Icons.local_parking, destination: HomeScreen()),
                    CircleIconButton(icon: Icons.settings, destination: HomeScreen()),
                    CircleIconButton(icon: Icons.person, destination: HomeScreen()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

