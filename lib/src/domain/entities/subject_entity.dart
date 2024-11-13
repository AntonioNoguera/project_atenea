import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';

class SubjectEntity {
  final String id;
  final String name;
  final String planName;
  final PlanContentEntity subjectPlanData;
  final String parentAcademy;  // Almacenar como cadena de texto
  final String lastModificationDateTime;
  final String lastModificationContributor;

  SubjectEntity({
    String? id,
    required this.name,
    required this.planName,
    required this.subjectPlanData,
    required DocumentReference parentAcademy,  // Recibe como DocumentReference
    required this.lastModificationContributor,
    required this.lastModificationDateTime,
  })  : id = id ?? const Uuid().v4(),
        parentAcademy = parentAcademy.path; // Almacena como String de path

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'planName': planName,
      'subjectPlanData': subjectPlanData.toMap(),  // Convertir objeto a Map directamente
      'parentAcademy': parentAcademy,  // Almacena el path
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
    };
  }

  // Método para convertir desde Map
  factory SubjectEntity.fromMap(String id, Map<String, dynamic> data, FirebaseFirestore firestore) {
    return SubjectEntity(
      id: id,
      name: data['name'] ?? '',
      planName: data['planName'] ?? '',
      subjectPlanData: PlanContentEntity.fromMap(data['subjectPlanData'] ?? {}),  // Convertir Map a PlanContentEntity
      parentAcademy: firestore.doc(data['parentAcademy'] ?? ''),  // Convertir el path a DocumentReference
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
    );
  }
}
