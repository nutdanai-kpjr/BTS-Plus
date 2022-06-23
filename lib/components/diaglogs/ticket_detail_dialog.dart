import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

import '../../domains/ticket.dart';

showTicketDetailDialog(context, {required Ticket ticket}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: _buildDialogScrollable(children: [
              SecondaryHeader(title: 'Test'),
              SizedBox(
                height: kHeight(context) * 0.02,
              ),
              TicketDetailText(title: 'From:', value: '${ticket.from}'),
              TicketDetailText(title: 'To: ', value: '${ticket.to}'),
              TicketDetailText(title: 'Price:', value: ' ${ticket.price}'),
              // TicketDetailText(title:'Quanti', value:': ${ticket.}'),
              // TicketDetailText(title:'Total:', value:' ${ticket.total}'),
            ]),
          );
        });
      });
}

class TicketDetailText extends StatelessWidget {
  const TicketDetailText({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: kHeader5TextStyle,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: kBodyTextStyle,
          ),
        ),
      ],
    );
  }
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
