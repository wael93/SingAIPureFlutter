/// Exception classes for the application
class ExceptionBase implements Exception {
  final String message;
  
  ExceptionBase(this.message);
  
  @override
  String toString() => 'Exception: $message';
}

class NetworkException extends ExceptionBase {
  NetworkException(String message) : super(message);
}

class StorageException extends ExceptionBase {
  StorageException(String message) : super(message);
}

class PermissionException extends ExceptionBase {
  PermissionException(String message) : super(message);
}

class ModelException extends ExceptionBase {
  final String modelId;
  
  ModelException(String message, this.modelId) : super(message);
}

class CacheException extends ExceptionBase {
  CacheException(String message) : super(message);
}

class AudioException extends ExceptionBase {
  AudioException(String message) : super(message);
}

class STTException extends ExceptionBase {
  STTException(String message) : super(message);
}

class NormalizationException extends ExceptionBase {
  NormalizationException(String message) : super(message);
}

class SignMappingException extends ExceptionBase {
  SignMappingException(String message) : super(message);
}

class AvatarException extends ExceptionBase {
  AvatarException(String message) : super(message);
}

class ExportException extends ExceptionBase {
  ExportException(String message) : super(message);
}
