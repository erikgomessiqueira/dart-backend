class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UserModel();

  UserModel.create({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      id: map['id'] as int,
      name: map['nome'] as String,
      email: map['email'] as String,
      isActive: map['is_ativo'] == 1,
      dtCreated: map['dt_criacao'],
      dtUpdated: map['dt_autalizacao'],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id']
      ..password = map['password'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActive: $isActive, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
}
