import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;  // ObjectBox will generate IDs automatically
  String uid;
  String name;
  String email;
  String phone;

  User({
    this.id = 0,  // Default ID is 0, which will be auto-incremented
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
  });
}
