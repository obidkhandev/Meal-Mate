class TransactionModels {
  final String transferDate;
  final List<TransactionData> data;

  TransactionModels({
    required this.transferDate,
    required this.data,
  });

  factory TransactionModels.fromJson(Map<String, dynamic> json) {
    return TransactionModels(
      transferDate: json['transfer_date'],
      data: List<TransactionData>.from(json['data']
          .map((data) => TransactionData.fromJson(data))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transfer_date': transferDate,
      'data': data.map((transactionData) => transactionData.toJson()).toList(),
    };
  }

  TransactionModels copyWith({
    String? transferDate,
    List<TransactionData>? data,
  }) {
    return TransactionModels(
      transferDate: transferDate ?? this.transferDate,
      data: data ?? this.data,
    );
  }
}

class TransactionData {
  final int transactionCode;
  final String date;
  final int incomeId;
  final double amount;
  final int cardId;
  final Sender sender;

  TransactionData({
    required this.transactionCode,
    required this.date,
    required this.incomeId,
    required this.amount,
    required this.cardId,
    required this.sender,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      transactionCode: json['transaction_code'],
      date: json['date'],
      incomeId: json['income_id'],
      amount: json['amount'].toDouble(),
      cardId: json['card_id'],
      sender: Sender.fromJson(json['sender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_code': transactionCode,
      'date': date,
      'income_id': incomeId,
      'amount': amount,
      'card_id': cardId,
      'sender': sender.toJson(),
    };
  }

  TransactionData copyWith({
    int? transactionCode,
    String? date,
    int? incomeId,
    double? amount,
    int? cardId,
    Sender? sender,
  }) {
    return TransactionData(
      transactionCode: transactionCode ?? this.transactionCode,
      date: date ?? this.date,
      incomeId: incomeId ?? this.incomeId,
      amount: amount ?? this.amount,
      cardId: cardId ?? this.cardId,
      sender: sender ?? this.sender,
    );
  }
}

class Sender {
  final String brandImage;
  final String name;
  final String location;

  Sender({
    required this.brandImage,
    required this.name,
    required this.location,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      brandImage: json['brand_image'],
      name: json['name'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_image': brandImage,
      'name': name,
      'location': location,
    };
  }

  Sender copyWith({
    String? brandImage,
    String? name,
    String? location,
  }) {
    return Sender(
      brandImage: brandImage ?? this.brandImage,
      name: name ?? this.name,
      location: location ?? this.location,
    );
  }
}
