extension DateTimeExtensions on DateTime {
  String format() {
    return "${months[month - 1]}, $year";
  }
}
List<String> months = [
  "Yanvar",
  "Fevral",
  "Mart",
  "Aprel",
  "May",
  "Iyun",
  "Iyul",
  "Avgust",
  "Sentabr",
  "Oktabr",
  "Noyabr",
  "Dekabr",
];