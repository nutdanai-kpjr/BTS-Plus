import 'dart:developer';

import 'package:bts_authenticator/components/forms/layout/primary_dropdown.dart';
import 'package:bts_authenticator/constants.dart';
import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:bts_authenticator/services/bts_controller.dart';
import 'package:bts_authenticator/utils.dart';
import 'package:flutter/material.dart';

import '../../domains/station.dart';

showConfigurationDialog(
  context,
) async {
  List<Station> stations = await getStations(context: context);
  List<String> gateTypes = ['Entrance', 'Exit'];

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

  List<String> stationNames =
      stations.map((station) => '${station.id} ${station.name}').toList();

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: _buildDialogScrollable(children: [
              Center(
                child: Container(
                  height: kHeight(context) * 0.075,
                  margin: EdgeInsets.only(bottom: kHeight(context) * 0.02),
                  decoration: const BoxDecoration(
                    color: kThemeColor,
                    // border: Border.all(color: kBorderColor, width: 2.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text('Gate Configuration',
                        style:
                            kHeader3TextStyle.copyWith(color: kThemeFontColor)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(kWidth(context) * 0.05),
                child: PrimaryDropDown(
                  title: 'Gate Type',
                  items: gateTypes,
                  defaultValue:
                      getCapitalized(AuthenticatorConfiguration().gateType),
                  onChanged: (gateType) {
                    final String newGateType = gateType.toLowerCase();
                    AuthenticatorConfiguration.setGateType(newGateType);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(kWidth(context) * 0.05),
                child: PrimaryDropDown(
                  title: 'Gate Station',
                  items: stationNames,
                  defaultValue: stationIdToDisplayName(
                      AuthenticatorConfiguration().gateStationId),
                  onChanged: (stationName) {
                    final String stationId =
                        displayNameToStationId(stationName);
                    AuthenticatorConfiguration.setGateStationId(stationId);
                  },
                ),
              ),
              SizedBox(height: kHeight(context) * 0.02),
              // TicketDetailText(title:'Quanti', value:': ${ticket.}'),
              // TicketDetailText(title:'Total:', value:' ${ticket.total}'),
            ]),
          );
        });
      });
}

SingleChildScrollView _buildDialogScrollable({required children}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );
}
