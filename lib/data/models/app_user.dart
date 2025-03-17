class AppUser {
  final String displayName;
  final String country;
  final String avatarUrl;
  final String email;

  AppUser({
    required this.displayName,
    required this.country,
    required this.avatarUrl,
    required this.email,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      displayName: json['display_name'],
      country: json['country'],
      avatarUrl: json['avatar_url'],
      email: json['email'],
    );
  }

  factory AppUser.empty() {
    return AppUser(
      displayName: '',
      country: '',
      avatarUrl: '',
      email: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'country': country,
      'avatar_url': avatarUrl,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'AppUser(displayName: $displayName, country: $country, avatarUrl: $avatarUrl, email: $email)';
  }
}
