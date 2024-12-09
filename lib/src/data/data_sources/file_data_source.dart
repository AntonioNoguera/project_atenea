import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/file_entity.dart';

abstract class FileRemoteDataSource {
  Future<void> uploadFile(FileEntity file, List<int> fileBytes);
  Stream<List<FileEntity>> getFiles(String subjectId);
  Future<void> deleteFile(String fileId, String storagePath);
}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FileRemoteDataSourceImpl({required this.firestore, required this.storage});

  @override
  Future<void> uploadFile(FileEntity file, List<int> fileBytes) async {
    final storageRef = storage.ref().child('files/${file.subjectId}/${file.name}');
    final uploadTask = storageRef.putData(fileBytes);

    await uploadTask.whenComplete(() async {
      final downloadUrl = await storageRef.getDownloadURL();

      final fileData = {
        'id': file.id,
        'name': file.name,
        'extension': file.extension,
        'size': file.size,
        'downloadUrl': downloadUrl,
        'subjectId': file.subjectId,
        'uploadedAt': file.uploadedAt,
      };

      await firestore.collection('files').doc(file.id).set(fileData);
    });
  }

  @override
  Stream<List<FileEntity>> getFiles(String subjectId) {
    return firestore
        .collection('files')
        .where('subjectId', isEqualTo: subjectId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return FileEntity(
          id: data['id'],
          name: data['name'],
          extension: data['extension'],
          size: data['size'],
          downloadUrl: data['downloadUrl'],
          subjectId: data['subjectId'],
          uploadedAt: data['uploadedAt'],
        );
      }).toList();
    });
  }

  @override
  Future<void> deleteFile(String fileId, String storagePath) async {
    // Eliminar de Firestore
    await firestore.collection('files').doc(fileId).delete();

    // Eliminar de Firebase Storage
    await storage.ref(storagePath).delete();
  }
}
