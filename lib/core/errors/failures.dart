/// Failure classes for representing errors in the domain layer
abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class StorageFailure extends Failure {
  const StorageFailure(String message) : super(message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String message) : super(message);
}

class ModelFailure extends Failure {
  final String modelId;
  
  const ModelFailure(String message, this.modelId) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class AudioFailure extends Failure {
  const AudioFailure(String message) : super(message);
}

class STTFailure extends Failure {
  const STTFailure(String message) : super(message);
}

class NormalizationFailure extends Failure {
  const NormalizationFailure(String message) : super(message);
}

class SignMappingFailure extends Failure {
  const SignMappingFailure(String message) : super(message);
}

class AvatarFailure extends Failure {
  const AvatarFailure(String message) : super(message);
}

class ExportFailure extends Failure {
  const ExportFailure(String message) : super(message);
}
