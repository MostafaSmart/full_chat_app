import 'package:chatapp_front/features/chat/domain/entities/file.dart';


class FileModle extends FileEnt {
  FileModle({ super.file_path, super.message_id});

  factory FileModle.fromJson(Map<String, dynamic> json) {
    return FileModle(
     
        file_path: json['file_path'],
        message_id : json['message_id']
        );
  }

  Map<String, dynamic> toJson() {
    return {
  "message_id": message_id,
"file_path": file_path
    };
  }
}
