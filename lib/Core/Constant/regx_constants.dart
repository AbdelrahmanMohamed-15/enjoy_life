class RegxConstants {
  static const String emailPattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

  static const String english = r'([a-zA-Z]){3,40}';

  static const String symbolRegex = r'[^\w\s]';

  static const String numericRegex = r'[0-9]';

  static const String imageRegex = r'\.(jpg|jpeg|png|gif|bmp|webp|tiff|ico)$';

  static const String audioRegex = r'\.(mp3|wav|aac|flac|ogg|wma|m4a)$';

  static const String videoRegex = r'\.(mp4|mov|avi|mkv|wmv|flv|webm|temp|3gp|m4v)$';
}
