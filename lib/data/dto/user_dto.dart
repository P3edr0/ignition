import 'package:ignition/domain/entities/user_entity.dart';

class UserDTO extends UserEntity {
  UserDTO({
    int? id,
    String? name,
    String? email,
    String? tags,
    String? createAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          tags: tags,
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

  static UserDTO fromMap(Map map) {
    return UserDTO(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      tags: map['tags'],
      createAt: map['create_at'],
    );
  }
}
