import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/file_use_case.dart'; 

class FileProvider with ChangeNotifier {
  final UploadFileUseCase uploadFileUseCase;
  final GetFilesUseCase getFilesUseCase;
  final DeleteFileUseCase deleteFileUseCase;

  FileProvider({
    required this.uploadFileUseCase,
    required this.getFilesUseCase,
    required this.deleteFileUseCase,
  });

  // Estado interno
  List<FileEntity> _files = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<FileEntity> get files => _files;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Subir un archivo
  Future<FileEntity> uploadFile(FileEntity file, List<int> fileBytes) async {
    _setLoading(true);
    try {
      print('Subiendo archivo: ${file.name}');
      await uploadFileUseCase.execute(file, fileBytes);
      print('Archivo subido con éxito');
      //await getFiles(file.subjectId);
      return FileEntity.defaultValue;
    } catch (e) {
      _setErrorMessage('Error al subir el archivo: $e');
    } finally {
      _setLoading(false);
    }
    
      return FileEntity.defaultValue;
  }

  /// Obtener archivos por `subjectId`
  Future<void> getFiles(String subjectId) async {
    _setLoading(true);
    try {
      print('Obteniendo archivos para el subjectId: $subjectId');
      _files = await getFilesUseCase.execute(subjectId);
      print('Archivos obtenidos: $_files');
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Error al obtener los archivos: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Eliminar un archivo
  Future<void> deleteFile(String fileId, String storagePath) async {
    _setLoading(true);
    try {
      print('Eliminando archivo con ID: $fileId');
      await deleteFileUseCase.execute(fileId, storagePath);
      print('Archivo eliminado con éxito');
      // Eliminar el archivo de la lista local
      _files.removeWhere((file) => file.id == fileId);
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Error al eliminar el archivo: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Métodos privados para manejar el estado
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
