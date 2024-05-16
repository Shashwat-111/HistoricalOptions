import 'package:fno_view/data/datalist.dart';

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;


    List<ChartSampleData> getChartData(int a) {
    if (a==1) {
          return list1;
    }
    if (a==2){
      return <ChartSampleData>[
    ChartSampleData(
      x: DateTime(2024, 05, 08),
      open: 112.34,
      high: 115.67,
      low: 110.98,
      close: 114.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 05, 15),
      open: 116.78,
      high: 119.45,
      low: 114.32,
      close: 117.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 05, 22),
      open: 120.01,
      high: 123.56,
      low: 118.90,
      close: 122.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 05, 29),
      open: 124.56,
      high: 127.89,
      low: 122.34,
      close: 126.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 06, 05),
      open: 128.90,
      high: 132.45,
      low: 127.78,
      close: 131.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 06, 12),
      open: 132.34,
      high: 135.67,
      low: 130.98,
      close: 134.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 06, 19),
      open: 136.78,
      high: 139.45,
      low: 134.32,
      close: 137.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 06, 26),
      open: 140.01,
      high: 143.56,
      low: 138.90,
      close: 142.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 07, 03),
      open: 144.56,
      high: 147.89,
      low: 142.34,
      close: 146.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 07, 10),
      open: 148.90,
      high: 152.45,
      low: 147.78,
      close: 151.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 07, 17),
      open: 152.34,
      high: 155.67,
      low: 150.98,
      close: 154.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 07, 24),
      open: 156.78,
      high: 159.45,
      low: 154.32,
      close: 157.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 07, 31),
      open: 160.01,
      high: 163.56,
      low: 158.90,
      close: 162.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 08, 07),
      open: 164.56,
      high: 167.89,
      low: 162.34,
      close: 166.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 08, 14),
      open: 168.90,
      high: 172.45,
      low: 167.78,
      close: 171.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 08, 21),
      open: 172.34,
      high: 175.67,
      low: 170.98,
      close: 174.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 08, 28),
      open: 176.78,
      high: 179.45,
      low: 174.32,
      close: 177.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 09, 04),
      open: 180.01,
      high: 183.56,
      low: 178.90,
      close: 182.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 09, 11),
      open: 184.56,
      high: 187.89,
      low: 182.34,
      close: 186.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 09, 18),
      open: 188.90,
      high: 192.45,
      low: 187.78,
      close: 191.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 09, 25),
      open: 192.34,
      high: 195.67,
      low: 190.98,
      close: 194.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 10, 02),
      open: 196.78,
      high: 199.45,
      low: 194.32,
      close: 197.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 10, 09),
      open: 200.01,
      high: 203.56,
      low: 198.90,
      close: 202.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 10, 16),
      open: 204.56,
      high: 207.89,
      low: 202.34,
      close: 206.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 10, 23),
      open: 208.90,
      high: 212.45,
      low: 207.78,
      close: 211.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 10, 30),
      open: 212.34,
      high: 215.67,
      low: 210.98,
      close: 214.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 11, 06),
      open: 216.78,
      high: 219.45,
      low: 214.32,
      close: 217.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 11, 13),
      open: 220.01,
      high: 223.56,
      low: 218.90,
      close: 222.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 11, 20),
      open: 224.56,
      high: 227.89,
      low: 222.34,
      close: 226.78,
    ),
    ChartSampleData(
      x: DateTime(2024, 11, 27),
      open: 228.90,
      high: 232.45,
      low: 227.78,
      close: 231.23,
    ),
    ChartSampleData(
      x: DateTime(2024, 12, 04),
      open: 232.34,
      high: 235.67,
      low: 230.98,
      close: 234.56,
    ),
    ChartSampleData(
      x: DateTime(2024, 12, 11),
      open: 236.78,
      high: 239.45,
      low: 234.32,
      close: 237.89,
    ),
    ChartSampleData(
      x: DateTime(2024, 12, 18),
      open: 240.01,
      high: 243.56,
      low: 238.90,
      close: 242.34,
    ),
    ChartSampleData(
      x: DateTime(2024, 12, 25),
      open: 244.56,
      high: 247.89,
      low: 242.34,
      close: 246.78,
    ),
  ];
    }
    else {
      return <ChartSampleData>[
      ChartSampleData(
          x: DateTime(2016, 01, 11),
          open: 98.97,
          high: 101.19,
          low: 95.36,
          close: 97.13),
      ChartSampleData(
          x: DateTime(2016, 01, 18),
          open: 98.41,
          high: 101.46,
          low: 93.42,
          close: 101.42),
      ChartSampleData(
          x: DateTime(2016, 01, 25),
          open: 101.52,
          high: 101.53,
          low: 92.39,
          close: 97.34),
      ChartSampleData(
          x: DateTime(2016, 02, 01),
          open: 96.47,
          high: 97.33,
          low: 93.69,
          close: 94.02),
      ChartSampleData(
          x: DateTime(2016, 02, 08),
          open: 93.13,
          high: 96.35,
          low: 92.59,
          close: 93.99),
      ];
    }
  }
}

