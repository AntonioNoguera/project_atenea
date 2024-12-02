import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';

class SubjectEntity {
  final String id;
  final String name;
  final String planName;
  final PlanContentEntity? subjectPlanData; // Ahora es opcional
  final String parentAcademy; // Almacenar como cadena de texto
  final String lastModificationDateTime;
  final String lastModificationContributor;

  SubjectEntity({
    String? id,
    required this.name,
    required this.planName,
    this.subjectPlanData, // Campo opcional
    required DocumentReference parentAcademy,
    required this.lastModificationContributor,
    required this.lastModificationDateTime,
  })  : id = id ?? const Uuid().v4(),
        parentAcademy = parentAcademy.path; // Convertir a path como String

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'planName': planName,
      'subjectPlanData': subjectPlanData?.toMap(), // Convertir solo si no es null
      'parentAcademy': parentAcademy, // Almacena el path como String
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
    };
  }

  // Método para convertir desde Map
  factory SubjectEntity.fromMap(
    String id,
    Map<String, dynamic> data,
    FirebaseFirestore firestore,
  ) {
    return SubjectEntity(
      id: id,
      name: data['name'] ?? '',
      planName: data['planName'] ?? '',
      subjectPlanData: data['subjectPlanData'] != null
          ? PlanContentEntity.fromMap(data['subjectPlanData'])
          : null, // Manejar null para subjectPlanData
      parentAcademy: firestore.doc(data['parentAcademy'] ?? ''), // Convertir el path a DocumentReference
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
    );
  }
}
