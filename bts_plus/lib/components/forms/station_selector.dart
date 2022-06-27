import 'dart:developer';

import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/station_provider.dart';
import '../../services/bts_controller.dart';
import 'layout/primary_dropdown.dart';

class StationSelector extends ConsumerStatefulWidget {
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
  StationSelectorState createState() => StationSelectorState();
}

class StationSelectorState extends ConsumerState<StationSelector> {
  late Future<List<Station>> _getStations;
  late Function(String) onFromChanged = widget.onFromChanged;
  late Function(String) onToChanged = widget.onToChanged;
  @override
  void initState() {
    // TODO: implement initState
    _getStations = getStations(
      context: context,
    );
    // ref.read(stationProvider.notifier).getStations(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stations = ref.watch(stationProvider);
    final stationNames = ref.read(stationProvider.notifier).stationNames();
    stationIdToDisplayName(stationId) {
      return ref
          .read(stationProvider.notifier)
          .stationIdToDisplayName(stationId);
    }

    displayNameToStationId(stationId) {
      return ref
          .read(stationProvider.notifier)
          .displayNameToStationId(stationId);
    }

    var fromStationId = widget.fromStationId ?? stations[0].id;
    var toStationId = widget.toStationId ??
        (stations.length > 1 ? stations[1].id : stations[0].id);
    if (stationNames.isEmpty) {
      return const PrimaryCircularProgressIndicator();
    }
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

    //
  }
}
