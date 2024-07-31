import 'package:fno_view/controllers/chart_setting_controller.dart';

int convertTimeFrameToMinutes(CandleTimeFrame timeFrame) {
  switch (timeFrame) {
    case CandleTimeFrame.oneMinute:
      return 1;
    case CandleTimeFrame.fiveMinute:
      return 5;
    case CandleTimeFrame.fifteenMinute:
      return 15;
    default:
      throw ArgumentError('Unsupported time frame: $timeFrame');
  }
}