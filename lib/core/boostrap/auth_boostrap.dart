import '../../auth/data/auth_repository.dart';
import '../config/app_config.dart';

class AuthBootstrapper {
  final AuthRepository repository;

  AuthBootstrapper(this.repository);

  Future<void> init() async {
    await repository.login(
      email: AppConfig.devEmail,
      password: AppConfig.devPassword,
    );
  }
}
