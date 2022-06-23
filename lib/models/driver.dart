class Driver {
  final String firstname;
  final String lastname;
  final String code;
  final String number;
  final String nationality;
  final String dateOfBirth;
  final String url_bio;

  Driver(this.firstname, this.lastname, this.code, this.number,
      this.nationality, this.dateOfBirth, this.url_bio);

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        json["givenName"],
        json["familyName"],
        json["code"],
        json["permanentNumber"],
        json["nationality"],
        json["dateOfBirth"],
        json["url"]);
  }
}
