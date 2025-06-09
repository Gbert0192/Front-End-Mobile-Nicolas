import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CustomBarcodeWidget extends StatelessWidget {
  final String data;
  final double width;
  final double height;
  final bool showText;

  const CustomBarcodeWidget({
    Key? key,
    required this.data,
    this.width = 200,
    this.height = 60,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: data,
      width: width,
      height: height,
      drawText: showText,
      errorBuilder:
          (context, error) => Center(
            child: Text('Invalid data', style: TextStyle(color: Colors.red)),
          ),
    );
  }
}
