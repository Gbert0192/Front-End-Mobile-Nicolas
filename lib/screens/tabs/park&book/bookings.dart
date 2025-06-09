import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/bookingParking.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 10.0 : 15.0,
                  vertical: isSmall ? 10.0 : 15.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(18),
                              elevation: 1,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Booking',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F1E5B),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    ParkingCard(
                      imageUrl: 'assets/images/building/Sun Plaza.png',
                      priceText: 10000,
                      dateText: '12/12/2023',
                      placeName: 'Sun Plaza',
                      statusText: ParkingStatus.bookingCancel,
                    ),
                    ParkingCard(
                      imageUrl: 'assets/images/building/Aryaduta.png',
                      priceText: 10000,
                      dateText: 'Yesterday',
                      placeName: 'Arya Duta',
                      statusText: ParkingStatus.bookingExpired,
                    ),
                    ParkingCard(
                      imageUrl: 'assets/images/building/Delipark.png',
                      priceText: 10000,
                      dateText: '20/12/2023',
                      placeName: 'Delipark',
                      statusText: ParkingStatus.bookingExpired,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
