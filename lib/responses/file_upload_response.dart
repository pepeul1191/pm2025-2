class FileUploadResponse {
  final String originalFilename;
  final String newFilename;
  final String path;

  FileUploadResponse({
    required this.originalFilename,
    required this.newFilename,
    required this.path,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      originalFilename: json['original_filename'] as String,
      newFilename: json['new_filename'] as String,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_filename': originalFilename,
      'new_filename': newFilename,
      'path': path,
    };
  }

  @override
  String toString() {
    return 'FileUploadResponse{originalFilename: $originalFilename, newFilename: $newFilename, path: $path}';
  }
}
