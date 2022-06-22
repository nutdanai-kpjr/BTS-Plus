import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

class PrimaryDropDown extends StatefulWidget {
  const PrimaryDropDown(
      {Key? key,
      this.items = const [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
        'Item 5',
      ],
      this.defaultValue = 'Item 1',
      this.onChanged})
      : super(key: key);
  final List<String> items;
  final String defaultValue;
  final Function(String)? onChanged;

  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  late String dropdownvalue;

  // List of items in our dropdown menu
  late List<String> items;
  late Function(String)? onChanged;
  @override
  void initState() {
    dropdownvalue = widget.defaultValue;
    items = widget.items;
    onChanged = widget.onChanged;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kBorderColor, width: 1),
      ),
      child: DropdownButton(
        underline: Container(),

        style: kBodyTextStyle,
        isExpanded: true,
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
          onChanged?.call(newValue!);
        },
      ),
    );
  }
}
