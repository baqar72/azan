import 'package:azan/AppManager/LocalStorage/Entity/user_model.dart';
import 'package:azan/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<User> _userBox;
  late final Query<User> _getUserByUidQuery;

  ObjectBoxService._create(this._store) {
    _userBox = Box<User>(_store);
    _prepareQueries();
  }

  // Check if there are any users stored
  bool hasAnyUser() {
    return _userBox.count() > 0;
  }

  static Future<ObjectBoxService> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${docsDir.path}/objectbox');
    return ObjectBoxService._create(store);
  }

  void _prepareQueries() {
    // Pre-build the query to find a user by UID
    _getUserByUidQuery = _userBox.query(User_.uid.equals('')).build();
  }

  // Save a new user to the local database
  Future<int> saveUser(User user) async {
    return _userBox.put(user);
  }

  // Get a user by UID
  User? getUserByUid(String uid) {
    _getUserByUidQuery.param(User_.uid).value = uid;
    return _getUserByUidQuery.findFirst();
  }

  // Get all users
  List<User> getAllUsers() {
    return _userBox.getAll();
  }

  // Delete a user by UID
  void deleteUserByUid(String uid) {
    _getUserByUidQuery.param(User_.uid).value = uid;
    final user = _getUserByUidQuery.findFirst();
    if (user != null) {
      _userBox.remove(user.id);
    }
  }

  // Update user details
  Future<void> updateUser(User updatedUser) async {
    final user = getUserByUid(updatedUser.uid);
    if (user != null) {
      user.name = updatedUser.name;
      user.email = updatedUser.email;
      user.phone = updatedUser.phone;
      _userBox.put(user);
    }
  }

  // Clear all users from the database
  void clearAllUsers() {
    _userBox.removeAll();
  }

  // Close the store when done
  void closeStore() {
    _getUserByUidQuery.close(); // Close the query when done
    _store.close();
  }
}
