import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

import '../../forms/layout/primary_dropdown.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({Key? key, required this.onChanged, this.quantity = 1})
      : super(key: key);
  final Function(int) onChanged;
  final int quantity;
  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity = widget.quantity;
  late final Function(int) onChanged = widget.onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                if (_quantity > 1) {
                  setState(() {
                    _quantity--;
                  });
                  onChanged(_quantity);
                }
              },
              icon: Icon(
                Icons.remove,
                color: kPrimaryFontColor,
              )),
          Text(
            '$_quantity',
            style: kBodyTextStyle,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _quantity++;
                });
                onChanged(_quantity);
              },
              icon: Icon(
                Icons.add,
                color: kPrimaryFontColor,
              )),
        ],
      ),
    );
  }
}
