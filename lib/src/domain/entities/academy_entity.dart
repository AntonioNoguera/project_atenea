import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';  

class AcademyEntity {
  final String id; 
  final String name;
  final List<UserEntity> autorizedAdmins;
  final List<DocumentReference> subjects;
   
  final String lastModificationDateTime = DateTime.now().toString();
  final String lastModificationContributor;

  AcademyEntity({
    required this.id, 
    required this.name,
    required this.autorizedAdmins,
    this.subjects = const [],
    this.lastModificationContributor = '',
  });
}