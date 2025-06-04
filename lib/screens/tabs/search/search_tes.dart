import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Mall {
  final String name;
  final String address;
  final String image;
  final num price;
  final num slot;

  Mall({
    required this.name,
    required this.address,
    required this.image,
    required this.price,
    required this.slot,
  });
}

final allMall = [
  Mall(
    name: 'Sun Plaza',
    address: 'Jl. KH. Zainul Arifin No. 7',
    image: 'assets/images/building/Sun Plaza.png',
    price: 3000,
    slot: 8,
  ),
  Mall(
    name: 'Center Point',
    address: 'Jl. Jawa No. 8,',
    image: 'assets/images/building/Centre Point.png',
    price: 3000,
    slot: 9,
  ),
  Mall(
    name: 'Manhattan Time Square',
    address: 'Jl. Gatot Subroto No. 217',
    image: 'assets/images/building/Manhatan Time Square.png',
    price: 3000,
    slot: 1,
  ),
  Mall(
    name: 'Delipark',
    address: 'Jl. Putri Hijau Dalam No. 1',
    image: 'assets/images/building/Delipark.png',
    price: 5000,
    slot: 4,
  ),
  Mall(
    name: 'Plaza Medan Fair',
    address: 'Jl. Gatot Subroto No. 30',
    image: 'assets/images/building/Plaza Medan Fair.png',
    price: 4000,
    slot: 0,
  ),
  Mall(
    name: 'Lippo Plaza',
    address: 'Jl. Imam Bonjol No. 6',
    image: 'assets/images/building/Lippo Plaza.png',
    price: 3500,
    slot: 1,
  ),
  Mall(
    name: 'Aryaduta',
    address: 'Jl. Kapten Maulana Lubis No. 8',
    image: 'assets/images/building/Aryaduta.png',
    price: 3500,
    slot: 2,
  ),
  Mall(
    name: 'Medan Mall',
    address: 'Jl. Balai Kota No. 1',
    image: 'assets/images/building/Medan Mall.png',
    price: 5000,
    slot: 3,
  ),
  Mall(
    name: 'Grand City Hall',
    address: 'Jl. Balai Kota No. 1',
    image: 'assets/images/building/Grand City Hall.png',
    price: 4000,
    slot: 10,
  ),
  Mall(
    name: 'Radisson Medan',
    address: 'Jl. H. Adam Malik No. 5',
    image: 'assets/images/building/Radisson.png',
    price: 4000,
    slot: 1,
  ),
];

class SearchTes extends StatefulWidget {
  const SearchTes({super.key});

  @override
  State<SearchTes> createState() => _SearchTesState();
}

class _SearchTesState extends State<SearchTes> {
  final controller = TextEditingController();
  List<Mall> malls = allMall;
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
                  const Text(
                    'Where To Park ?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: translate(context, 'Search', 'Telusuri', '搜索'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF1F1E5B)),
                  ),
                ),
                onChanged: searchMall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: malls.length,
                itemBuilder: (context, index) {
                  final mall = malls[index];

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          mall.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              mall.name,
                              style: TextStyle(
                                color: Color(0xFF1F1E5B),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0x46DC5F00),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              mall.slot <= 0
                                  ? 'All Full'
                                  : mall.slot == 1
                                  ? '${mall.slot} Slot'
                                  : '${mall.slot} Slots',
                              style: TextStyle(color: Color(0xFFDC5F00)),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(mall.address),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                formatCurrency(nominal: mall.price),
                                style: TextStyle(
                                  color: Color(0xFFDC5F00),
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '/hour',
                                style: TextStyle(
                                  color: Color(0xFFDC5F00),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void searchMall(String query) {
  final suggestions =
      allMall.where((mall) {
        final mallName = mall.name.toLowerCase();
        final input = query.toLowerCase();

        return mallName.contains(input);
      }).toList();
  // setState(() => malls = suggestions);
}
