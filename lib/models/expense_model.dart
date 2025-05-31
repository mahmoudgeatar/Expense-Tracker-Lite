class Expense {
  final int? id;
  final String category;
  final double amount;
  final double usdAmount;

  final String date;
  final String? receiptPath;
  final String? currency;

  Expense({
    this.id,
    required this.category,
    required this.amount,
    required     this.usdAmount,

    required this.date,
    this.receiptPath,
    this.currency,
  });

  Expense copyWith({
    int? id,
    String? category,
    double? amount,
    String? date,
    String? receiptPath,
    String? currency,
    double? usdAmount
  }) {
    return Expense(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      receiptPath: receiptPath ?? this.receiptPath,
        currency: currency?? this.currency,
        usdAmount: usdAmount?? this.usdAmount
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
      'receiptPath': receiptPath,
      "currency":currency,
      "usdAmount":usdAmount

    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],
      receiptPath: map['receiptPath'],
        currency: map["currency"],
        usdAmount:map["usdAmount"]
    );
  }
}
