class Note {

  int? id;
  String? createdAt;
  String? title;
  String? description;

  Note({
    this.id,
    this.createdAt,
    this.title,
    this.description,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

}