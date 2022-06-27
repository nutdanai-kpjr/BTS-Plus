class Station {
  final String id, name, route, btsId;
  final int stationIndex;
  Station(
      {required this.id,
      required this.btsId,
      required this.name,
      required this.route,
      required this.stationIndex});

  Station.fromJson(Map<String, dynamic> json)
      : id = json['stationID'],
        btsId = json['btsID'],
        name = json['stationName'],
        route = json['locate'],
        stationIndex = json['stationIndex'];
}
