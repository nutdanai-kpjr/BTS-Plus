import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../domains/ticket.dart';
import '../utils.dart';

showTicketDetailDialog(context,
    {required Ticket ticket,
    required displayFrom,
    required displayTo,
    Function()? onPop}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        ScreenshotController screenshotController = ScreenshotController();

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
                    color: kBTSThemeColor,
                    // border: Border.all(color: kBorderColor, width: 2.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text('Ticket: ${ticket.id}',
                        style:
                            kHeader3TextStyle.copyWith(color: kThemeFontColor)),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(kHeight(context) * 0.012),
                child: Column(
                  children: [
                    TicketDetailText(title: 'From:', value: '${displayFrom}'),
                    TicketDetailText(title: 'To:', value: '${displayTo}'),
                    TicketDetailText(
                        title: 'Station Length:',
                        value: '${ticket.stationDistance}'),
                    TicketDetailText(
                        title: 'Price:', value: '฿ ${ticket.price}'),
                    TicketDetailText(
                        title: 'Purchase Date:',
                        value: '${getFormatDateWithTime(ticket.purchaseDate)}'),
                    TicketDetailText(
                        title: 'Expire Date:',
                        value: '${getFormatDateWithTime(ticket.expireDate)}'),
                  ],
                ),
              ),
              const PrimaryDivider(),
              Screenshot(
                controller: screenshotController,
                child: Padding(
                  padding: EdgeInsets.all(kWidth(context) * 0.005),
                  child: QrImage(
                      data: '${ticket.getQRUrl()}',
                      version: QrVersions.auto,
                      embeddedImage:
                          const AssetImage('assets/images/bts_qr.png'),
                      embeddedImageStyle:
                          QrEmbeddedImageStyle(size: const Size(80, 80)),
                      size: kHeight(context) * 0.3),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: kHeight(context) * 0.02),
                child: PrimaryButton(
                    text: 'Share',
                    onPressed: () async {
                      final directory = (await getTemporaryDirectory())
                          .path; //from path_provide package
                      String fileName =
                          '${DateTime.now().millisecondsSinceEpoch.toString()}.png';
                      String? result = await screenshotController
                          .captureAndSave(directory, fileName: fileName);
                      //Capture Done
                      if (result != null) {
                        Share.shareFiles([result], text: 'Great picture');
                      }
                    }),
              )
              // TicketDetailText(title:'Quanti', value:': ${ticket.}'),
              // TicketDetailText(title:'Total:', value:' ${ticket.total}'),
            ]),
          );
        });
      });
  onPop?.call();
}

class TicketDetailText extends StatelessWidget {
  const TicketDetailText({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kWidth(context) * 0.03),
      margin: EdgeInsets.only(bottom: kHeight(context) * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kHeader3TextStyle,
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: kBodyTextStyle,
          ),
        ],
      ),
    );
  }
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
