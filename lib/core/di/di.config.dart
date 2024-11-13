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
import 'package:flowery/data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i223;
import 'package:flowery/data/data_source/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i376;
import 'package:flowery/data/repository/auth/auth_repository_impl.dart'
    as _i786;
import 'package:flowery/domain/repository/auth/auth_repository.dart' as _i1008;
import 'package:flowery/domain/use_case/auth/forgot_password_use_case.dart'
    as _i355;
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i9;
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
    gh.factory<_i223.AuthRemoteDataSource>(() =>
        _i376.AuthRemoteDataSourceImpl(apiManger: gh<_i1049.ApiManger>()));
    gh.factory<_i1008.AuthRepository>(() =>
        _i786.AuthRepositoryImpl(dataSource: gh<_i223.AuthRemoteDataSource>()));
    gh.factory<_i355.ForgotPasswordUseCase>(() =>
        _i355.ForgotPasswordUseCase(repository: gh<_i1008.AuthRepository>()));
    gh.factory<_i9.ForgetPasswordCubit>(
        () => _i9.ForgetPasswordCubit(gh<_i355.ForgotPasswordUseCase>()));
    return this;
  }
}

class _$DioModule extends _i827.DioModule {}
