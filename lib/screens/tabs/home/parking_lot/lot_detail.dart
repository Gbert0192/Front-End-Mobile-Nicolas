import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/parking_lot/booking_qr.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/parking_lot/payment_qr.dart';
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isSmall ? 5 : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      mall.image,
                      width: 400,
                      height: isSmall ? 215 : 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mall.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: isSmall ? 20 : 24,
                      ),
                    ),

                    Text(
                      mall.address,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isSmall ? 14 : 18,
                      ),
                    ),
                    SizedBox(height: isSmall ? 5 : 10),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: Color(0xFF4D5DFA),
                                size: isSmall ? 18 : null,
                              ),
                              SizedBox(width: 5),
                              Text(
                                mall.getFreeCount() <= 0
                                    ? translate(
                                      context,
                                      'All Full',
                                      'Penuh',
                                      '全部满了',
                                    )
                                    : translate(
                                      context,
                                      mall.getFreeCount() == 1
                                          ? '${mall.getFreeCount()} Slot'
                                          : '${mall.getFreeCount()} Slots',
                                      '${mall.getFreeCount()} Slot',
                                      '${mall.getFreeCount()} 个插槽',
                                    ),
                                style: TextStyle(
                                  color: Color(0xFF4D5DFA),
                                  fontSize: isSmall ? 12 : 14,
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
                              Icon(
                                Icons.access_time,
                                color: Color(0xFF4D5DFA),
                                size: isSmall ? 18 : null,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${mall.openTime} - ${mall.closeTime}',
                                style: TextStyle(
                                  color: Color(0xFF4D5DFA),
                                  fontSize: isSmall ? 12 : 14,
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
                              Icon(
                                Icons.apartment,
                                color: Color(0xFF4D5DFA),
                                size: isSmall ? 18 : null,
                              ),
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
                                  fontSize: isSmall ? 12 : 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmall ? 15 : 20),
                    Text(
                      translate(context, 'Description', 'Deskripsi', '描述'),
                      style: TextStyle(
                        fontSize: isSmall ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ExpandableRichText(
                      openTime: mall.openTime,
                      closeTime: mall.closeTime,
                      buildingType: mall.buildingType,
                    ),

                    SizedBox(height: isSmall ? 15 : 20),

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
                                    formatCurrency(nominal: mall.starterPrice),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFFFA35E)),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Color(0xFFFFA35E),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              PaymentQrPage(mall: mall),
                                    ),
                                  );
                                },
                                child: Text(
                                  translate(
                                    context,
                                    'Enter Parking',
                                    'Masuk Parkir',
                                    '进入停车场',
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF7573EE)),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Color(0xFF7573EE),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              BookingDetailPage(mall: mall),
                                    ),
                                  );
                                },
                                child: Text(
                                  translate(
                                    context,
                                    'Book Parking',
                                    'Pesan Parkir',
                                    '预订停车位',
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
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
          ],
        ),
      ),
    );
  }
}

class ExpandableRichText extends StatefulWidget {
  final String openTime;
  final String closeTime;
  final BuildingType buildingType;

  const ExpandableRichText({
    Key? key,
    required this.openTime,
    required this.closeTime,
    required this.buildingType,
  }) : super(key: key);

  @override
  State<ExpandableRichText> createState() => _ExpandableRichTextState();
}

class _ExpandableRichTextState extends State<ExpandableRichText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final buildingLabel =
        widget.buildingType == BuildingType.hotel
            ? translate(context, 'Hotel', 'Hotel', '酒店')
            : translate(context, 'Shopping Mall', 'Pusat Perbelanjaan', '购物中心');

    final shortText = translate(
      context,
      'This $buildingLabel in Medan is well-known for its accessibility and variety of services, making it a popular destination for locals and visitors.',
      '$buildingLabel ini di Medan dikenal luas karena kemudahan akses dan beragam layanannya, menjadikannya tujuan populer bagi warga lokal maupun pengunjung.',
      '这家位于棉兰的$buildingLabel因其便利的交通和多样的服务而广受欢迎，是当地人和游客的热门去处。',
    );

    final fullText = translate(
      context,
      'This $buildingLabel in Medan offers not only essential services but also a range of facilities for comfort, convenience, and leisure. With welcoming spaces, modern interiors, and a customer-friendly atmosphere, it serves as a favored destination throughout the day. The place operates from ${widget.openTime} until ${widget.closeTime}.',
      '$buildingLabel ini di Medan tidak hanya menyediakan layanan utama, tetapi juga berbagai fasilitas untuk kenyamanan, kemudahan, dan hiburan. Dengan area yang ramah, interior modern, dan suasana yang menyenangkan, tempat ini menjadi destinasi favorit sepanjang hari. Tempat ini beroperasi mulai dari jam ${widget.openTime} sampai jam ${widget.closeTime}.',
      '这家位于棉兰的$buildingLabel不仅提供基本服务，还拥有多种舒适、便利与娱乐设施。温馨的空间、现代化的装潢，以及友善的氛围，使其成为全天候热门的目的地。营业时间为 ${widget.openTime} 至 ${widget.closeTime}。',
    );

    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xFF908C8C),
          fontSize: isSmall ? 14 : 16,
          height: 1.6,
        ),
        children: [
          TextSpan(
            style: TextStyle(wordSpacing: 2),
            text: isExpanded ? fullText : shortText,
          ),
          TextSpan(
            text:
                isExpanded
                    ? translate(
                      context,
                      ' Read Less...',
                      ' Sembunyikan...',
                      ' 收起...',
                    )
                    : translate(
                      context,
                      ' Read More...',
                      ' Baca Selengkapnya...',
                      ' 阅读更多...',
                    ),
            style: TextStyle(
              color: Color(0xFF4D5DFA),
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
          ),
        ],
      ),
    );
  }
}
