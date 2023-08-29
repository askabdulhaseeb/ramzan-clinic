import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/local/local_address.dart';
import '../../models/core/address.dart';
import '../../utilities/utilities.dart';
import '../custom/custom_textformfield.dart';

class SearchableAddress extends StatefulWidget {
  const SearchableAddress({
    required this.onSelect,
    this.selectedAddress,
    super.key,
  });
  final void Function(Address?) onSelect;
  final Address? selectedAddress;

  @override
  State<SearchableAddress> createState() => _SearchableAddressState();
}

class _SearchableAddressState extends State<SearchableAddress> {
  List<Address> addresses = <Address>[];
  Address? selectedAddress;
  onSearch(String p0) {
    addresses = LocalAddress().searchAddress(p0);
    setState(() {});
  }

  @override
  void initState() {
    selectedAddress = widget.selectedAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectedAddress != null
        ? CustomTextFormField(
            controller:
                TextEditingController(text: selectedAddress?.string ?? ''),
            readOnly: true,
            sufficIcon: IconButton(
              icon: const Icon(CupertinoIcons.search),
              onPressed: () {
                widget.onSelect(null);
                setState(() {
                  selectedAddress = null;
                });
              },
            ),
          )
        : Container(
            width: Utilities.maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: <Widget>[
                CupertinoSearchTextField(
                    onChanged: (String p0) => onSearch(p0)),
                const Divider(),
                Wrap(
                  children: addresses
                      .map((Address e) => _AddressTile(
                            e,
                            onTap: () {
                              selectedAddress = e;
                              widget.onSelect(e);
                            },
                          ))
                      .toList(),
                ),
              ],
            ));
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile(this.address, {required this.onTap, super.key});
  final Address address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(address.string),
      ),
    );
  }
}
