import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/user.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

showUserQRCodeDialog(context, {required User user}) {
  showDialog(
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
                    color: kRabbitThemeColor,
                    // border: Border.all(color: kBorderColor, width: 2.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text('My Rabbit Card QR Code',
                        style:
                            kHeader3TextStyle.copyWith(color: kThemeFontColor)),
                  ),
                ),
              ),

              QrImage(
                  data: '${user.getQRurl()}',
                  version: QrVersions.auto,
                  embeddedImage:
                      const AssetImage('assets/images/rabbit_qr.png'),
                  embeddedImageStyle:
                      QrEmbeddedImageStyle(size: const Size(80, 80)),
                  size: kHeight(context) * 0.3),
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
