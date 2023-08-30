import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/case_provider.dart';
import '../../custom/custom_textformfield.dart';

class CaseTablePaymentAndButtonWidget extends StatelessWidget {
  const CaseTablePaymentAndButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<CaseProvider>(
            builder: (BuildContext context, CaseProvider casePro, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      controller: casePro.noOfPrints,
                      hint: 'No. of Prints',
                      label: 'No. of Prints',
                      showSuffixIcon: false,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => casePro.reset(),
                        child: Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const FittedBox(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => casePro.onSave(context),
                        child: Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const FittedBox(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      controller: casePro.discountController,
                      hint: 'Discount %',
                      showSuffixIcon: false,
                      onChanged: (String p0) => casePro.onDiscountInPercent(p0),
                    ),
                  ),
                  Text(
                    'Total Payable: ${casePro.payable.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      controller: casePro.paidController,
                      hint: 'Amount Paid',
                      showSuffixIcon: false,
                      onChanged: (String p0) => casePro.onPaidAmountUpdate(p0),
                    ),
                  ),
                  Text(
                    'Remaing: ${casePro.remainingAmount.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
