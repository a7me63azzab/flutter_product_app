import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;
  AddressTag(this.address);
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.5),
          child: Text(address),
        ));
  }
}
