class DateFormatter {
  final DateTime date;
  const DateFormatter(this.date);

  String mmyy() {
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(2);
    return "$month/$year";
  }

  String ddmm() {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return "$day/$month";
  }
}
