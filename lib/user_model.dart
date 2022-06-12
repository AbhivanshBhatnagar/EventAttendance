class User{
    final String? id;
    final bool? hasEaten;
    final bool? isPresent;

    User({this.id, this.hasEaten, this.isPresent});

    factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      hasEaten: json['hasEaten'],
      isPresent: json['isPresent'],
    );
  }
}