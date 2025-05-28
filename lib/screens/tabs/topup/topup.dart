import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/topup/topup_detail.dart'; // import halaman detail

class TopUpPage extends StatelessWidget {
  TopUpPage({super.key});

  void _navigateToDetail(
    BuildContext context, {
    required String bankName,
    required String logoPath,
    required String vaNumber,
    required List<String> steps,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => TopUpDetailPage(
              bankName: bankName,
              logoPath: logoPath,
              vaNumber: vaNumber,
              steps: steps,
            ),
      ),
    );
  }

  final List<TopUpMethod> bankList = [
    TopUpMethod(
      name: 'BRI',
      image: 'assets/images/topup/bri.png',
      va: '70001 081234567891',
      steps: [
        'Login ke BRImo',
        'Pilih menu BRIVA',
        'Masukkan nomor VA dan nominal',
        'Konfirmasi dan bayar',
      ],
    ),
    TopUpMethod(
      name: 'BCA',
      image: 'assets/images/topup/bca.png',
      va: '70001 081234567890',
      steps: [
        'Login ke BCA Mobile',
        'Pilih m-Transfer',
        'Pilih BCA Virtual Account',
        'Masukkan nomor VA dan bayar',
      ],
    ),
    TopUpMethod(
      name: 'Mandiri',
      image: 'assets/images/topup/mandiri.png',
      va: '70001 081234567892',
      steps: [
        'Masuk ke Livin by Mandiri',
        'Pilih Bayar > Multipayment',
        'Masukkan VA dan jumlah',
        'Lanjutkan pembayaran',
      ],
    ),
    TopUpMethod(
      name: 'CIMB',
      image: 'assets/images/topup/cimb.png',
      va: '70001 081234567893',
      steps: [
        'Buka OCTO Mobile',
        'Pilih menu Pembayaran',
        'Input nomor Virtual Account',
        'Lakukan pembayaran',
      ],
    ),
    TopUpMethod(
      name: 'OCBC',
      image: 'assets/images/topup/ocbc.png',
      va: '70001 081234567894',
      steps: [
        'Buka OCBC app',
        'Klik menu pembayaran',
        'Input VA dan nominal',
        'Selesaikan transaksi',
      ],
    ),
    TopUpMethod(
      name: 'Danamon',
      image: 'assets/images/topup/danamon.png',
      va: '70001 081234567895',
      steps: [
        'Buka D-Bank PRO',
        'Pilih Virtual Account',
        'Masukkan detail pembayaran',
        'Konfirmasi dan bayar',
      ],
    ),
    TopUpMethod(
      name: 'BNI',
      image: 'assets/images/topup/bni.png',
      va: '70001 081234567896',
      steps: [
        'Masuk ke BNI Mobile Banking',
        'Pilih menu Transfer VA',
        'Masukkan nomor VA dan nominal',
        'Konfirmasi pembayaran',
      ],
    ),
    TopUpMethod(
      name: 'Panin',
      image: 'assets/images/topup/panin.jpg',
      va: '70001 081234567897',
      steps: [
        'Masuk aplikasi Panin',
        'Pilih Virtual Account',
        'Input nomor dan jumlah',
        'Selesaikan pembayaran',
      ],
    ),
  ];

  final cashList = [
    'assets/images/topup/alfamidi.png',
    'assets/images/topup/indomaret2.png',
    'assets/images/topup/alfamart.png',
    'assets/images/topup/superindo.png',
    'assets/images/topup/sevel.png',
    'assets/images/topup/family mart.png',
    'assets/images/topup/lawson.png',
    'assets/images/topup/K3mart.png',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top Up Methods",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isSmall ? 25 : 30,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Material(
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
                padding: const EdgeInsets.all(12),
                elevation: 1,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Via Bank (Virtual Account)",
              style: TextStyle(
                fontSize: isSmall ? 20 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: isSmall ? 12 : 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(255, 229, 229, 229),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children:
                    bankList.map((bank) {
                      return GestureDetector(
                        onTap: () {
                          _navigateToDetail(
                            context,
                            bankName: bank.name,
                            logoPath: bank.image,
                            vaNumber: bank.va,
                            steps: List<String>.from(bank.steps),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 6,
                              color: const Color.fromARGB(255, 228, 239, 255),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              bank.image,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Via Cash (Scan Barcode)",
              style: TextStyle(
                fontSize: isSmall ? 20 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: isSmall ? 12 : 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 229, 229, 229),
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children:
                    cashList.map((path) {
                      return Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 6,
                            color: const Color.fromARGB(255, 228, 239, 255),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            path,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopUpMethod {
  final String name;
  final String image;
  final String va;
  final List<String> steps;

  const TopUpMethod({
    required this.name,
    required this.image,
    required this.va,
    required this.steps,
  });
}
