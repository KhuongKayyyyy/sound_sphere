class User {
  static int _idCounter = 0;
  int id;
  String name;
  String password;
  String email;
  String avatarURL;

  User({
    required this.name,
    required this.password,
    required this.email,
    required this.avatarURL,
  }) : id = ++_idCounter;

  String get lastName {
    List<String> nameParts = name.split(' ');
    return nameParts.isNotEmpty ? nameParts.last : '';
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, avatarURL: $avatarURL}';
  }
}
