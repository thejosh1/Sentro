import 'package:flutter/material.dart';
import 'package:sentro/core/models/savings_field.dart';

class SavingsProduct {
  final String title;
  final String description;

  const SavingsProduct({
    required this.title,
    required this.description,
  });
}

class SavingsOption {
  final String title;
  final String description;

  final String? interest;
  final Color? interestColor;

  final String buttonLabel;

  // ✅ for CARD UI
  final List<SavingsInfoItem>? bottomItems;

  // ✅ for FORM UI
  final List<SavingsField>? fields;

  SavingsOption({
    required this.title,
    required this.description,
    required this.buttonLabel,
    this.interest,
    this.interestColor,
    this.bottomItems,
    this.fields,
  });
}

class SavingsInfoItem {
  final String label;
  final String value;
  final bool showIcon;

  const SavingsInfoItem({
    required this.label,
    required this.value,
    this.showIcon = false,
  });
}
