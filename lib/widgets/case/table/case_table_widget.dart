import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/case/case_item.dart';
import '../../../provider/case_provider.dart';
import 'case_table_header_item_widget.dart';
import 'case_table_payemt_and_button_widget.dart';
import 'case_table_total_widget.dart';

class CaseTableWidget extends StatelessWidget {
  const CaseTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            const CaseTableHeaderWidget(),
            const Divider(height: 0),
            Expanded(
              child: Consumer<CaseProvider>(
                  builder: (BuildContext context, CaseProvider casePro, _) {
                final List<CaseItem> items = casePro.items;
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (BuildContext context, int index) =>
                      CaseTableItemWidget(sr: index, item: items[index]),
                );
              }),
            ),
            const Divider(height: 2),
            const CaseTableTotalWidget(),
            const Divider(height: 0),
            const CaseTablePaymentAndButtonWidget(),
          ],
        ),
      ),
    );
  }
}
