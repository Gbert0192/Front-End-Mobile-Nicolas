import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
    this.valueColor,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize ?? 15,
                color: Colors.grey,
                fontWeight: fontWeight,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize ?? 15,
                color: valueColor ?? Colors.black,
                fontWeight: fontWeight,
              ),
              textAlign: TextAlign.end,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailItem {
  final String label;
  final String value;

  DetailItem({required this.label, required this.value});
}

class DataCard extends StatelessWidget {
  final List<DetailItem> listData;
  final String title;

  const DataCard({super.key, required this.listData, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final FontWeight fontWeight = FontWeight.w600;
    final double fontSize = isSmall ? 13 : 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: isSmall ? 18 : 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < listData.length; i++) ...[
                  DetailRow(
                    label: listData[i].label,
                    value: listData[i].value,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                  if (i != listData.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
