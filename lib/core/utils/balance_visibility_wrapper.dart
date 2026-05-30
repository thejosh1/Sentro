// lib/core/widgets/balance_visibility.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentro/core/controllers/visibility_controller.dart';

class BalanceVisibility extends StatefulWidget {
  /// Builder receives the current effective [obscured] value
  /// and a [toggleLocal] callback for temporary local override.
  final Widget Function(bool obscured, VoidCallback toggleLocal) builder;

  const BalanceVisibility({super.key, required this.builder});

  @override
  State<BalanceVisibility> createState() => _BalanceVisibilityState();
}

class _BalanceVisibilityState extends State<BalanceVisibility> {
  // null = no local override; follow global
  bool? _localOverride;

  void _toggleLocal() {
    final global = VisibilityController.to.isObscured.value;
    final current = _localOverride ?? global;
    setState(() => _localOverride = !current);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final global = VisibilityController.to.isObscured.value;

      // When global changes, clear local override so global wins again
      if (_localOverride != null && _localOverride == global) {
        // They've converged — clear the override silently next frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _localOverride = null);
        });
      }

      final effective = _localOverride ?? global;
      return widget.builder(effective, _toggleLocal);
    });
  }
}