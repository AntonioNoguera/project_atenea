import 'dart:typed_data'; // Import necesario para Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/file_entity.dart';

class FileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FileDataSource({required this.firestore, required this.storage});

  Future<void> uploadFile(FileEntity file, List<int> fileBytes) async {
    // Convertir List<int> a Uint8List
    final Uint8List uint8FileBytes = Uint8List.fromList(fileBytes);

    final storageRef = storage.ref().child('files/${file.subjectId}/${file.name}');
    final uploadTask = storageRef.putData(uint8FileBytes);

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

  Future<void> deleteFile(String fileId, String storagePath) async {
    // Eliminar de Firestore
    await firestore.collection('files').doc(fileId).delete();

    // Eliminar de Firebase Storage
    await storage.ref(storagePath).delete();
  }
}
