class NoticeModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime datePublication;
  final DateTime? dateUpdade;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.datePublication,
    required this.dateUpdade,
  });

  factory NoticeModel.fromJson(Map map) {
    return NoticeModel(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'],
      image: map['image'],
      datePublication:
          DateTime.fromMicrosecondsSinceEpoch(map['datePublication']),
      dateUpdade: map['dateUpdade'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['dateUpdade'])
          : null,
    );
  }

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
    };
  }

  @override
  String toString() {
    return """
      NoticeModel({
          id: $id,
          title: $title,
          description: $description,
          image: $image,
          datePublication: $datePublication,
          dateUpdade: $dateUpdade,
        })
      """;
  }
}
