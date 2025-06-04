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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                mall.image,
                width: 400,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              mall.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
