class OnboardingModel {
  final String? title;
  final String? firstSectionTitle;
  final String? secondSectionTitle;
  final String description;
  final String imagePath;
  final bool? twoSectionTitle;

  OnboardingModel({
    this.title,
    this.firstSectionTitle,
    this.secondSectionTitle,
    required this.description,
    required this.imagePath,
    this.twoSectionTitle = false,
  });
}
