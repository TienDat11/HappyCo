import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/domain/domain_locator.config.dart';

final domainLocator = GetIt.instance;

/// Setup domain layer dependencies using @Injectable codegen
///
/// Registers:
/// - All @injectable classes in domain layer (use cases, repositories interfaces)
@InjectableInit(initializerName: 'initDomainLocator')
void setupDomainLocator() {
  // Auto-register all @injectable classes in domain layer
  domainLocator.initDomainLocator();
}
