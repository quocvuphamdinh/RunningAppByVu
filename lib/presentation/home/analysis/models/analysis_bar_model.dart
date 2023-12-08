class AnalysisBarModel {
  final int id;
  final String name;
  final double y;

  AnalysisBarModel({required this.id, required this.name, required this.y});

  static String getDayTitle(int day) {
    switch (day) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
    }
    return "";
  }
}
