import 'dart:typed_data'; // Import necesario para Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/file_entity.dart';

class FileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FileDataSource({required this.firestore, required this.storage});

  /// Subir un archivo
  Future<void> uploadFile(FileEntity file, List<int> fileBytes) async {
    // Convertir List<int> a Uint8List
    final Uint8List uint8FileBytes = Uint8List.fromList(fileBytes);

    final storageRef = storage.ref().child('files/${file.subjectId}/${file.name}');
    final uploadTask = storageRef.putData(uint8FileBytes);

    await uploadTask.whenComplete(() async {
      final downloadUrl = await storageRef.getDownloadURL();

      // Actualizar el campo `downloadUrl` en el FileEntity
      final updatedFile = FileEntity(
        id: file.id,
        name: file.name,
        extension: file.extension,
        size: file.size,
        downloadUrl: downloadUrl,
        subjectId: file.subjectId,
        uploadedAt: file.uploadedAt,
      );

      // Usar toMap para guardar en Firestore
      await firestore.collection('files').doc(file.id).set(updatedFile.toMap());
    });
  }

  /// Obtener archivos por `subjectId`
  Future<List<FileEntity>> getFiles(String subjectId) async {
    try {
      final querySnapshot = await firestore
          .collection('files')
          .where('subjectId', isEqualTo: subjectId)
          .get();

      // Usar fromMap para convertir los datos
      return querySnapshot.docs.map((doc) {
        return FileEntity.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error al obtener archivos: $e');
      throw Exception('Error al obtener archivos: $e');
    }
  }

  /// Eliminar un archivo
  Future<void> deleteFile(String fileId, String storagePath) async {
    try {
      // Eliminar de Firestore
      await firestore.collection('files').doc(fileId).delete();

      // Eliminar de Firebase Storage
      await storage.ref(storagePath).delete();
    } catch (e) {
      print('Error al eliminar el archivo: $e');
      throw Exception('Error al eliminar el archivo: $e');
    }
  }
}
