class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String? profile_picture;
  final String? phone_number;
  final String? zip_code;
  final String account_type;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profile_picture,
    this.phone_number,
    this.zip_code,
    required this.account_type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profile_picture: json['profile_picture'],
      phone_number: json['phone_number'],
      zip_code: json['zip_code'],
      account_type: json['account_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profile_picture': profile_picture,
      'phone_number': phone_number,
      'zip_code': zip_code,
      'account_type': account_type,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, profile_picture: $profile_picture, phone_number: $phone_number, zip_code: $zip_code, account_type: $account_type}';
  }
}
