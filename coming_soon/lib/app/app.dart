import 'package:coming_soon/services/http_network_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../UI/coming_soon/coming_soon_view.dart';
import '../services/i_network_service.dart';
import '../services/network_Service.dart';

@StackedApp(routes: [
  MaterialRoute(page: ComingSoonView, initial: true),
], dependencies: [
  LazySingleton(classType: DialogService),
  LazySingleton(classType: NetworkService, asType: INetworkService),
], logger: StackedLogger())
class AppSetup {}
