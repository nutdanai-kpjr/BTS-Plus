import 'dart:developer';

import 'package:bts_authenticator/components/buttons/layout/primary_button.dart';
import 'package:bts_authenticator/components/forms/layout/primary_dropdown.dart';
import 'package:bts_authenticator/constants.dart';
import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:bts_authenticator/services/bts_controller.dart';
import 'package:bts_authenticator/utils.dart';
import 'package:flutter/material.dart';

import '../../domains/station.dart';

showConfrimTicketDestination(context,
    {required orginalStation, required onChanged}) async {
  List<Station> stations = await getStations(context: context);

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
                    child: Text('Confirm Destatination',
                        style:
                            kHeader3TextStyle.copyWith(color: kThemeFontColor)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(kWidth(context) * 0.05),
                child: PrimaryDropDown(
                  title: 'Destination Station',
                  items: stationNames,
                  defaultValue: stationIdToDisplayName(orginalStation),
                  onChanged: (stationName) {
                    final String stationId =
                        displayNameToStationId(stationName);
                    onChanged(stationId);
                  },
                ),
              ),
              PrimaryButton(
                  text: 'Confirm',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
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
