import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/local/local_procigar.dart';
import '../../../models/case/case_item.dart';
import '../../../models/procigar/procigar.dart';
import '../../../provider/case_provider.dart';
import '../../custom/custom_vertical_divider.dart';

class CaseTableItemWidget extends StatelessWidget {
  const CaseTableItemWidget({required this.sr, required this.item, super.key});
  final int sr;
  final CaseItem item;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Procigar>(
      future: LocalProcigar().procigar(item.id),
      builder: (BuildContext context, AsyncSnapshot<Procigar> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final Procigar procigar = snapshot.data!;
        return Row(
          children: <Widget>[
            Expanded(
              flex: _srFlex,
              child: Center(
                child: Text(
                  '$sr',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const CustomVerticalDivider(),
            Expanded(
              flex: _nameFlex,
              child: Text(
                '  ${procigar.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const CustomVerticalDivider(),
            Expanded(
              flex: _priceFlex,
              child: Center(
                child: Text(
                  item.price.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const CustomVerticalDivider(),
            Expanded(
              flex: _priceFlex,
              child: Center(
                child: Text(
                  '${item.discountInPercent}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const CustomVerticalDivider(),
            Expanded(
              flex: _priceFlex,
              child: Center(
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const CustomVerticalDivider(),
            Expanded(
              flex: _totalFlex,
              child: Center(
                child: Text(
                  item.total.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const CustomVerticalDivider(),
            InkWell(
              onTap: () => Provider.of<CaseProvider>(context, listen: false)
                  .onRemoveItem(item),
              child: const SizedBox(
                width: 40,
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CaseTableHeaderWidget extends StatelessWidget {
  const CaseTableHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          flex: _srFlex,
          child: Center(
            child: Text('Sr.', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        Expanded(
          flex: _nameFlex,
          child: Center(
            child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        Expanded(
          flex: _priceFlex,
          child: Center(
            child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        Expanded(
          flex: _priceFlex,
          child: Center(
            child: Text('Dis%', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        Expanded(
          flex: _priceFlex,
          child: Center(
            child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        Expanded(
          flex: _totalFlex,
          child: Center(
            child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        CustomVerticalDivider(),
        SizedBox(
          width: 40,
          child: Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}

const int _srFlex = 1;
const int _nameFlex = 4;
const int _priceFlex = 2;
const int _totalFlex = 3;
