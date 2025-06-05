import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class SearchDetail extends StatelessWidget {
  final mall;

  const SearchDetail({super.key, required this.mall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    translate(
                      context,
                      'Parking Details',
                      'Detail Parkir',
                      '停车详情',
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  mall.image,
                  width: 400,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mall.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  Text(
                    mall.address,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF4D5DFA),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: Color(0xFF4D5DFA),
                            ),
                            SizedBox(width: 5),
                            Text(
                              mall.spotCount <= 0
                                  ? 'All Full'
                                  : mall.spotCount == 1
                                  ? '${mall.spotCount} Slot'
                                  : '${mall.spotCount} Slots',
                              style: TextStyle(
                                color: Color(0xFF4D5DFA),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF4D5DFA),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Color(0xFF4D5DFA)),
                            SizedBox(width: 5),
                            Text(
                              '${int.parse(mall.openTime.split(':')[0])} AM - ${int.parse(mall.closeTime.split(':')[0]) - 12} PM',
                              style: TextStyle(
                                color: Color(0xFF4D5DFA),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF4D5DFA),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Parking',
                          style: TextStyle(
                            color: Color(0xFF4D5DFA),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'It is a very famous shopping center in Medan. Not only a shopping center, but also home to many cafes and trendy dining places. The mall operates from ${mall.openTime} A.M. until ${mall.closeTime} P.M..',
                          style: TextStyle(
                            color: Color(0xFF908C8C),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Read More...',
                          style: TextStyle(
                            color: Color(0xFF4D5DFA),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
