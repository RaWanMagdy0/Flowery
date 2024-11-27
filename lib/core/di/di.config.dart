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

import '../../data/api/best_seller_api.dart' as _i513;
import '../../data/api/home_api/home_api_manager.dart' as _i48;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i993;
import '../../data/data_source/remote_data_source/best_seller_remote_data_source.dart'
    as _i465;
import '../../data/data_source/remote_data_source/home/category/category_remote_data_source.dart'
    as _i365;
import '../../data/data_source/remote_data_source/home/category/category_remote_data_source_impl.dart'
    as _i373;
import '../../data/data_source/remote_data_source/home/home_remote_data_source.dart'
    as _i367;
import '../../data/data_source/remote_data_source/home/home_remote_data_source_impl.dart'
    as _i440;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/home/category_repo_impl.dart' as _i43;
import '../../data/repository/home/home_repository_impl.dart' as _i605;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/best_seller_repository.dart' as _i40;
import '../../domain/repository/best_seller_repository_impl.dart' as _i372;
import '../../domain/repository/category_repo.dart' as _i245;
import '../../domain/repository/home/home_repository.dart' as _i839;
import '../../domain/use_case/%20get_best_sellers_use_case.dart' as _i277;
import '../../domain/use_case/auth/forgot_password_use_case.dart' as _i120;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/sign_up/sign_up_use_case.dart' as _i34;
import '../../domain/use_case/auth/verify_reset_code_use_case.dart' as _i759;
import '../../domain/use_case/home/categories/categories_product_usecase.dart'
    as _i283;
import '../../domain/use_case/home/categories/categories_use_case.dart'
    as _i787;
import '../../domain/use_case/home/get_home_data_use_case.dart' as _i76;
import '../../domain/use_case/home_layout/product_details_use_case.dart'
    as _i728;
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i351;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/auth/view_model/login/login_cubit.dart' as _i1004;
import '../../presentation/best_seller/view_model/%20best_seller_view_model.dart'
    as _i265;
import '../../presentation/home_layout/product_details/view_model/product_details_cubit.dart'
    as _i134;
import '../../presentation/home_layout/screens/categories/view_model/categories_view_model.dart'
    as _i423;
import '../../presentation/home_layout/screens/home/view_model/home_view_model.dart'
    as _i58;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;
import '../utils/functions/providers/app_provider.dart' as _i240;
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
    gh.singleton<_i240.AppProvider>(() => _i240.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i912.AuthRepository>(() =>
        _i392.AuthRepositoryImpl(dataSource: gh<_i993.AuthRemoteDataSource>()));
    gh.lazySingleton<_i513.BestSellerApi>(
        () => apiModule.getBestSellerApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.HomeApiManger>(
        () => _i48.HomeApiManger(gh<_i361.Dio>()));
    gh.factory<_i277.GetBestSellersUseCase>(
        () => _i277.GetBestSellersUseCase(gh<_i40.BestSellerRepository>()));
    gh.factory<_i465.BestSellerRemoteDataSource>(
        () => _i465.BestSellerRemoteDataSource(gh<_i513.BestSellerApi>()));
    gh.factory<_i367.HomeRemoteDataSource>(() =>
        _i440.HomeRemoteDataSourceImpl(apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i408.LogInUseCase>(
        () => _i408.LogInUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i839.HomeRepository>(() => _i605.HomeRepositoryImpl(
        onlineDataSource: gh<_i367.HomeRemoteDataSource>()));
    gh.factory<_i120.ForgotPasswordUseCase>(() =>
        _i120.ForgotPasswordUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i759.VerifyResetCodeUseCase>(() =>
        _i759.VerifyResetCodeUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i365.CategoryRemoteDataSource>(() =>
        _i373.CategoryRemoteDataSourceImpl(
            apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i76.GetHomeDataUseCase>(
        () => _i76.GetHomeDataUseCase(gh<_i839.HomeRepository>()));
    gh.factory<_i34.SignUpUseCase>(
        () => _i34.SignUpUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i728.ProductDetailsUseCase>(() =>
        _i728.ProductDetailsUseCase(repository: gh<_i839.HomeRepository>()));
    gh.factory<_i372.BestSellerViewModel>(() =>
        _i372.BestSellerViewModel(gh<_i465.BestSellerRemoteDataSource>()));
    gh.factory<_i265.BestSellerViewModel>(() =>
        _i265.BestSellerViewModel(gh<_i465.BestSellerRemoteDataSource>()));
    gh.factory<_i1004.LoginViewModel>(
        () => _i1004.LoginViewModel(gh<_i408.LogInUseCase>()));
    gh.factory<_i245.CategoryRepository>(() => _i43.CategoryRepositoryImpl(
        categoryRemoteDataSource: gh<_i365.CategoryRemoteDataSource>()));
    gh.factory<_i351.ForgetPasswordCubit>(() => _i351.ForgetPasswordCubit(
          gh<_i120.ForgotPasswordUseCase>(),
          gh<_i759.VerifyResetCodeUseCase>(),
        ));
    gh.factory<_i58.HomeViewModel>(
        () => _i58.HomeViewModel(gh<_i76.GetHomeDataUseCase>()));
    gh.factory<_i140.SignUpCubit>(
        () => _i140.SignUpCubit(gh<_i34.SignUpUseCase>()));
    gh.factory<_i134.ProductDetailsCubit>(
        () => _i134.ProductDetailsCubit(gh<_i728.ProductDetailsUseCase>()));
    gh.factory<_i283.CategoriesProductUseCase>(
        () => _i283.CategoriesProductUseCase(gh<_i245.CategoryRepository>()));
    gh.factory<_i787.CategoriesUseCase>(
        () => _i787.CategoriesUseCase(gh<_i245.CategoryRepository>()));
    gh.factory<_i423.CategoriesViewModel>(() => _i423.CategoriesViewModel(
          gh<_i787.CategoriesUseCase>(),
          gh<_i283.CategoriesProductUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}

class _$ApiModule extends _i913.ApiModule {}
