import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

showTicketDetailDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: _buildDialogScrollable(children: []),
          );
        });
      });
}

SingleChildScrollView _buildDialogScrollable({required children}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    ),
  );
}
