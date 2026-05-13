abstract class UseCase<T> {
  Future<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  Future<T> call(Params params);
}
