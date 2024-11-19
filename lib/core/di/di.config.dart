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
import 'package:flowery/core/providers/app_provider.dart' as _i41;
import 'package:flowery/data/api/auth_api/api_manger.dart' as _i242;
import 'package:flowery/data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i223;
import 'package:flowery/data/data_source/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i376;
import 'package:flowery/data/repository/auth/auth_repository_impl.dart'
    as _i786;
import 'package:flowery/domain/repository/auth/auth_repository.dart' as _i1008;
import 'package:flowery/domain/use_case/auth/forgot_password_use_case.dart'
    as _i355;
import 'package:flowery/domain/use_case/auth/verify_reset_code_use_case.dart'
    as _i23;
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i9;

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/auth_api/api_manger.dart' as _i1055;
import '../../data/api/home_api/home_api_manager.dart' as _i48;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i993;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i568;
import '../../data/data_source/remote_data_source/home/home_remote_data_source.dart'
    as _i367;
import '../../data/data_source/remote_data_source/home/home_remote_data_source_impl.dart'
    as _i440;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/home/home_repository_impl.dart' as _i605;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/home/home_repository.dart' as _i839;
import '../../domain/use_case/auth/forgot_password_use_case.dart' as _i120;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/sign_up/sign_up_use_case.dart' as _i34;
import '../../domain/use_case/auth/verify_reset_code_use_case.dart' as _i759;
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i351;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/auth/view_model/login/login_cubit.dart' as _i1004;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;

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
    gh.singleton<_i41.AppProvider>(() => _i41.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i1055.ApiManger>(() => _i1055.ApiManger(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.HomeApiManger>(
        () => _i48.HomeApiManger(gh<_i361.Dio>()));
    gh.factory<_i367.HomeRemoteDataSource>(() =>
        _i440.HomeRemoteDataSourceImpl(apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i839.HomeRepository>(() => _i605.HomeRepositoryImpl(
        onlineDataSource: gh<_i367.HomeRemoteDataSource>()));
    gh.factory<_i993.AuthRemoteDataSource>(() =>
        _i568.AuthRemoteDataSourceImpl(apiManger: gh<_i1055.ApiManger>()));
    gh.factory<_i912.AuthRepository>(() =>
        _i392.AuthRepositoryImpl(dataSource: gh<_i993.AuthRemoteDataSource>()));
    gh.factory<_i408.LogInUseCase>(
        () => _i408.LogInUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i120.ForgotPasswordUseCase>(() =>
        _i120.ForgotPasswordUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i759.VerifyResetCodeUseCase>(() =>
        _i759.VerifyResetCodeUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i34.SignUpUseCase>(
        () => _i34.SignUpUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i1004.LoginViewModel>(
        () => _i1004.LoginViewModel(gh<_i408.LogInUseCase>()));
    gh.factory<_i351.ForgetPasswordCubit>(() => _i351.ForgetPasswordCubit(
          gh<_i120.ForgotPasswordUseCase>(),
          gh<_i759.VerifyResetCodeUseCase>(),
        ));
    gh.factory<_i140.SignUpCubit>(
        () => _i140.SignUpCubit(gh<_i34.SignUpUseCase>()));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
