import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Functions{

  uploadImage(ImageSource source) async{
    final picker = ImagePicker();
    File? imageFile;
    try{
      final pickedImage = await picker.pickImage(source: source);
      if(pickedImage != null){
        imageFile =  File(pickedImage!.path);
        return imageFile;
      }
      else{
        return null;
      }

    }
    catch(e){
      print("Image Pick error : $e");
    }
  }

}