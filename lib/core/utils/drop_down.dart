import 'package:flutter/material.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/models/savings_field.dart';
import 'package:sentro/core/utils/text.dart';

class DropdownField extends StatefulWidget {
  final SavingsField field;

  const DropdownField({super.key, required this.field});

  @override
  State<DropdownField> createState() => DropdownFieldState();
}

class DropdownFieldState extends State<DropdownField> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.field.options!.map((e) {
                return ListTile(
                  title: Text(e),
                  onTap: () => Navigator.pop(context, e),
                );
              }).toList(),
            );
          },
        );

        if (result != null) {
          setState(() => selected = result);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: sLightBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(text: selected ?? widget.field.label),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}