// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flowery/core/api/dio/dio_factory.dart' as _i1013;
import 'package:flowery/core/api/dio/dio_module.dart' as _i827;
import 'package:flowery/data/api/api_manger.dart' as _i1049;
import 'package:flowery/data/data_source/remote_data_source/remote_data_source.dart'
    as _i486;
import 'package:flowery/data/data_source/remote_data_source/remote_data_source_impl.dart'
    as _i857;
import 'package:flowery/data/repo/auth/auth_repo_impl.dart' as _i570;
import 'package:flowery/domain/repo/auth/auth_repo.dart' as _i634;
import 'package:flowery/domain/use_case/reset_password_usecase.dart' as _i167;
import 'package:flowery/presentation/auth/view_model/reset_password/reset_password_view_model.dart'
    as _i1067;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i1013.DioFactory>(() => _i1013.DioFactory());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i1049.ApiManger>(() => _i1049.ApiManger(gh<_i361.Dio>()));
    gh.factory<_i486.AuthRemoteDataSource>(() =>
        _i857.AuthRemoteDataSourceImpl(apiManger: gh<_i1049.ApiManger>()));
    gh.factory<_i634.AuthRepo>(
        () => _i570.AuthRepoImpl(dataSource: gh<_i486.AuthRemoteDataSource>()));
    gh.factory<_i167.ResetPasswordUseCase>(
        () => _i167.ResetPasswordUseCase(authRepo: gh<_i634.AuthRepo>()));
    gh.factory<_i1067.ResetPasswordViewModel>(
        () => _i1067.ResetPasswordViewModel(gh<_i167.ResetPasswordUseCase>()));
    return this;
  }
}

class _$DioModule extends _i827.DioModule {}
