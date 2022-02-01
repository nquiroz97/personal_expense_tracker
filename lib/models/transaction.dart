class Transaction {
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;

  Transaction(
      {required this.date,
      required this.title,
      required this.amount,
      required this.id});
}
