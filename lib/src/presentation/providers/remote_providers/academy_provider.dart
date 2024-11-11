// presentation/providers/academy_provider.dart

import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/academy_use_case.dart';

class AcademyProvider with ChangeNotifier {
  final GetAcademyById getAcademyByIdUseCase;
  final AddAcademy addAcademyUseCase;
  final UpdateAcademy updateAcademyUseCase;
  final DeleteAcademy deleteAcademyUseCase;
  final GetAllAcademies getAllAcademiesUseCase;

  AcademyProvider({
    required this.getAcademyByIdUseCase,
    required this.addAcademyUseCase,
    required this.updateAcademyUseCase,
    required this.deleteAcademyUseCase,
    required this.getAllAcademiesUseCase,
  });

  Future<AcademyEntity?> getAcademy(String id) async {
    print('Obteniendo academia con ID: $id');
    final academy = await getAcademyByIdUseCase(id);
    print('Academia obtenida: ${academy.toString()}');
    return academy;
  }

  Future<void> addAcademy(AcademyEntity academy) async {
    print('Guardando nueva academia: $academy');
    await addAcademyUseCase(academy);
    print('Academia guardada');
    notifyListeners();
  }

  Future<void> updateAcademy(AcademyEntity academy) async {
    print('Actualizando academia: $academy');
    await updateAcademyUseCase(academy);
    print('Academia actualizada');
    notifyListeners();
  }

  Future<void> deleteAcademy(String id) async {
    print('Eliminando academia con ID: $id');
    await deleteAcademyUseCase(id);
    print('Academia eliminada');
    notifyListeners();
  }

  Future<List<AcademyEntity>> getAllAcademies() async {
    print('Obteniendo todas las academias');
    final academies = await getAllAcademiesUseCase();
    print('Academias obtenidas: $academies');
    return academies;
  }
}
