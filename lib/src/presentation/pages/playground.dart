
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

 
import 'dart:io';
import 'package:image_picker/image_picker.dart'; 

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        print('Imagen seleccionada: ${pickedFile.path}');
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    } catch (e) {
      print('Error al seleccionar la imagen: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No hay imagen seleccionada para subir.');
      return;
    }

    try {
      print('Iniciando subida de imagen...');

      // Crear una referencia en Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      print('Referencia de almacenamiento creada: ${imageRef.fullPath}');

      // Subir el archivo
      final uploadTask = imageRef.putFile(_image!);

      // Escuchar el progreso de la subida
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Progreso de subida: $progress%');
      });

      // Esperar a que la tarea se complete
      final snapshot = await uploadTask.whenComplete(() {});
      print('Subida completada con éxito.');

      // Obtener la URL de descarga
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('URL de la imagen subida: $downloadUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imagen subida con éxito: $downloadUrl')),
      );
    } catch (e) {
      print('Error al subir la imagen: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir la imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subir Imagen a Firebase')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : const Text('No se ha seleccionado ninguna imagen.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Seleccionar Imagen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Subir Imagen'),
            ),
          ],
        ),
      ),
    );
  }
}