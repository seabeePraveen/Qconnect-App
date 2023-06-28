class User {
  String? username;
  String? email;
  String? name;
  String? phone_number;
  String profile_pic;

  User(
      {this.email,
      this.name,
      this.phone_number,
      this.username,
      required this.profile_pic});
}
