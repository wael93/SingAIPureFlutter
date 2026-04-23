enum InputType { voice, text }
enum TranslationStatus { pending, processing, completed, failed }
enum SignLanguageVariant { asl, bsl, other }
enum SignType { video, image, gesture_description }

class TranslationRequest {
  final String id;
  final InputType inputType;
  final String inputContent;
  final String language;
  final SignLanguageVariant signVariant;
  final DateTime createdAt;
  final TranslationStatus status;
  final String? cacheKey;
  
  TranslationRequest({
    required this.id,
    required this.inputType,
    required this.inputContent,
    required this.language,
    required this.signVariant,
    required this.createdAt,
    this.status = TranslationStatus.pending,
    this.cacheKey,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inputType': inputType.name,
      'inputContent': inputContent,
      'language': language,
      'signVariant': signVariant.name,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'cacheKey': cacheKey,
    };
  }
  
  factory TranslationRequest.fromJson(Map<String, dynamic> json) {
    return TranslationRequest(
      id: json['id'] as String,
      inputType: InputType.values.firstWhere(
        (e) => e.name == json['inputType'],
        orElse: () => InputType.text,
      ),
      inputContent: json['inputContent'] as String,
      language: json['language'] as String,
      signVariant: SignLanguageVariant.values.firstWhere(
        (e) => e.name == json['signVariant'],
        orElse: () => SignLanguageVariant.asl,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: TranslationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TranslationStatus.pending,
      ),
      cacheKey: json['cacheKey'] as String?,
    );
  }
}

class TranslationResult {
  final String id;
  final String requestId;
  final String text;
  final String normalizedText;
  final List<SignMapping> signMappings;
  final Duration processingTime;
  
  TranslationResult({
    required this.id,
    required this.requestId,
    required this.text,
    required this.normalizedText,
    required this.signMappings,
    required this.processingTime,
  });
}

class SignMapping {
  final String word;
  final String? signId;
  final double confidence;
  final SignType signType;
  final List<String> alternatives;
  
  SignMapping({
    required this.word,
    this.signId,
    this.confidence = 0.0,
    this.signType = SignType.video,
    this.alternatives = const [],
  });
}
