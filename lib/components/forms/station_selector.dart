import 'dart:developer';

import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/station.dart';
import 'package:flutter/material.dart';

import '../../services/bts_controller.dart';
import 'layout/primary_dropdown.dart';

class StationSelector extends StatefulWidget {
  const StationSelector(
      {Key? key,
      required this.onFromChanged,
      required this.onToChanged,
      this.fromStationId,
      this.toStationId})
      : super(key: key);
  final Function(String) onFromChanged;
  final Function(String) onToChanged;
  final String? fromStationId;
  final String? toStationId;

  @override
  State<StationSelector> createState() => _StationSelectorState();
}

class _StationSelectorState extends State<StationSelector> {
  late Future<List<Station>> _getStations;
  late Function(String) onFromChanged = widget.onFromChanged;
  late Function(String) onToChanged = widget.onToChanged;
  @override
  void initState() {
    // TODO: implement initState
    _getStations = getStations(
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getStations,
        builder: (context, AsyncSnapshot<List<Station>> snapshot) {
          if (snapshot.hasData) {
            var stations = snapshot.data ?? [];
            var stationNames = stations
                .map((station) => '${station.id} ${station.name}')
                .toList();
            //id to String
            String stationIdToDisplayName(String stationId) {
              Station station = stations.firstWhere(
                (station) => station.id == stationId,
                // orElse: () => null,
              );
              return '${station.id} ${station.name}';
            }

            //String to id
            String displayNameToStationId(String stationDisplayName) {
              var stationId = stationDisplayName.split(' ')[0];
              return stationId;
            }

            var fromStationId = widget.fromStationId ?? stations[0].id;
            var toStationId = widget.toStationId ??
                (stations.length > 1 ? stations[1].id : stations[0].id);
            log('fromStationId: $fromStationId');
            log('toStationId: $toStationId');
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
                          defaultValue: stationIdToDisplayName(fromStationId),
                          onChanged: (String value) {
                            onFromChanged(displayNameToStationId(value));
                          },
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
                          defaultValue: stationIdToDisplayName(toStationId),
                          onChanged: (String value) {
                            onToChanged(displayNameToStationId(value));
                          },
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
