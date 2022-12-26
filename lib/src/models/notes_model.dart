class NotesModel{
  String title;
  String description;
  String creationTime;
  String? id;

  NotesModel({required this.title,required this.description,required this.creationTime, this.id});

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      title: json["title"],
      description: json["description"],
      creationTime: json["creationTime"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "description": this.description,
      "creationTime": this.creationTime,
      "id": this.id,
    };
  }
//

//
}