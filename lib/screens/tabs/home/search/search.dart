import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/parking_lot/lot_detail.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/provider/parking_lot_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
  bool isSubmited = false;
  bool isLoading = false;
  List<ParkingLot>? resultLots;

  Future<void> searchMall(
    ParkingLotProvider provider,
    String query,
    User user,
  ) async {
    setState(() {
      isLoading = true;
    });

    // Simulate network delay for better UX
    await Future.delayed(Duration(milliseconds: 800));

    final lots = provider.searchLot(user, query);

    setState(() {
      resultLots = lots;
      isLoading = false;
      isSubmited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final lotProvider = Provider.of<ParkingLotProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.currentUser!;
    final malls =
        (controller.text.isEmpty) ? lotProvider.lots : resultLots ?? [];
    final history = lotProvider.loadHistory(user)?.searchHistory ?? [];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 30),
                    ),
                    Text(
                      translate(
                        context,
                        'Where To Park ?',
                        'Parkir Dimana?',
                        '在哪里停车？',
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ResponsiveTextInput(
                isSmall: isSmall,
                controller: controller,
                leading: Icons.search,
                hint: translate(context, 'Search', 'Telusuri', '搜索'),
                disabled: isLoading,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) async {
                  if (controller.text.isNotEmpty && !isLoading) {
                    await searchMall(lotProvider, value, user);
                  }
                },
                suffix:
                    isLoading
                        ? Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey,
                            ),
                          ),
                        )
                        : controller.text.isNotEmpty
                        ? Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              controller.clear();
                              setState(() {
                                isSubmited = false;
                                resultLots = null;
                              });
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        )
                        : null,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isSubmited
                        ? translate(
                          context,
                          'Search Result',
                          'Hasil Pencarian',
                          '搜索结果',
                        )
                        : translate(context, 'Recent', 'Terkini', '最近'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child:
                    isLoading
                        ? _buildLoadingState(context)
                        : isSubmited
                        ? _buildSearchResults(malls, context)
                        : _buildSearchHistory(
                          history,
                          lotProvider,
                          user,
                          context,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F1E5B)),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            translate(context, 'Searching...', 'Mencari...', '搜索中...'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F1E5B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            translate(
              context,
              'Please wait a moment',
              'Mohon tunggu sebentar',
              '请稍等',
            ),
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<ParkingLot> malls, BuildContext context) {
    if (malls.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty/search_where.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),
            Text(
              translate(
                context,
                'Try searching with different keywords',
                'Coba cari dengan kata kunci lain',
                '尝试使用不同的关键词搜索',
              ),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children:
          malls.map((mall) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar tetap kotak
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(mall.image, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Konten text di samping gambar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Baris nama dan badge slot
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                mall.name,
                                style: TextStyle(
                                  color: Color(0xFF1F1E5B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x46DC5F00),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                mall.spotCount <= 0
                                    ? translate(
                                      context,
                                      'All Full',
                                      'Penuh',
                                      '全部满了',
                                    )
                                    : translate(
                                      context,
                                      mall.spotCount == 1
                                          ? '${mall.spotCount} Slot'
                                          : '${mall.spotCount} Slots',
                                      '${mall.spotCount} Slot',
                                      '${mall.spotCount} 个插槽',
                                    ),
                                style: TextStyle(
                                  color: Color(0xFFDC5F00),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          mall.address,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              formatCurrency(
                                nominal: mall.starterPrice!,
                                decimalPlace: 0,
                              ),
                              style: TextStyle(
                                color: Color(0xFFDC5F00),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '/${translate(context, "Hour", "Jam", "小时")}',
                              style: TextStyle(
                                color: Color(0xFFDC5F00),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSearchHistory(
    List<String> history,
    ParkingLotProvider provider,
    User user,
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 100, color: Color(0xFFD3D3D3)),
            const SizedBox(height: 16),
            Text(
              translate(
                context,
                'No search history',
                'Tidak ada riwayat pencarian',
                '没有搜索历史',
              ),
              style: TextStyle(
                color: Color(0xFFD3D3D3),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              translate(
                context,
                'Start searching to see your history',
                'Mulai mencari untuk melihat riwayat',
                '开始搜索以查看您的历史记录',
              ),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final query = history[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    query,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      provider.deleteHistory(user, query);
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (!isLoading) {
                      controller.text = query;
                      await searchMall(provider, query, user);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
