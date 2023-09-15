class NoticeModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime datePublic;
  final DateTime? dateUpdade;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.datePublic,
    required this.dateUpdade,
  });

  @override
  String toString() {
    return """
      NoticeModel({
          id: $id,
          title: $title,
          description: $description,
          image: $image,
          datePublic: $datePublic,
          dateUpdade: $dateUpdade,
        })
      """;
  }
}
