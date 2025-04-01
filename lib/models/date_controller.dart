class DateController {
  late DateTime selDate;

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  DateTime getDate() {
    return selDate;
  }

  void setDate(DateTime date) {
    selDate = date;
  }

  int getMonth() {
    return selDate.month;
  }

  void prevMonth() {
    if (selDate.month != 1) {
      selDate = DateTime(selDate.year, selDate.month - 1);
    } else {
      selDate = DateTime(selDate.year - 1, 12);
    }
  }

  void nextMonth() {
    if (selDate.month != 12) {
      selDate = DateTime(selDate.year, selDate.month + 1);
    } else {
      selDate = DateTime(selDate.year + 1, 1);
    }
  }
}
