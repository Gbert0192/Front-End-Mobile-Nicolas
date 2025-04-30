import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:tugas_front_end_nicolas/screens/parking.dart';

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
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final currentSpot = spots[_currentIndex];
    final userProvider = Provider.of<UserProvider>(context);
    Map<String, Object?> user = userProvider.getCurrentUser();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
                            "Halo, ${(user['fullname'] as String).split(" ")[0]}!",
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F1E5B),
                            ),
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F1E5B),
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
                      radius: screenWidth * 0.12,
                      backgroundColor: Colors.grey[300],
                      child:
                          user['profile_pic'] == null
                              ? Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey[400],
                              )
                              : null,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1E5B),
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
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/wallet.png',
                                width: screenWidth * 0.08,
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                currencyFormat.format(user['balance']),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.045,
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
                            size: screenWidth * 0.08,
                          ),
                          Text(
                            "Top Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // SEARCH
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      size: screenWidth * 0.08,
                      color: Color(0xFF1F1E5B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF1F1E5B)),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // RECENT SPOTS
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Spots",
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1E5B),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(currentSpot.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),

                // ARROW + SPOT INFO
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _prevSpot,
                      icon: Icon(Icons.arrow_left, size: screenWidth * 0.08),
                    ),
                    Column(
                      children: [
                        Text(
                          currentSpot.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentSpot.price,
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1F1E5B),
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Get Parking Now"),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _nextSpot,
                      icon: Icon(Icons.arrow_right, size: screenWidth * 0.08),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // BOTTOM NAVIGATION BAR
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1E5B),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CircleIconButton(
                        icon: Icons.home,
                        color: Colors.deepOrange,
                        destination: HomeScreen(),
                      ),
                      CircleIconButton(
                        icon: Icons.notifications,
                        destination: HomeScreen(),
                      ),
                      CircleIconButton(
                        icon: Icons.local_parking,
                        destination: Parking(),
                      ),
                      CircleIconButton(
                        icon: Icons.discount,
                        destination: HomeScreen(),
                      ),
                      CircleIconButton(
                        icon: Icons.person,
                        destination: HomeScreen(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
