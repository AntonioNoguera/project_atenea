import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';

class SubjectEntity {
  final String id;
  final String name;
  final List<PlanContentEntity> subjectPlanData;
  final DocumentReference parentAcademy;
  final String lastModificationDateTime;
  final String lastModificationContributor;

  SubjectEntity({
    String? id,
    required this.name,
    required this.subjectPlanData,
    required this.parentAcademy,
    required this.lastModificationContributor,
    required this.lastModificationDateTime,
  }) : id = id ?? const Uuid().v4();

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subjectPlanData': subjectPlanData.map((plan) => plan.toMap()).toList(),
      'parentAcademy': parentAcademy.path,
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
    };
  }

  // Método para convertir desde Map
  factory SubjectEntity.fromMap(String id, Map<String, dynamic> data, FirebaseFirestore firestore) {
    return SubjectEntity(
      id: id,
      name: data['name'] ?? '',
      subjectPlanData: (data['subjectPlanData'] as List<dynamic>?)
              ?.map((plan) => PlanContentEntity.fromMap(plan as Map<String, dynamic>))
              .toList() ??
          [],
      parentAcademy: firestore.doc(data['parentAcademy'] ?? ''),
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
    );
  }
}
