// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientHash() => r'eac6f11eca718d05d94cd8e534ad88c06d4c6afd';

/// See also [client].
@ProviderFor(client)
final clientProvider = Provider<Dio>.internal(
  client,
  name: r'clientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClientRef = ProviderRef<Dio>;
String _$authClientHash() => r'27647eb8cc9ed9e69e4052355a6040578dabce37';

/// See also [authClient].
@ProviderFor(authClient)
final authClientProvider = AutoDisposeProvider<Dio>.internal(
  authClient,
  name: r'authClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthClientRef = AutoDisposeProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
