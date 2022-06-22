import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

import 'layout/primary_dropdown.dart';

class StationSelector extends StatelessWidget {
  const StationSelector(
      {Key? key,
      required this.onFromChanged,
      required this.onToChanged,
      this.from = 'Item 1',
      this.to = 'Item 2'})
      : super(key: key);
  final Function(String) onFromChanged;
  final Function(String) onToChanged;
  final String from;
  final String to;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kWidth(context) * 0.09,
          vertical: kHeight(context) * 0.025),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'From',
                  style: kHeader3TextStyle,
                ),
              ),
              Expanded(
                flex: 5,
                child: PrimaryDropDown(
                  defaultValue: from,
                  onChanged: onFromChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: kHeight(context) * 0.025),
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'To',
                  style: kHeader3TextStyle,
                ),
              ),
              Expanded(
                flex: 5,
                child: PrimaryDropDown(
                  defaultValue: to,
                  onChanged: onToChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
