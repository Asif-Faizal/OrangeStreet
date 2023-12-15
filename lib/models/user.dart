class Users {
  final String name;
  final String email;
  final String passWord;
  Users({required this.email, required this.passWord, required this.name});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'passWord': passWord,
    };
  }
}
