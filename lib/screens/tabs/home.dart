import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:intl/intl.dart';

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

// Main Home
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<ParkingSpot> spots = [
    ParkingSpot(
      name: 'Sun Plaza',
      imageUrl: 'assets/building/Sun Plaza.jpg',
      price: 'Rp 3.000 / hour',
    ),
    ParkingSpot(
      name: 'Centre Point',
      imageUrl: 'assets/building/Centre Point.jpeg',
      price: 'Rp 2.500 / hour',
    ),
    ParkingSpot(
      name: 'Aryaduta',
      imageUrl: 'assets/building/Aryaduta.jpg',
      price: 'Rp 4.000 / hour',
    ),
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
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final currentSpot = spots[_currentIndex];
    final userProvider = Provider.of<UserProvider>(context);
    Map<String, Object?> user = userProvider.getCurrentUser();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 20),
          child: Column(
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, ${(user['fullname'] ?? 'Guest').toString().split(" ")[0]}!",
                          // Text(
                          //   "Halo, ${(user['fullname'] as String).split(" ")[0]}!",
                          style: TextStyle(
                            fontSize: isSmall ? 28 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1F1E5B),
                          ),
                        ),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: isSmall ? 22 : 30,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F1E5B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage:
                        user['profile_pic'] != null
                            ? AssetImage(user['profile_pic'] as String)
                            : null,
                    radius: isSmall ? 40 : 40,
                    backgroundColor: Colors.grey[300],
                    child:
                        user['profile_pic'] == null
                            ? Icon(
                              Icons.person,
                              size: isSmall ? 40 : 60,
                              color: Colors.grey[400],
                            )
                            : null,
                  ),
                ],
              ),
              SizedBox(height: isSmall ? 10 : 20),

              Container(
                padding: EdgeInsets.all(isSmall ? 12 : 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1E5B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: isSmall ? 40 : 60,
                              height: isSmall ? 40 : 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/wallet.png',
                              width: isSmall ? 20 : 30,
                            ),
                          ],
                        ),
                        SizedBox(width: isSmall ? 10 : 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmall ? 16 : 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              currencyFormat.format(user['balance']),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmall ? 14 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: isSmall ? 24 : 30,
                        ),
                        Text(
                          "Top Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmall ? 12 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmall ? 10 : 20),

              // SEARCH
              ResponsiveTextInput(
                isSmall: isSmall,
                hint: "Search",
                leading: Icons.search,
              ),
              SizedBox(height: isSmall ? 20 : 30),

              // RECENT SPOTS
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Recent Spots",
                  style: TextStyle(
                    fontSize: isSmall ? 18 : 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F1E5B),
                  ),
                ),
              ),
              SizedBox(height: isSmall ? 10 : 20),

              Container(
                width: double.infinity,
                height: isSmall ? 150 : 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(currentSpot.imageUrl, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: isSmall ? 10 : 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _prevSpot,
                    icon: Icon(Icons.arrow_left, size: isSmall ? 24 : 30),
                  ),
                  Column(
                    children: [
                      Text(
                        currentSpot.name,
                        style: TextStyle(
                          fontSize: isSmall ? 16 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentSpot.price,
                        style: TextStyle(fontSize: isSmall ? 14 : 18),
                      ),
                      SizedBox(height: isSmall ? 6 : 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F1E5B),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Get Parking Now",
                          style: TextStyle(fontSize: isSmall ? 14 : 16),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _nextSpot,
                    icon: Icon(Icons.arrow_right, size: isSmall ? 24 : 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
