import 'package:app_api/app_api.dart';
import 'package:app_repository/app_repository.dart' show AppRepository;
import 'package:sportz_interactive_assessment/app/app.dart';
import 'package:sportz_interactive_assessment/bootstrap.dart';

void main() {
  bootstrap(() {
    final apiClient = AppApiClient();

    final repository = AppRepository(apiClient: apiClient);

    return App(
      repository: repository,
    );
  });
}
