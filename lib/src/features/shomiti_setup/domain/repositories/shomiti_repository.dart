import '../entities/shomiti.dart';

abstract class ShomitiRepository {
  Stream<Shomiti?> watchActive();

  Future<Shomiti?> getActive();

  Future<void> upsert(Shomiti shomiti);
}

