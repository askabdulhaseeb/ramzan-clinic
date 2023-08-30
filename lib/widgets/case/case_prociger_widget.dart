import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/local/local_procigar.dart';
import '../../enums/procigar_type.dart';
import '../../models/case/case_item.dart';
import '../../models/procigar/procigar.dart';
import '../../provider/case_provider.dart';

class CaseProcigerWidget extends StatefulWidget {
  const CaseProcigerWidget({super.key});

  @override
  State<CaseProcigerWidget> createState() => _CaseProcigerWidgetState();
}

class _CaseProcigerWidgetState extends State<CaseProcigerWidget> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    final List<Procigar> procigars = LocalProcigar().searchProcigar(search);
    return Expanded(
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            CupertinoSearchTextField(
              placeholder: 'Test/Procedure',
              onChanged: (String value) => setState(() {
                search = value;
              }),
            ),
            const SizedBox(height: 8),
            const Divider(height: 2),
            const Divider(height: 2),
            Expanded(
              child: ListView.separated(
                itemCount: procigars.length,
                itemBuilder: (BuildContext context, int index) {
                  final Procigar procigar = procigars[index];
                  final bool isDiscounted = procigar.discountInRupees > 0;
                  return ListTile(
                    onTap: () =>
                        Provider.of<CaseProvider>(context, listen: false)
                            .onAddItem(
                      CaseItem(
                        id: procigar.testID,
                        isTest: procigar.type == ProcigarType.test,
                        price: procigar.fee,
                        quantity: 1,
                        discountInPercent: procigar.discountInPercent,
                      ),
                    ),
                    title: Text(procigar.name),
                    subtitle: isDiscounted
                        ? RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodySmall,
                              children: <TextSpan>[
                                TextSpan(text: '${procigar.fee} - '),
                                TextSpan(
                                  text: '${procigar.discountInPercent}%',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const TextSpan(text: ' = '),
                                TextSpan(
                                  text: '${procigar.priceAfterDiscount}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(procigar.fee.toString()),
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
