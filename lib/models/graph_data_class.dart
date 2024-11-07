// To parse this JSON data, do
//
//     final optionData = optionDataFromJson(jsonString);

import 'dart:convert';

OptionsData optionsDataFromJson(String str) => OptionsData.fromJson(json.decode(str));

String optionsDataToJson(OptionsData data) => json.encode(data.toJson());

class OptionsData {
    String exchangeCode;
    String expiryDate;
    List<OhlcDatum> ohlcData;
    String productType;
    String right;
    String stockCode;
    int strikePrice;

    OptionsData({
        required this.exchangeCode,
        required this.expiryDate,
        required this.ohlcData,
        required this.productType,
        required this.right,
        required this.stockCode,
        required this.strikePrice,
    });

    factory OptionsData.fromJson(Map<String, dynamic> json) => OptionsData(
        exchangeCode: json["exchange_code"],
        expiryDate: json["expiry_date"],
        ohlcData: List<OhlcDatum>.from(json["ohlc_data"].map((x) => OhlcDatum.fromJson(x))),
        productType: json["product_type"],
        right: json["right"],
        stockCode: json["stock_code"],
        strikePrice: int.parse(json["strike_price"]),
    );

    Map<String, dynamic> toJson() => {
        "exchange_code": exchangeCode,
        "expiry_date": expiryDate,
        "ohlc_data": List<dynamic>.from(ohlcData.map((x) => x.toJson())),
        "product_type": productType,
        "right": right,
        "stock_code": stockCode,
        "strike_price": strikePrice,
    };
}

class OhlcDatum {
    String close;
    int count;
    DateTime datetime;
    String high;
    String low;
    String open;
    int openInterest;
    int volume;

    OhlcDatum({
        required this.close,
        required this.count,
        required this.datetime,
        required this.high,
        required this.low,
        required this.open,
        required this.openInterest,
        required this.volume,
    });

    factory OhlcDatum.fromJson(Map<String, dynamic> json) => OhlcDatum(
        close: json["close"],
        count: json["count"],
        datetime: DateTime.parse(json["datetime"]),
        high: json["high"],
        low: json["low"],
        open: json["open"],
        openInterest: int.parse(json["open_interest"]),
        volume: int.parse(json["volume"]),
    );

    Map<String, dynamic> toJson() => {
        "close": close,
        "count": count,
        "datetime": datetime.toIso8601String(),
        "high": high,
        "low": low,
        "open": open,
        "open_interest": openInterest,
        "volume": volume,
    };
}


List<OhlcDatum> aggregateOHLC(List<OhlcDatum> ohlcData, int intervalMinutes) {
    List<OhlcDatum> result = [];
    ohlcData.sort((a, b) => a.datetime.compareTo(b.datetime));

    DateTime? currentIntervalStart;
    List<OhlcDatum> chunk = [];

    for (var datum in ohlcData) {
        currentIntervalStart ??= datum.datetime;

        if (datum.datetime.difference(currentIntervalStart).inMinutes < intervalMinutes) {
            chunk.add(datum);
        } else {
            result.add(_aggregateChunk(chunk));
            chunk = [datum];
            currentIntervalStart = datum.datetime;
        }
    }

    if (chunk.isNotEmpty) {
        result.add(_aggregateChunk(chunk));
    }

    return result;
}

OhlcDatum _aggregateChunk(List<OhlcDatum> chunk) {
    double open = double.parse(chunk.first.open);
    double close = double.parse(chunk.last.close);
    double high = chunk.map((e) => double.parse(e.high)).reduce((a, b) => a > b ? a : b);
    double low = chunk.map((e) => double.parse(e.low)).reduce((a, b) => a < b ? a : b);
    int volume = chunk.map((e) => e.volume).reduce((a, b) => a + b);
    int openInterest = chunk.last.openInterest;

    return OhlcDatum(
        open: open.toString(),
        high: high.toString(),
        low: low.toString(),
        close: close.toString(),
        count: chunk.length,
        datetime: chunk.first.datetime,
        openInterest: openInterest,
        volume: volume,
    );
}