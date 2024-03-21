class RenderModel {
  String name = "";
  String image = "";
  String gender = "male";
  List<String> position = [];
  String attribute = "agility";
  String rangeType = "melee";
  String complexityLevel = "easy";
  String releasedYear = "2004";

  DateTime selectedDateTime = DateTime(2000);

  RenderModel(
      {required this.name,
      required this.position,
      required this.attribute,
      required this.complexityLevel,
      required this.gender,
      required this.image,
      required this.rangeType,
      required this.selectedDateTime,
      required this.releasedYear});

  factory RenderModel.fromJson({required Map<String, dynamic> json}) {
    List<String> tempList = [];
    for (var r in json['position']) {
      tempList.add(r);
    }
    return RenderModel(
        name: json['localized_name'],
        position: tempList,
        attribute: json['attribute'],
        complexityLevel: json['complexity'],
        gender: json['gender'].first,
        image: json['url_full_portrait'],
        rangeType: json['rangeType'].first,
        releasedYear: json['releaseYear'],
        selectedDateTime: DateTime(2000));
  }
}
