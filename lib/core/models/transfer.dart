// lib/core/models/transfer_recipient.dart

class TransferRecipient {
  final String image;
  final String name;
  final bool isSentroTag;

  // Other Banks fields
  final String? bankName;
  final int? accountNumber;

  // Sentro Tag fields
  final String? tag;

  const TransferRecipient.bank({
    required this.image,
    required this.name,
    required this.bankName,
    required this.accountNumber,
  })  : isSentroTag = false,
        tag = null;

  const TransferRecipient.sentro({
    required this.image,
    required this.name,
    required this.tag,
  })  : isSentroTag = true,
        bankName = null,
        accountNumber = null;
}