mixin DevelopmentSectionMixin {
  double getProgressValue(int total, int finished) {
    try {
      return finished / total;
    } catch (e) {
      return 0;
    }
  }
}
