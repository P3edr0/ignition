import 'package:ignition/domain/entities/igde_entity.dart';

class UserEntity extends IgdeEntity {
  @override
  int? id;
  @override
  String? name;
  @override
  String? email;
  String? tags;
  @override
  String? createAt;

  UserEntity({this.name, this.email, this.id, this.tags, this.createAt});
}
