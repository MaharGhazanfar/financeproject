
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<File> pickImageFromMedia() async {
  File? image;


  if(Platform.isAndroid) {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 250,
        maxHeight: 250,
        imageQuality: 80);

    image = File(photo!.path);

    return image;
  }else{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['png', 'jpeg']);

    if (result != null) {
      image = File(result.files.single.path!);
    }

    return image!;
  }
}