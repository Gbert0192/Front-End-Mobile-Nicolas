import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/search/search_detail.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/provider/parking_lot_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
  List<ParkingLot>? resultLots;

  void searchMall(ParkingLotProvider provider, String query, int userId) {
    final lots = provider.searchLot(userId, query);
    setState(() {
      resultLots = lots;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = 1;
    final lotProvider = Provider.of<ParkingLotProvider>(context);
    final malls = resultLots ?? lotProvider.lots;

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
                      'Where To Park ?',
                      'Parkir Dimana?',
                      '在哪里停车？',
                    ),
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                      searchMall(lotProvider, '', userId);
                    },
                    icon: Icon(Icons.clear),
                  ),
                  hintText: translate(context, 'Search', 'Telusuri', '搜索'),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF1F1E5B)),
                  ),
                ),
                onSubmitted: (value) => searchMall(lotProvider, value, userId),
              ),
            ),
            Text(
              controller.text.isEmpty
                  ? translate(context, 'Recent', 'Terkini', '最近')
                  : translate(
                    context,
                    'Search Result',
                    'Hasil Pencarian',
                    '搜索结果',
                  ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child:
                  malls.isEmpty
                      ? Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/empty/search_where.png',
                              width: 400,
                              height: 400,
                            ),
                            Text(
                              translate(
                                context,
                                'Search not found',
                                'Pencarian tidak ditemukan',
                                '搜索没找到',
                              ),
                              style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: malls.length,
                        itemBuilder: (context, index) {
                          final mall = malls[index];

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      mall.name,
                                      style: TextStyle(
                                        color: Color(0xFF1F1E5B),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
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
                                      mall.spotCount <= 0
                                          ? 'All Full'
                                          : mall.spotCount == 1
                                          ? '${mall.spotCount} Slot'
                                          : '${mall.spotCount} Slots',
                                      style: TextStyle(
                                        color: Color(0xFFDC5F00),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    mall.address,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Text(
                                        formatCurrency(
                                          nominal: mall.starterPrice ?? 0,
                                        ),

                                        style: TextStyle(
                                          color: Color(0xFFDC5F00),
                                          fontSize: 16,
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
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => SearchDetail(mall: mall),
                                    ),
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
