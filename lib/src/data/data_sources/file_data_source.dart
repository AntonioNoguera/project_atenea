import 'dart:typed_data'; // Import necesario para Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/file_entity.dart';

class FileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FileDataSource(this.firestore, this.storage);

  /// Subir un archivo
  Future<void> uploadFile(FileEntity file, List<int> fileBytes) async {
    try {
      print('--- INICIO DEL PROCESO DE SUBIDA ---');
      print('Archivo a subir: ${file.name}');
      print('ID del archivo: ${file.id}');
      print('subjectId del archivo: ${file.subjectId}');

      // Convertir List<int> a Uint8List
      final Uint8List uint8FileBytes = Uint8List.fromList(fileBytes);
      print('Bytes del archivo convertidos a Uint8List.');

      // Referencia al almacenamiento
      final storageRef =
          storage.ref().child('files/${file.subjectId}/${file.name}');
      print('Referencia creada para el archivo en Storage: files/${file.subjectId}/${file.name}');

      // Subir archivo
      final uploadTask = storageRef.putData(uint8FileBytes);
      print('Comenzando la tarea de subida para el archivo: ${file.name}');

      // Esperar a que se complete la subida
      await uploadTask.whenComplete(() async {
        print('Tarea de subida completada para el archivo: ${file.name}');

        // Obtener la URL de descarga
        final downloadUrl = await storageRef.getDownloadURL();
        print('URL de descarga obtenida: $downloadUrl');

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
        print('Objeto FileEntity actualizado con la URL de descarga: ${updatedFile.toMap()}');

        // Guardar el archivo actualizado en Firestore
        print(
            'Guardando el archivo actualizado en Firestore con ID: ${file.id}');
        await firestore
            .collection('files')
            .doc(file.id)
            .set(updatedFile.toMap());
        print('Archivo guardado correctamente en Firestore con ID: ${file.id}');
      });
      print('--- FIN DEL PROCESO DE SUBIDA ---');
    } catch (e, stackTrace) {
      // Captura de errores
      print('--- ERROR DURANTE EL PROCESO DE SUBIDA ---');
      print('Error al subir el archivo: ${file.name}');
      print('Excepción: $e');
      print('StackTrace: $stackTrace');
      print('--- FIN DEL ERROR ---');
      rethrow; // Lanza el error nuevamente si necesitas manejarlo en otro nivel
    }
  }

  /// Obtener archivos por `subjectId`
  Future<List<FileEntity>> getFiles(String subjectId) async {
    try {
      print('--- INICIO DEL PROCESO PARA OBTENER ARCHIVOS ---');
      print('Obteniendo archivos para subjectId: $subjectId');

      final querySnapshot = await firestore
          .collection('files')
          .where('subjectId', isEqualTo: subjectId)
          .get();

      print('Archivos obtenidos de Firestore: ${querySnapshot.docs.length} archivos encontrados.');

      // Usar fromMap para convertir los datos
      final files = querySnapshot.docs.map((doc) {
        print('Archivo encontrado: ${doc.id} -> ${doc.data()}');
        return FileEntity.fromMap(doc.data(), doc.id);
      }).toList();

      print('Archivos convertidos a FileEntity: $files');
      print('--- FIN DEL PROCESO PARA OBTENER ARCHIVOS ---');
      return files;
    } catch (e) {
      print('--- ERROR DURANTE EL PROCESO PARA OBTENER ARCHIVOS ---');
      print('Error al obtener archivos para subjectId: $subjectId');
      print('Excepción: $e');
      print('--- FIN DEL ERROR ---');
      throw Exception('Error al obtener archivos: $e');
    }
  }

  /// Eliminar un archivo
  Future<void> deleteFile(String fileId, String storagePath) async {
    try {
      print('--- INICIO DEL PROCESO PARA ELIMINAR ARCHIVO ---');
      print('Archivo a eliminar con ID: $fileId');
      print('Ruta en Storage: $storagePath');

      // Eliminar de Firestore
      await firestore.collection('files').doc(fileId).delete();
      print('Archivo eliminado de Firestore con ID: $fileId');

      // Eliminar de Firebase Storage
      await storage.ref(storagePath).delete();
      print('Archivo eliminado de Firebase Storage: $storagePath');

      print('--- FIN DEL PROCESO PARA ELIMINAR ARCHIVO ---');
    } catch (e) {
      print('--- ERROR DURANTE EL PROCESO PARA ELIMINAR ARCHIVO ---');
      print('Error al eliminar el archivo con ID: $fileId');
      print('Excepción: $e');
      print('--- FIN DEL ERROR ---');
      throw Exception('Error al eliminar el archivo: $e');
    }
  }
}
