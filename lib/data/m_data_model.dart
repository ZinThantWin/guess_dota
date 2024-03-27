class DataModel {
  String name = "";
  String deviceId = "";
  double avgScore = 0.0;
  int victoryCount = 0;

  DataModel(
      {required this.name,
      required this.deviceId,
      required this.avgScore,
      required this.victoryCount});

  factory DataModel.fromJson({required Map<String, dynamic> json}) {
    return DataModel(
        name: json['name'],
        deviceId: json['deviceId'],
        avgScore: json['averageCount'].toDouble(),
        victoryCount: json['completedTime']);
  }
}
