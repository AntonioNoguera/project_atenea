import '../entities/file_entity.dart';
import '../repositories/file_repository.dart';

/// Caso de uso para subir un archivo
class UploadFileUseCase {
  final FileRepository _repository;

  UploadFileUseCase(this._repository);

  Future<void> execute(FileEntity file, List<int> fileBytes) async {
    try {
      print('Subiendo archivo: ${file.name}');
      await _repository.uploadFile(file, fileBytes);
      print('Archivo subido con éxito');
    } catch (e) {
      print('Error al subir el archivo: $e');
      throw Exception('Error al subir el archivo: $e');
    }
  }
}

/// Caso de uso para obtener archivos por `subjectId`
class GetFilesUseCase {
  final FileRepository _repository;

  GetFilesUseCase(this._repository);

  Future<List<FileEntity>> execute(String subjectId) async {
    try {
      print('Obteniendo archivos para el subjectId: $subjectId');
      final filesStream = _repository.getFiles(subjectId);
      final files = await filesStream;
      print('Archivos obtenidos: $files');
      return files;
    } catch (e) {
      print('Error al obtener los archivos: $e');
      throw Exception('Error al obtener los archivos: $e');
    }
  }
}

/// Caso de uso para eliminar un archivo
class DeleteFileUseCase {
  final FileRepository _repository;

  DeleteFileUseCase(this._repository);

  Future<void> execute(String fileId, String storagePath) async {
    try {
      print('Eliminando archivo con ID: $fileId');
      await _repository.deleteFile(fileId, storagePath);
      print('Archivo eliminado con éxito');
    } catch (e) {
      print('Error al eliminar el archivo: $e');
      throw Exception('Error al eliminar el archivo: $e');
    }
  } 
}
