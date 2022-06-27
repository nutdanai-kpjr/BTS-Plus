import 'dart:convert';
import 'dart:developer';

import 'package:bts_authenticator/components/buttons/layout/secondary_button.dart';
import 'package:bts_authenticator/components/headers/secondary_header.dart';
import 'package:bts_authenticator/components/primary_circular_progress_indicator.dart';
import 'package:bts_authenticator/components/primary_divider.dart';
import 'package:bts_authenticator/components/primary_scaffold.dart';
import 'package:bts_authenticator/constants.dart';
import 'package:bts_authenticator/domains/rabbit_card.dart';
import 'package:bts_authenticator/domains/ticket.dart';
import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:bts_authenticator/services/bts_controller.dart';
import 'package:bts_authenticator/services/rabbit_controller.dart';
import 'package:bts_authenticator/utils.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late String gateType;
  late String gateStationId;
  late final AudioPlayer _audioPlayer;

  bool enableScanner = true;
  bool coolDownScanner = false;
  String message = 'Wating for QR code';
  Color messageColor = kYellow;
  @override
  void initState() {
    _audioPlayer = AudioPlayer();

    gateType = AuthenticatorConfiguration().gateType;
    gateStationId = AuthenticatorConfiguration().gateStationId;

    super.initState();
  }

  onRefresh() {
    setState(() {
      gateType = AuthenticatorConfiguration().gateType;
      gateStationId = AuthenticatorConfiguration().gateStationId;
      enableScanner = true;
      message = 'Wating for QR code';
      messageColor = kYellow;
    });
  }

  resetMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      message = 'Wating for QR code';
      messageColor = kYellow;
    });
  }

  setMessage(newMessage, bool isSuccess) async {
    // if (!isSuccess) {
    //   playAudio(false);
    // }
    setState(() {
      message = newMessage;
      messageColor = isSuccess ? kGreen : kRed;
    });
    await resetMessage();
  }

  playAudio(bool isSuccess) {
    String file = isSuccess ? 'pass.mp3' : 'fail.mp3';
    _audioPlayer
        .setAsset('assets/audios/$file')
        .then((value) => _audioPlayer.play());
  }

  enableCooldown() {
    setState(() {
      coolDownScanner = true;
    });
  }

  disableCooldown() {
    setState(() {
      coolDownScanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SecondaryHeader(title: 'BTS authenticator', onPopDialog: onRefresh),
      Container(
        margin: EdgeInsets.only(top: kHeight(context) * 0.025),
        child: SecondaryButton(
            text: !enableScanner ? 'Enable QR Scanner' : 'Diasable QR Scanner',
            onPressed: () {
              setState(() {
                enableScanner = !enableScanner;
              });
            }),
      ),
      Container(
        margin: EdgeInsets.all(kWidth(context) * 0.1),
        height: kHeight(context) * 0.4,
        width: kWidth(context) * 0.8,
        padding: EdgeInsets.all(kWidth(context) * 0.01),
        decoration: BoxDecoration(
          color: kThemeFontColor,
          border: Border.all(color: kBorderColor, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: coolDownScanner
            ? SecondaryButton(
                text: 'Processing...',
                color: kSecondaryFontColor,
              )
            : enableScanner
                ? MobileScanner(
                    allowDuplicates: false,
                    controller: MobileScannerController(
                      facing: CameraFacing.back,
                    ),
                    onDetect: (qrCode, args) async {
                      playAudio(true);
                      enableCooldown();
                      if (qrCode.rawValue == null) {
                        await setMessage('Failed to scan QR Code', false);
                      } else {
                        final String value = qrCode.rawValue!;
                        if (value.contains('ticketID')) {
                          Ticket ticket = Ticket.fromJson(json.decode(value));

                          bool status =
                              await authorizeTicket(ticket, context: context);
                          await setMessage(
                              status
                                  ? 'Ticket authorized'
                                  : 'Ticket not authorized',
                              status);
                        } else if (value.contains('customerID')) {
                          RabbitCard rabbitCard =
                              RabbitCard.fromJsonQR(json.decode(value));

                          if (AuthenticatorConfiguration().isGateEntrance) {
                            bool status = await authorizeRabbitCardEntranceGate(
                                rabbitCard,
                                context: context);

                            await setMessage(
                                status
                                    ? 'Entrance authorized'
                                    : 'Entrance not authorized',
                                status);
                          } else if (AuthenticatorConfiguration().isGateExit) {
                            bool status = await authorizeRabbitCardExitGate(
                                rabbitCard,
                                context: context);

                            await setMessage(
                                status
                                    ? 'Exit authorized'
                                    : 'Exit not authorized',
                                status);
                          } else {
                            await setMessage('Invalid QR Code', false);
                          }
                        }
                        disableCooldown();
                      }
                    })
                : SecondaryButton(
                    color: kSecondaryFontColor,
                    text: 'QR Scanner Closed',
                    onPressed: () {
                      setState(() {
                        enableScanner = true;
                      });
                    }),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: kWidth(context) * 0.1,
            vertical: kHeight(context) * 0.01),
        child: Column(
          children: [
            GateConfigDetail(
              title: 'Gate Type',
              value: getCapitalized(gateType),
            ),
            GateConfigDetail(
              title: 'Gate Station ID',
              value: gateStationId,
            ),
            const PrimaryDivider(),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.symmetric(
              horizontal: kWidth(context) * 0.1,
              vertical: kHeight(context) * 0.01),
          child: BlinkingMessage(
            message: message,
            color: messageColor,
          )),
    ])));
  }
}

class GateConfigDetail extends StatelessWidget {
  const GateConfigDetail({Key? key, required this.title, required this.value})
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

class BlinkingMessage extends StatefulWidget {
  const BlinkingMessage({Key? key, required this.message, required this.color})
      : super(key: key);
  final String message;
  final Color color;

  @override
  State<BlinkingMessage> createState() => _BlinkingMessageState();
}

class _BlinkingMessageState extends State<BlinkingMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(widget.message,
          style: kHeader1TextStyle.copyWith(color: widget.color)),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
