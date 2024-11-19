class NewMessegeRequest {
  String? content;
  String? receiver_id;
  String? file;


  NewMessegeRequest._({
    this.content,
    this.receiver_id,
    this.file,

  });

  factory NewMessegeRequest.withFile({
     String? content,
    required String receiver_id,
   required String file,
 
  }) {
    return NewMessegeRequest._(
      content: content,
      receiver_id: receiver_id,
      file: file,
    
    );
  }


  Map<String, String?> toJson() {
    return {
     'file': null,
      if (receiver_id != null) 'receiver_id': receiver_id,
      if (content != null) 'content': content,

    
    };
  }
}
