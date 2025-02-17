class Astrologer {
    final int id;
    final String firstName;
    final String lastName;
    final String astroType;
    final String avatar;
    final String about;
    final String phone;

    Astrologer({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.astroType,
        required this.avatar,
        required this.about,
        required this.phone,
    });

    factory Astrologer.fromJson(Map<String, dynamic> json) {
        return Astrologer(
            id: json['ID'],
            firstName: json['first_name'],
            lastName: json['last_name'],
            astroType: json['astro_type'],
            avatar: json['user_avatar'],
            about: json['user_about'],
            phone: json['user_phone'],
        );
    }
}