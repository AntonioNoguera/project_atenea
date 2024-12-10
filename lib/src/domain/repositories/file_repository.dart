import '../entities/file_entity.dart';

abstract class FileRepository {
  Future<void> uploadFile(FileEntity file, List<int> fileBytes);
  Future<List<FileEntity>> getFiles(String subjectId);
  Future<void> deleteFile(String fileId, String storagePath);
}
