import 'package:ignition/domain/entities/igde_entity.dart';

class IgdeDTO extends IgdeEntity {
  IgdeDTO({
    int? id,
    String? name,
    String? email,
    String? createAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          createAt: createAt,
        );

  Map toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'create_at': createAt,
    };
  }

  static IgdeDTO fromMap(Map map) {
    return IgdeDTO(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      createAt: map['create_at'],
    );
  }
}
