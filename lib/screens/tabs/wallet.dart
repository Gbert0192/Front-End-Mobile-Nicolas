import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/topup/topupdetailpage.dart';// import halaman detail

class TopUpMethodsPage extends StatelessWidget {
  const TopUpMethodsPage({super.key});

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
        builder: (_) => TopUpDetailPage(
          bankName: bankName,
          logoPath: logoPath,
          vaNumber: vaNumber,
          steps: steps,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bankList = [
      {
        'name': 'BRI',
        'image': 'assets/images/topup/bri.png',
        'va': '70001 081234567891',
        'steps': [
          'Login ke BRImo',
          'Pilih menu BRIVA',
          'Masukkan nomor VA dan nominal',
          'Konfirmasi dan bayar',
        ]
      },
      {
        'name': 'BCA',
        'image': 'assets/images/topup/bca.png',
        'va': '70001 081234567890',
        'steps': [
          'Login ke BCA Mobile',
          'Pilih m-Transfer',
          'Pilih BCA Virtual Account',
          'Masukkan nomor VA dan bayar',
        ]
      },
      {
        'name': 'Mandiri',
        'image': 'assets/images/topup/mandiri.png',
        'va': '70001 081234567892',
        'steps': [
          'Masuk ke Livin by Mandiri',
          'Pilih Bayar > Multipayment',
          'Masukkan VA dan jumlah',
          'Lanjutkan pembayaran',
        ]
      },
      {
        'name': 'CIMB',
        'image': 'assets/images/topup/cimb.png',
        'va': '70001 081234567893',
        'steps': [
          'Buka OCTO Mobile',
          'Pilih menu Pembayaran',
          'Input nomor Virtual Account',
          'Lakukan pembayaran',
        ]
      },
      {
        'name': 'OCBC',
        'image': 'assets/images/topup/ocbc.png',
        'va': '70001 081234567894',
        'steps': [
          'Buka OCBC app',
          'Klik menu pembayaran',
          'Input VA dan nominal',
          'Selesaikan transaksi',
        ]
      },
      {
        'name': 'Danamon',
        'image': 'assets/images/topup/danamon.png',
        'va': '70001 081234567895',
        'steps': [
          'Buka D-Bank PRO',
          'Pilih Virtual Account',
          'Masukkan detail pembayaran',
          'Konfirmasi dan bayar',
        ]
      },
      {
        'name': 'BNI',
        'image': 'assets/images/topup/bni.png',
        'va': '70001 081234567896',
        'steps': [
          'Masuk ke BNI Mobile Banking',
          'Pilih menu Transfer VA',
          'Masukkan nomor VA dan nominal',
          'Konfirmasi pembayaran',
        ]
      },
      {
        'name': 'Panin',
        'image': 'assets/images/topup/panin.jpg',
        'va': '70001 081234567897',
        'steps': [
          'Masuk aplikasi Panin',
          'Pilih Virtual Account',
          'Input nomor dan jumlah',
          'Selesaikan pembayaran',
        ]
      },
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text("Top Up Methods", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Via Bank (Virtual Account)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
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
                children: bankList.map((bank) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetail(
                        context,
                        bankName: bank['name'] as String,
                        logoPath: bank['image'] as String,
                        vaNumber: bank['va'] as String,
                        steps: List<String>.from(bank['steps'] as List),
                      );
                    },
                    child: Image.asset(
                      bank['image'] as String,
                      width: 50,
                      height: 50,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Via Cash (Scan Barcode)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
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
                children: cashList.map((path) {
                  return Image.asset(
                    path,
                    width: 50,
                    height: 50,
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
