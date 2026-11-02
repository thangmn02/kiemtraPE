import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/setting_repository.dart';

part 'setting_view_model.g.dart';

@riverpod
SettingRepository settingRepository(Ref ref) {
  return SettingRepository();
}

@riverpod
class SettingViewModel extends _$SettingViewModel {
  @override
  Future<String> build() async {
    final repository = ref.watch(settingRepositoryProvider);
    return repository.getCurrency();
  }

  Future<void> changeCurrency(String currency) async {
    final repository = ref.read(settingRepositoryProvider);
    await repository.saveCurrency(currency);
    state = AsyncData(currency);
  }
}
