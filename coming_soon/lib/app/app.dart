import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../UI/coming_soon/coming_soon_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: ComingSoonView, initial: true),
], dependencies: [
  LazySingleton(classType: DialogService),
], logger: StackedLogger())
class AppSetup {}
