class RenderModel {
  String name = "";
  String image = "";
  int id = 1;
  int gender = 1;
  List<int> position = [];
  int attribute = 1;
  int rangeType = 1;
  int complexityLevel = 1;
  int releasedYear = 2004;

  DateTime selectedDateTime = DateTime(2000);

  RenderModel(
      {required this.name,
      required this.id,
      required this.position,
      required this.attribute,
      required this.complexityLevel,
      required this.gender,
      required this.image,
      required this.rangeType,
      required this.selectedDateTime,
      required this.releasedYear});

  factory RenderModel.fromJson({required Map<String, dynamic> json}) {
    List<int> tempList = [];
    for (var r in json['position']) {
      tempList.add(r);
    }
    return RenderModel(
        name: json['localized_name'],
        id: json['id'],
        position: tempList,
        attribute: json['attribute'],
        complexityLevel: json['complexity'],
        gender: json['gender'],
        image: json['url_full_portrait'],
        rangeType: json['rangeType'],
        releasedYear: json['releaseYear'],
        selectedDateTime: DateTime(2000));
  }
}
