class TransferRecipient {
  final String name;
  final String image;
  final bool isSentroTag;
  final String? tag;
  final String? bankName;
  final int? accountNumber;
  final bool fromBeneficiary; // ← new flag

  const TransferRecipient._({
    required this.name,
    required this.image,
    required this.isSentroTag,
    this.tag,
    this.bankName,
    this.accountNumber,
    this.fromBeneficiary = false,
  });

  /// Sentro tag recipient
  factory TransferRecipient.sentro({
    required String image,
    required String name,
    required String tag,
    bool fromBeneficiary = false,
  }) =>
      TransferRecipient._(
        name: name,
        image: image,
        isSentroTag: true,
        tag: tag,
        fromBeneficiary: fromBeneficiary,
      );

  /// Bank account recipient
  factory TransferRecipient.bank({
    required String image,
    required String name,
    required String bankName,
    required int accountNumber,
    bool fromBeneficiary = false,
  }) =>
      TransferRecipient._(
        name: name,
        image: image,
        isSentroTag: false,
        bankName: bankName,
        accountNumber: accountNumber,
        fromBeneficiary: fromBeneficiary,
      );
}