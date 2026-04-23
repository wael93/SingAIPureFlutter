class Validators {
  static bool isValidDuration(double duration) {
    return duration >= 1.0;
  }
  
  static bool isValidTextLength(String text, {int maxLength = 500}) {
    return text.length <= maxLength;
  }
  
  static bool isValidConfidence(double confidence) {
    return confidence >= 0.0 && confidence <= 1.0;
  }
}
