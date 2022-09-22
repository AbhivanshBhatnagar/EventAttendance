class User {
  final String? rNo;
  final bool? hasEaten;
  final bool? isPresent;

  User({this.rNo, this.hasEaten, this.isPresent});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      rNo: json['registerNumber'],
      hasEaten: json['hasEaten'],
      isPresent: json['isPresent'],
    );
  }
}
