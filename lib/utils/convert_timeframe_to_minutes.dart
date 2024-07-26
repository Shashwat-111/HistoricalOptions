int convertTimeFrameToMinutes(String timeFrame) {
  switch (timeFrame) {
    case '1m':
      return 1;
    case '5m':
      return 5;
    case '15m':
      return 15;
    default:
      throw ArgumentError('Unsupported time frame: $timeFrame');
  }
}