class UserSettings {
  final String id;
  final String user_id;
  final String language;
  final String theme;
  final String currency;

  UserSettings({
    required this.id,
    required this.user_id,
    required this.language,
    required this.theme,
    required this.currency,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      id: json['id'],
      user_id: json['user_id'],
      language: json['language'],
      theme: json['theme'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'language': language,
      'theme': theme,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return 'UserSettings{id: $id, user_id: $user_id, language: $language, theme: $theme, currency: $currency}';
  }
}
