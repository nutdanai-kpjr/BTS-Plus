import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/station.dart';
import '../services/bts_controller.dart';

final stationProvider = StateNotifierProvider<StationNotifier, List<Station>>(
  (ref) => StationNotifier([]),
  // (ref) => StationNotifier(User.mockUp()),
);

class StationNotifier extends StateNotifier<List<Station>> {
  StationNotifier(List<Station> state) : super(state);

  setCurrentStations(List<Station> stations) {
    state = stations;
  }

  Future<void> getStationLists(context) async {
    List<Station> newStations = await getStations(context: context);
    setCurrentStations(newStations);
  }

  String stationIdToDisplayName(String stationId) {
    Station station = state.firstWhere(
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

  List<String> stationNames() =>
      state.map((station) => '${station.id} ${station.name}').toList();
}
