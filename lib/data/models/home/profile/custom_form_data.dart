class CustomFormData {
  final Map<String, dynamic> fields;

  CustomFormData({required this.fields});

  // Add toJson() method to make it serializable
  Map<String, dynamic> toJson() {
    return fields.map((key, value) {
      if (value is CustomMultipartFile) {
        return MapEntry(key, value.toJson());  // Assuming MultipartFile needs to be serialized too
      }
      return MapEntry(key, value);
    });
  }
}

class CustomMultipartFile {
  final String path;
  final String filename;

  CustomMultipartFile({required this.path, required this.filename});

  // Add toJson() method for MultipartFile
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'filename': filename,
    };
  }
}