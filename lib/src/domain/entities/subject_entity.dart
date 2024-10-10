import 'package:proyect_atenea/src/domain/entities/academy_entity.dart'; 
import 'package:proyect_atenea/src/domain/entities/plan_entity.dart'; 

class SubjectEntity {
  final String id; 
  
  final AcademyEntity parentAcademy;
  final List<PlanEntity> subjectPlanData;
  
  SubjectEntity({
    required this.id, 
    required this.parentAcademy, 
    required this.subjectPlanData,
  });
}