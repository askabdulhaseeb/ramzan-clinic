import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/case_provider.dart';
import '../../custom/custom_vertical_divider.dart';

class CaseTableTotalWidget extends StatelessWidget {
  const CaseTableTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CaseProvider>(
        builder: (BuildContext context, CaseProvider casePro, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Total Qty: ${casePro.totalItemsQty()}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 16),
          const CustomVerticalDivider(),
          const SizedBox(width: 16),
          Text(
            'Total Amount: ${casePro.itemsTotal()}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 16),
        ],
      );
    });
  }
}
