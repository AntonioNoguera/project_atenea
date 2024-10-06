class SessionEntity {
  final String token;
  final UserType userLevel;


  SessionEntity({
    required this.token,
    required this.userLevel,
  });


  
}


enum UserType {
  superAdmin,
  admin,
  regularUser,
}