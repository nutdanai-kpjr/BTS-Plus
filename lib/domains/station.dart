class Station {
  final String id, name, route;
  final int stationIndex;
  Station(
      {required this.id,
      required this.name,
      required this.route,
      required this.stationIndex});

  Station.fromJson(Map<String, dynamic> json)
      : id = json['stationID'],
        name = json['stationName'],
        route = json['stationLocate'],
        stationIndex = json['stationIndex'];
}
