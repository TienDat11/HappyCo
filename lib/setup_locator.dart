import 'package:happyco/data/data_locator.dart';
import 'package:happyco/domain/domain_locator.dart';
import 'package:happyco/features/feature_locator.dart';

/// Setup all dependency injection locators
/// Order matters: Data → Domain → Feature
Future<void> setupLocator() async {
  // Phase 1: Data layer (lowest level)
  await setupDataLocator();

  // Phase 2: Domain layer (business logic)
  setupDomainLocator();

  // Phase 3: Feature layer (UI - BLoCs)
  setupFeatureLocator();
}
