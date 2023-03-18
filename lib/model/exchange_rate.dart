import 'dart:convert';
import 'package:book_store/model/rate.dart';

ExchangeRate exchangeRateFromJson(String str) =>
    ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

List<Rates> rateFromJson(String str) =>
    List<Rates>.from(json.decode(str).map((x) => Rates.fromJson(x)));

class ExchangeRate {
  ExchangeRate({
    required this.info,
    required this.description,
    required this.timestamp,
    required this.rates,
  });

  String info;
  String description;
  String timestamp;
  Rates rates;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        info: json["info"],
        description: json["description"],
        timestamp: json["timestamp"],
        rates: Rates.fromJson(json["rates"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "description": description,
        "timestamp": timestamp,
        "rates": rates.toJson(),
      };
}
