// To parse this JSON data, do
//
//     final optionsData = optionsDataFromJson(jsonString);

import 'dart:convert';

OptionsData optionsDataFromJson(String str) => OptionsData.fromJson(json.decode(str));

String optionsDataToJson(OptionsData data) => json.encode(data.toJson());

class OptionsData {
    String stockCode;
    String exchangeCode;
    String productType;
    String expiryDate;
    String strikePrice;
    String right;
    String? globalHighest;
    String? globalLowest;
    List<OhlcDatum> ohlcData;

    OptionsData({
        required this.stockCode,
        required this.exchangeCode,
        required this.productType,
        required this.expiryDate,
        required this.strikePrice,
        required this.right,
        this.globalHighest,
        this.globalLowest,
        required this.ohlcData,
    });

    factory OptionsData.fromJson(Map<String, dynamic> json) => OptionsData(
        stockCode: json["stock_code"],
        exchangeCode: json["exchange_code"],
        productType: json["product_type"],
        expiryDate: json["expiry_date"],
        strikePrice: json["strike_price"],
        right: json["right"],
        globalHighest: json["global_highest"],
        globalLowest: json["global_lowest"],
        ohlcData: List<OhlcDatum>.from(json["ohlc_data"].map((x) => OhlcDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "stock_code": stockCode,
        "exchange_code": exchangeCode,
        "product_type": productType,
        "expiry_date": expiryDate,
        "strike_price": strikePrice,
        "right": right,
        "global_highest": globalHighest,
        "global_lowest": globalLowest,
        "ohlc_data": List<dynamic>.from(ohlcData.map((x) => x.toJson())),
    };
}

class OhlcDatum {
    DateTime datetime;
    String open;
    String high;
    String low;
    String close;
    String? volume;
    String? openInterest;
    int? count;

    OhlcDatum({
        required this.datetime,
        required this.open,
        required this.high,
        required this.low,
        required this.close,
        this.volume,
        this.openInterest,
        this.count,
    });

    factory OhlcDatum.fromJson(Map<String, dynamic> json) => OhlcDatum(
        datetime: DateTime.parse(json["datetime"]),
        open: json["open"],
        high: json["high"],
        low: json["low"],
        close: json["close"],
        volume: json["volume"],
        openInterest: json["open_interest"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "datetime": datetime.toIso8601String(),
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "open_interest": openInterest,
        "count": count,
    };
}
