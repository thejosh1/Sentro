import 'dart:ui';

class GoalModel {
  final String type;
  final String name;        // e.g. 'Equipment Funds'
  final String status;      // e.g. 'Active', 'Locked'
  final String balance;     // e.g. 'N3,500,000'
  final String? target;     // null for non-target savings
  final String interestRate;
  final String interestPaid;
  final String matures;
  final bool reinvest;
  final String? subtitle;   // e.g. 'of N5,000,000 goal'
  final Color accentColor;
  final double progressValue; // 0.0 - 1.0, null means no progress bar
  final bool hasProgress;

  const GoalModel({
    required this.type,
    required this.name,
    required this.status,
    required this.balance,
    this.target,
    required this.interestRate,
    required this.interestPaid,
    required this.matures,
    required this.reinvest,
    this.subtitle,
    required this.accentColor,
    this.progressValue = 0,
    this.hasProgress = false,
  });
}