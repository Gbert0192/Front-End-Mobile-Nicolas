import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/receipt/booking.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class SearchDetail extends StatelessWidget {
  final ParkingLot mall;

  const SearchDetail({super.key, required this.mall});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, size: isSmall ? 25 : 30),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      translate(
                        context,
                        'Parking Details',
                        'Detail Parkir',
                        '停车详情',
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isSmall ? 20 : 25,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    mall.image,
                    width: isSmall ? 320 : 400,
                    height: isSmall ? 240 : 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20), // Padding dipindah ke luar
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

                    // Menggunakan Wrap alih-alih Row agar bisa turun ke baris baru
                    Wrap(
                      spacing: 8.0, // Jarak horizontal antar container
                      runSpacing: 8.0, // Jarak vertikal antar baris
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
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
                            mainAxisSize:
                                MainAxisSize.min, // Penting untuk Wrap
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: Color(0xFF4D5DFA),
                              ),
                              SizedBox(width: 5),
                              Text(
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
                            horizontal: 12,
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
                            mainAxisSize:
                                MainAxisSize.min, // Penting untuk Wrap
                            children: [
                              Icon(Icons.access_time, color: Color(0xFF4D5DFA)),
                              SizedBox(width: 5),
                              Text(
                                '${mall.openTime} - ${mall.closeTime}',
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
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF4D5DFA),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min, // Penting untuk Wrap
                            children: [
                              Icon(Icons.apartment, color: Color(0xFF4D5DFA)),
                              SizedBox(width: 5),
                              Text(
                                mall.buildingType == BuildingType.mall
                                    ? translate(context, 'Mall', 'Mall', '购物中心')
                                    : translate(
                                      context,
                                      'Hotel',
                                      'Hotel',
                                      '酒店',
                                    ),
                                style: TextStyle(
                                  color: Color(0xFF4D5DFA),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      translate(context, 'Description', 'Deskripsi', '描述'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(
                            context,
                            'It is a very famous shopping center in Medan. Not only a shopping center, but also home to many cafes and trendy dining places. The mall operates from ${mall.openTime} until ${mall.closeTime}',
                            'Merupakan sebuah pusat pembelanjaan yang sangat terkenal di Medan. Bukan hanya sebuah pusat pembelanjaan tetapi juga merupakan rumah dari banyak kafe - kafe dan tempat - tempat makan yang ngetren. Mall beroperasi mulai dari jam ${mall.openTime} sampai jam ${mall.closeTime}',
                            '这是棉兰一家非常著名的购物中心。它不仅是一个购物中心，还汇聚了众多咖啡馆和时尚餐厅。商场营业时间为${mall.openTime}至${mall.closeTime}',
                          ),
                          style: TextStyle(
                            color: Color(0xFF908C8C),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          translate(
                            context,
                            'Read More...',
                            'Baca Selengkapnya...',
                            '阅读更多...',
                          ),
                          style: TextStyle(
                            color: Color(0xFF4D5DFA),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFEDF4FF)),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: Color(0xFFEDF4FF),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formatCurrency(
                                  nominal:
                                      mall.starterPrice ?? mall.hourlyPrice,
                                ),
                                style: TextStyle(
                                  color: Color(0xFF4D5DFA),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                translate(
                                  context,
                                  ' / hour',
                                  ' / jam',
                                  ' / 小时',
                                ),
                                style: TextStyle(
                                  color: Color(0xFF908C8C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  translate(
                                    context,
                                    '1st hour',
                                    'Jam pertama',
                                    '第一个小时',
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF908C8C),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  formatCurrency(nominal: mall.hourlyPrice),
                                  style: TextStyle(
                                    color: Color(0xFF5C5959),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ResponsiveButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => Booking(
                                        spotTypeEn: 'Parking Spot',
                                        spotTypeId: 'Pemarikiran Tempat',
                                        spotTypeCn: 'ba',
                                      ),
                                ),
                              );
                            },
                            isSmall: isSmall,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Color(0xFFFFA35E),
                            text: translate(
                              context,
                              'Enter Parking',
                              'Masuk Parkir',
                              '进入停车场',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ResponsiveButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => Booking(
                                        spotTypeEn: 'Booking Spot',
                                        spotTypeId: 'Pemesanan Tempat',
                                        spotTypeCn: 'ab',
                                      ),
                                ),
                              );
                            },
                            isSmall: isSmall,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Color(0xFF7573EE),
                            text: translate(
                              context,
                              'Book Parking',
                              'Pesan Parkir',
                              '预订停车位',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
