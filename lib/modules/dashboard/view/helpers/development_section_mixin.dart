mixin DevelopmentSectionMixin {
  double getProgressValue(int total, int finished) {
    try {
      final value =  finished / total;
      return value;
    } catch (e) {
      return 0;
    }
  }
}
