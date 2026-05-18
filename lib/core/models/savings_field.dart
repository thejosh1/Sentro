enum SavingsFieldType {
  text,
  amount,
  dropdown,
  info,
  date,
  card,
}

class SavingsCardItem {
  final String label;
  final String value;
  final bool isColored;

  const SavingsCardItem({
    required this.label,
    required this.value,
    this.isColored = false,
  });
}

class SavingsField {
  final SavingsFieldType type;

  final String label;

  final String? hint;

  final List<String>? options;

  final bool showIcon;

  // ── Toggle ─────────────────────────────
  final bool toggleState;

  final String? description;

  // ── Card ───────────────────────────────

  final List<SavingsCardItem>? cardItems;

  const SavingsField({
    required this.type,
    required this.label,
    this.hint,
    this.options,
    this.toggleState = false,
    this.showIcon = false,
    this.description,

    // card
    this.cardItems,
  });
}