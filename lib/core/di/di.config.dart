// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/auth_api/api_manger.dart' as _i1055;
import '../../data/api/best_seller_api.dart' as _i513;
import '../../data/api/home_api/home_api_manager.dart' as _i48;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i993;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i568;
import '../../data/data_source/remote_data_source/best_seller_remote_data_source.dart'
    as _i465;
import '../../data/data_source/remote_data_source/home/home_remote_data_source.dart'
    as _i367;
import '../../data/data_source/remote_data_source/home/home_remote_data_source_impl.dart'
    as _i440;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/home/home_repository_impl.dart' as _i605;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/best_seller_repository.dart' as _i40;
import '../../domain/repository/best_seller_repository_impl.dart' as _i372;
import '../../domain/repository/home/home_repository.dart' as _i839;
import '../../domain/use_case/%20get_best_sellers_use_case.dart' as _i277;
import '../../domain/use_case/auth/forgot_password_use_case.dart' as _i120;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/sign_up/sign_up_use_case.dart' as _i34;
import '../../domain/use_case/auth/verify_reset_code_use_case.dart' as _i759;
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i351;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/auth/view_model/login/login_cubit.dart' as _i1004;
import '../../presentation/best_seller/view_model/%20best_seller_view_model.dart'
    as _i265;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;
import '../providers/app_provider.dart' as _i1023;
import 'di.dart' as _i913;

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
    final apiModule = _$ApiModule();
    gh.factory<_i763.DioFactory>(() => _i763.DioFactory());
    gh.singleton<_i1023.AppProvider>(() => _i1023.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i513.BestSellerApi>(
        () => apiModule.getBestSellerApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i1055.ApiManger>(() => _i1055.ApiManger(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.HomeApiManger>(
        () => _i48.HomeApiManger(gh<_i361.Dio>()));
    gh.factory<_i277.GetBestSellersUseCase>(
        () => _i277.GetBestSellersUseCase(gh<_i40.BestSellerRepository>()));
    gh.factory<_i465.BestSellerRemoteDataSource>(
        () => _i465.BestSellerRemoteDataSource(gh<_i513.BestSellerApi>()));
    gh.factory<_i367.HomeRemoteDataSource>(() =>
        _i440.HomeRemoteDataSourceImpl(apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i839.HomeRepository>(() => _i605.HomeRepositoryImpl(
        onlineDataSource: gh<_i367.HomeRemoteDataSource>()));
    gh.factory<_i372.BestSellerViewModel>(() =>
        _i372.BestSellerViewModel(gh<_i465.BestSellerRemoteDataSource>()));
    gh.factory<_i265.BestSellerViewModel>(() =>
        _i265.BestSellerViewModel(gh<_i465.BestSellerRemoteDataSource>()));
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

class _$ApiModule extends _i913.ApiModule {}
