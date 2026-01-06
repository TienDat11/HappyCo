import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/features/feature_locator.config.dart';

final featureLocator = GetIt.instance;

/// Setup feature layer dependencies using @Injectable codegen
///
/// Registers:
/// - All @injectable classes in feature layer (BLoCs, pages, widgets)
@InjectableInit(initializerName: 'initFeatureLocator')
void setupFeatureLocator() {
  // Auto-register all @injectable classes in feature layer
  featureLocator.initFeatureLocator();
}
