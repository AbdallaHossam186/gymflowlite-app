import 'package:get/get.dart';
import 'package:gymflow_lite/modules/onboarding/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  RxInt pageIndex = 0.obs;
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      firstSectionTitle: 'Find Partners',
      secondSectionTitle: ' Fast',
      description: 'Connect with people training at the same gym and time.',
      imagePath:
          'https://images.unsplash.com/photo-1639653819226-65047601bb7e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      twoSectionTitle: true,
      stepName: 'PARTNER UP',
    ),
    OnboardingModel(
      stepName: 'SCHEDULING',
      title: 'Share Your Schedule',
      description:
          'Let others know when you’re hitting the gym and find workout buddies in seconds.',
      imagePath:
          'https://images.unsplash.com/photo-1642359085898-d9fde39507c9?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    OnboardingModel(
      stepName: 'PROGRESS',
      title: 'Track Progress',
      description:
          'Simple workout logs to keep you motivated and on track with your fitness goals.',
      imagePath:
          'https://plus.unsplash.com/premium_photo-1661380553665-f672b3af157e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];
}
