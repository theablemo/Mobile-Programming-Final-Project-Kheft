class Login {
  String username = "";
  String password = "";

  Login(String username, String password) {
    this.username = username;
    this.password = password;
  }

  Map<String, dynamic> toJson() => {'Username': username, 'Password': password};
}
