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
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 120, maxWidth: 150),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize ?? 15,
                color: Colors.grey,
                fontWeight: fontWeight,
              ),
            ),
          ),
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
  final String? value;
  final Widget? child;

  DetailItem({required this.label, this.value, this.child})
    : assert(
        value == null || child == null,
        'Cannot provide both value and child.',
      );
}

class DataCard extends StatelessWidget {
  final List<DetailItem>? listData;
  final String? title;
  final List<DetailItem>? children;

  const DataCard({super.key, this.listData, this.title, this.children});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final FontWeight fontWeight = FontWeight.w600;
    final double fontSize = isSmall ? 13 : 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: isSmall ? 18 : 24,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listData != null && listData!.isNotEmpty) ...[
                  ...List.generate(listData!.length * 2 - 1, (index) {
                    if (index.isEven) {
                      final i = index ~/ 2;
                      final item = listData![i];

                      if (item.value != null) {
                        return DetailRow(
                          label: item.label,
                          value: item.value!,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                        );
                      } else if (item.child != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: fontWeight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            item.child!,
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const SizedBox(height: 10);
                    }
                  }),
                  if (children != null && children!.isNotEmpty)
                    const SizedBox(height: 10),
                ],
                if (children != null && children!.isNotEmpty) ...[
                  ...List.generate(children!.length * 2 - 1, (index) {
                    if (index.isEven) {
                      final i = index ~/ 2;
                      final item = children![i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          item.child!,
                        ],
                      );
                    } else {
                      return const SizedBox(height: 10);
                    }
                  }),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
