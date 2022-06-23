import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/station.dart';
import 'package:flutter/material.dart';

import '../../services/btsController.dart';
import 'layout/primary_dropdown.dart';

class StationSelector extends StatefulWidget {
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
  State<StationSelector> createState() => _StationSelectorState();
}

class _StationSelectorState extends State<StationSelector> {
  late Future<List<Station>> _getStations;
  late String from = widget.from;
  late String to = widget.to;
  late Function(String) onFromChanged = widget.onFromChanged;
  late Function(String) onToChanged = widget.onFromChanged;
  @override
  void initState() {
    // TODO: implement initState
    _getStations = getStations(context: context, mockUp: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getStations,
        builder: (context, AsyncSnapshot<List<Station>> snapshot) {
          if (snapshot.hasData) {
            var stations = snapshot.data ?? [];
            var stationNames = stations.map((station) => station.name).toList();
            var from = stationNames[0];
            var to =
                stationNames.length > 1 ? stationNames[1] : stationNames[0];
            return Container(
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
                          title: 'From',
                          defaultValue: from,
                          onChanged: onFromChanged,
                          items: stationNames,
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
                          title: 'To',
                          defaultValue: to,
                          onChanged: onToChanged,
                          items: stationNames,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const PrimaryCircularProgressIndicator();
          }
        });
  }
}
