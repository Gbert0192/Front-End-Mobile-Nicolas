import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

// ParkingSpot model
class ParkingSpot {
  final String name;
  final String imageUrl;
  final int price;

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
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<ParkingSpot> spots = [
    ParkingSpot(
      name: 'Sun Plaza',
      imageUrl: 'assets/building/Sun Plaza.jpg',
      price: 3000,
    ),
    ParkingSpot(
      name: 'Centre Point',
      imageUrl: 'assets/building/Centre Point.jpeg',
      price: 2500,
    ),
    ParkingSpot(
      name: 'Aryaduta',
      imageUrl: 'assets/building/Aryaduta.jpg',
      price: 4000,
    ),
  ];

  void _nextSpot() {
    if (_currentIndex < spots.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _controller.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  void _prevSpot() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _controller.animateToPage(
        spots.length - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex = spots.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final currentSpot = spots[_currentIndex];
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.getCurrentUser();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: isSmall ? 12 : 20,
              right: isSmall ? 12 : 20,
              top: 20,
            ),
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
                            "Halo, ${user.fullname.split(" ")[0]}!",
                            style: TextStyle(
                              fontSize: isSmall ? 28 : 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F1E5B),
                              shadows: [
                                Shadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 6.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.247),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: isSmall ? 22 : 30,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F1E5B),
                              shadows: [
                                Shadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 6.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.247),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          user.profilePic != null
                              ? AssetImage(user.profilePic!)
                              : null,
                      radius: isSmall ? 40 : 70,
                      backgroundColor: Colors.grey[300],
                      child:
                          user.profilePic == null
                              ? Icon(
                                Icons.person,
                                size: isSmall ? 40 : 70,
                                color: Colors.grey[400],
                              )
                              : null,
                    ),
                  ],
                ),
                SizedBox(height: isSmall ? 5 : 10),

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
                                currencyFormat.format(user.balance),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmall ? 16 : 20,
                                  fontWeight: FontWeight.w800,
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
                SizedBox(height: isSmall ? 10 : 20),

                // RECENT SPOTS
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Recent Spots",
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F1E5B),
                      shadows: [
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 6.0,
                          color: Color.fromRGBO(0, 0, 0, 0.247),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: isSmall ? 160 : 260,
                  child: PageView.builder(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: spots.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(child: HistoryCarausel(spots[index]));
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _prevSpot,
                      icon: Icon(
                        Icons.arrow_circle_left,
                        size: isSmall ? 40 : 50,
                        color: Color(0xFF1F1E5B),
                      ),
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
                          "${currencyFormat.format(spots[_currentIndex].price)} / Hour",
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
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: isSmall ? 40 : 50,
                        color: Color(0xFF1F1E5B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryCarausel extends StatelessWidget {
  const HistoryCarausel(this.step, {super.key});
  final ParkingSpot step;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16),
      child: Container(
        width: double.infinity,
        height: isSmall ? 150 : 240,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(step.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
