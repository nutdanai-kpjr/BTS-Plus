import 'package:flutter/material.dart';

import 'layout/primary_dropdown.dart';

class StationSelector extends StatelessWidget {
  const StationSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Text('Station Selector'),
          Row(
            children: <Widget>[
              Text('From'),
              PrimaryDropDown(),
            ],
          ),
          Row(
            children: <Widget>[
              Text('To'),
              PrimaryDropDown(),
            ],
          ),
        ],
      ),
    );
  }
}
