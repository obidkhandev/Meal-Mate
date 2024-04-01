class CountryModel {
  String code;
  String name;
  String phone;
  Continent continent;
  String capital;
  String currency;
  String emoji;

  CountryModel({
    required this.code,
    required this.name,
    required this.phone,
    required this.continent,
    required this.capital,
    required this.currency,
    required this.emoji,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      continent: Continent.fromJson(json['continent']),
      capital: json['capital'] ?? '',
      currency: json['currency'] ?? '',
      emoji: json['emoji'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'phone': phone,
      'continent': continent.toJson(),
      'capital': capital,
      'currency': currency,
      'emoji': emoji,
    };
  }

  CountryModel copyWith({
    String? code,
    String? name,
    String? phone,
    Continent? continent,
    String? capital,
    String? currency,
    String? emoji,
  }) {
    return CountryModel(
      code: code ?? this.code,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      continent: continent ?? this.continent,
      capital: capital ?? this.capital,
      currency: currency ?? this.currency,
      emoji: emoji ?? this.emoji,
    );
  }
}

class Continent {
  String code;
  String name;

  Continent({
    required this.code,
    required this.name,
  });

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}