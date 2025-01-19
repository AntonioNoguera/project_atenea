import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';

class SubjectEntity {
  final String id;
  String name;
  final String planName;
  PlanContentEntity? subjectPlanData;
  final String parentAcademy;
  final String lastModificationDateTime;
  final String lastModificationContributor;

  SubjectEntity({
    String? id,
    required this.name,
    required this.planName,
    this.subjectPlanData,
    required DocumentReference parentAcademy,
    required this.lastModificationContributor,
    String? lastModificationDateTime,
  })  : id = id ?? const Uuid().v4(),
        parentAcademy = parentAcademy.path,
        lastModificationDateTime = lastModificationDateTime ?? DateTime.now().toString();

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'planName': planName,
      'subjectPlanData': subjectPlanData?.toMap(),
      'parentAcademy': parentAcademy,
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
  try {
  // Log para inspeccionar los datos de entrada
  print('[SubjectEntity.fromMap] ID recibido: $id');
  print('[SubjectEntity.fromMap] Datos recibidos: $data');

  // Validar si las claves esenciales están presentes
  if (!data.containsKey('name')) print('[SubjectEntity.fromMap] Clave "name" ausente');
  if (!data.containsKey('planName')) print('[SubjectEntity.fromMap] Clave "planName" ausente');
  if (!data.containsKey('subjectPlanData')) print('[SubjectEntity.fromMap] Clave "subjectPlanData" ausente');
  if (!data.containsKey('parentAcademy')) print('[SubjectEntity.fromMap] Clave "parentAcademy" ausente');
  if (!data.containsKey('lastModificationDateTime')) print('[SubjectEntity.fromMap] Clave "lastModificationDateTime" ausente');
  if (!data.containsKey('lastModificationContributor')) print('[SubjectEntity.fromMap] Clave "lastModificationContributor" ausente');

  
    // Intentar construir la entidad
    final entity = SubjectEntity(
      id: id,
      name: data['name'] ?? '',
      planName: data['planName'] ?? '',
      subjectPlanData: data['subjectPlanData'] != null
          ? PlanContentEntity.fromMap(Map<String, dynamic>.from(data['subjectPlanData'] as Map))
          : null,
      parentAcademy: firestore.doc(data['parentAcademy'] ?? ''),
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
    );
    
    print('[SubjectEntity.fromMap] Entidad creada con éxito: $entity');
    return entity;
  } catch (e, stacktrace) {
    // Log de errores en caso de fallo
    print('[SubjectEntity.fromMap] Error al crear SubjectEntity: $e');
    print('[SubjectEntity.fromMap] Stacktrace: $stacktrace');
    rethrow; // Re-lanzar el error para no perder el contexto
  }
}

}