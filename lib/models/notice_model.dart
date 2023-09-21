// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoticeModel {
  int? id;
  String? title;
  String? description;
  DateTime? dtCreate;
  DateTime? dtUpdate;
  int? userId;

  NoticeModel();

  factory NoticeModel.fromMap(Map map) {
    return NoticeModel()
      ..id = map['id']
      ..title = map['titulo']
      ..description = map['descricao'].toString()
      ..dtCreate = map['dt_criacao']
      ..dtUpdate = map['dt_autalizacao']
      ..userId = map['id_usuario'];
  }

  factory NoticeModel.fromRequest(map) {
    return NoticeModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..userId = map['userId'];
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return '''
      NoticeModel(
        id: $id, 
        title: $title, 
        description: $description, 
        dtCreate: $dtCreate, 
        dtUpdate: $dtUpdate, 
        userId: $userId,
      )''';
  }
}
