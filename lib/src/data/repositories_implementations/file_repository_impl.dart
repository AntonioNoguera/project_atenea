import 'package:proyect_atenea/src/data/data_sources/file_data_source.dart';

import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/file_repository.dart'; 

class FileRepositoryImpl implements FileRepository {
  final FileDataSource remoteDataSource;

  FileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> uploadFile(FileEntity file, List<int> fileBytes) async {
    await remoteDataSource.uploadFile(file, fileBytes);
  }

  @override
  Stream<List<FileEntity>> getFiles(String subjectId) {
    return remoteDataSource.getFiles(subjectId);
  }

  @override
  Future<void> deleteFile(String fileId, String storagePath) async {
    await remoteDataSource.deleteFile(fileId, storagePath);
  }
}
