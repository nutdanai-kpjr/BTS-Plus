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
      child: Column(
        children: <Widget>[
          const Text('Station Selector'),
          Row(
            children: <Widget>[
              Text('From'),
              PrimaryDropDown(
                defaultValue: from,
                onChanged: onFromChanged,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('To'),
              PrimaryDropDown(
                defaultValue: to,
                onChanged: onToChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
