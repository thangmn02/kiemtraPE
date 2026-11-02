// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingRepository)
final settingRepositoryProvider = SettingRepositoryProvider._();

final class SettingRepositoryProvider
    extends
        $FunctionalProvider<
          SettingRepository,
          SettingRepository,
          SettingRepository
        >
    with $Provider<SettingRepository> {
  SettingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingRepository create(Ref ref) {
    return settingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingRepository>(value),
    );
  }
}

String _$settingRepositoryHash() => r'3565eaed8ed88d377f02d22d58cbaa8981239b64';

@ProviderFor(SettingViewModel)
final settingViewModelProvider = SettingViewModelProvider._();

final class SettingViewModelProvider
    extends $AsyncNotifierProvider<SettingViewModel, String> {
  SettingViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingViewModelHash();

  @$internal
  @override
  SettingViewModel create() => SettingViewModel();
}

String _$settingViewModelHash() => r'6b406991426d158c5e37db3c292d26454e665a65';

abstract class _$SettingViewModel extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
