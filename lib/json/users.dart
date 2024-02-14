class Users {
  final int? usrId;
  final String usrName;
  final String usrPassword;
  final String userType; // Add userType as a property

  Users({
    this.usrId,
    required this.usrName,
    required this.usrPassword,
    required this.userType, // Include userType in the constructor
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrPassword: json["usrPassword"],
        userType: json["userType"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrPassword": usrPassword,
        "userType": userType,
      };
}
