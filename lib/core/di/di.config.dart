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

import '../../data/api/auth_api/auth_api_manager.dart' as _i515;
import '../../data/api/cart_api/cart_api_manager.dart' as _i1016;
import '../../data/api/home_api/home_api_manager.dart' as _i48;
import '../../data/api/Order_api/order_api_manager.dart' as _i301;
import '../../data/data_sources/remote_data_source/auth/auth_remote_data_source.dart'
    as _i1056;
import '../../data/data_sources/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i96;
import '../../data/data_sources/remote_data_source/cart/cart_remote_data_source.dart'
    as _i469;
import '../../data/data_sources/remote_data_source/cart/cart_remote_data_source_impl.dart'
    as _i259;
import '../../data/data_sources/remote_data_source/home/category/category_remote_data_source.dart'
    as _i870;
import '../../data/data_sources/remote_data_source/home/category/category_remote_data_source_impl.dart'
    as _i119;
import '../../data/data_sources/remote_data_source/home/home/home_remote_data_source.dart'
    as _i795;
import '../../data/data_sources/remote_data_source/home/home/home_remote_data_source_impl.dart'
    as _i204;
import '../../data/data_sources/remote_data_source/home/occasions/occasions_remote_data_sorce_impl.dart'
    as _i650;
import '../../data/data_sources/remote_data_source/home/occasions/occasions_remote_data_sourcse.dart'
    as _i823;
import '../../data/data_sources/remote_data_source/home/profile/profile_remote_data_source.dart'
    as _i418;
import '../../data/data_sources/remote_data_source/home/profile/profile_remote_data_source_impl.dart'
    as _i1017;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/cart/cart_repository_impl.dart' as _i756;
import '../../data/repository/home/category_repo_impl.dart' as _i43;
import '../../data/repository/home/home_repository_impl.dart' as _i605;
import '../../data/repository/home/occasions_repository_impl.dart' as _i505;
import '../../data/repository/home/profile_repository_impl.dart' as _i737;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/cart/cart_repository.dart' as _i1048;
import '../../domain/repository/home/category_repository.dart' as _i599;
import '../../domain/repository/home/home_repository.dart' as _i839;
import '../../domain/repository/home/occasions_repository.dart' as _i256;
import '../../domain/repository/home/profile_repository.dart' as _i539;
import '../../domain/use_case/auth/change_password_use_case.dart' as _i495;
import '../../domain/use_case/auth/forgot_password_use_case.dart' as _i120;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/logout_use_case.dart' as _i755;
import '../../domain/use_case/auth/reset_password_use_case.dart' as _i603;
import '../../domain/use_case/auth/sign_up_use_case.dart' as _i322;
import '../../domain/use_case/auth/verify_reset_code_use_case.dart' as _i759;
import '../../domain/use_case/cart/add_product_to_cart_use_case.dart' as _i700;
import '../../domain/use_case/cart/clear_cart_use_case.dart' as _i217;
import '../../domain/use_case/cart/get_cart_products_use_case.dart' as _i18;
import '../../domain/use_case/cart/remove_product_from_cart_use_case.dart'
    as _i960;
import '../../domain/use_case/cart/update_cart_product_quantity_use_case.dart'
    as _i742;
import '../../domain/use_case/home/categories/categories_product_usecase.dart'
    as _i283;
import '../../domain/use_case/home/categories/categories_use_case.dart'
    as _i787;
import '../../domain/use_case/home/get_best_seller_products_use_case.dart'
    as _i305;
import '../../domain/use_case/home/get_home_data_use_case.dart' as _i76;
import '../../domain/use_case/home/get_product_details_use_case.dart' as _i299;
import '../../domain/use_case/home/occastions/get_occasion_products_use_case.dart'
    as _i321;
import '../../domain/use_case/home/occastions/occastions_use_case.dart'
    as _i239;
import '../../domain/use_case/home/profile/edite_profile_use_case.dart'
    as _i729;
import '../../domain/use_case/home/profile/get_logged_user_info_use_case.dart'
    as _i334;
import '../../domain/use_case/home/profile/upload_photo_use_case.dart' as _i200;
import '../../presentation/addresses/view_model/addresses_view_model.dart'
    as _i598;
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i351;
import '../../presentation/auth/login/view_model/login_cubit.dart' as _i97;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/best_seller/view_model/best_seller_view_model.dart'
    as _i298;
import '../../presentation/home_layout/product_details/view_model/product_details_cubit.dart'
    as _i134;
import '../../presentation/home_layout/screens/cart/view_model/cart_view_model.dart'
    as _i10;
import '../../presentation/home_layout/screens/categories/view_model/categories_view_model.dart'
    as _i423;
import '../../presentation/home_layout/screens/home/view_model/home_view_model.dart'
    as _i58;
import '../../presentation/home_layout/screens/occasions/view_model/ocusin_cubit.dart'
    as _i498;
import '../../presentation/home_layout/screens/profile/change_password/view_model/change_password_view_model.dart'
    as _i671;
import '../../presentation/home_layout/screens/profile/profile/view_model/profile_cubit.dart'
    as _i275;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;
import '../utils/functions/providers/app_provider.dart' as _i240;

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
    gh.factory<_i763.DioFactory>(() => _i763.DioFactory());
    gh.factory<_i598.AddressesCubit>(() => _i598.AddressesCubit());
    gh.singleton<_i240.AppProvider>(() => _i240.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i515.AuthApiManager>(
        () => _i515.AuthApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i1016.CartApiManager>(
        () => _i1016.CartApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.HomeApiManger>(
        () => _i48.HomeApiManger(gh<_i361.Dio>()));
    gh.lazySingleton<_i301.OrderApiManger>(
        () => _i301.OrderApiManger(gh<_i361.Dio>()));
    gh.factory<_i795.HomeRemoteDataSource>(
        () => _i204.HomeRemoteDataSourceImpl(gh<_i48.HomeApiManger>()));
    gh.factory<_i823.OccassionsRemoteDataSource>(() =>
        _i650.OccastionsRemoteDataSorceImpl(
            apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i256.OccasionsRepository>(() =>
        _i505.OccasionsRepositoryImpl(gh<_i823.OccassionsRemoteDataSource>()));
    gh.factory<_i418.ProfileRemoteDataSource>(() =>
        _i1017.ProfileRemoteDataSourceImpl(
            apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i870.CategoryRemoteDataSource>(() =>
        _i119.CategoryRemoteDataSourceImpl(
            apiManger: gh<_i48.HomeApiManger>()));
    gh.factory<_i1056.AuthRemoteDataSource>(() =>
        _i96.AuthRemoteDataSourceImpl(apiManger: gh<_i515.AuthApiManager>()));
    gh.factory<_i321.GetOccasionProductUseCase>(
        () => _i321.GetOccasionProductUseCase(gh<_i256.OccasionsRepository>()));
    gh.factory<_i239.OccasionsUseCase>(
        () => _i239.OccasionsUseCase(gh<_i256.OccasionsRepository>()));
    gh.factory<_i469.CartRemoteDataSource>(
        () => _i259.CartRemoteDataSourceImpl(gh<_i1016.CartApiManager>()));
    gh.factory<_i599.CategoryRepository>(() => _i43.CategoryRepositoryImpl(
        categoryRemoteDataSource: gh<_i870.CategoryRemoteDataSource>()));
    gh.factory<_i839.HomeRepository>(() => _i605.HomeRepositoryImpl(
        onlineDataSource: gh<_i795.HomeRemoteDataSource>()));
    gh.factory<_i283.CategoriesProductUseCase>(
        () => _i283.CategoriesProductUseCase(gh<_i599.CategoryRepository>()));
    gh.factory<_i787.GetAllCategoriesUseCase>(
        () => _i787.GetAllCategoriesUseCase(gh<_i599.CategoryRepository>()));
    gh.factory<_i539.ProfileRepository>(() => _i737.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i418.ProfileRemoteDataSource>()));
    gh.factory<_i729.EditeProfileUseCase>(() => _i729.EditeProfileUseCase(
        profileRepository: gh<_i539.ProfileRepository>()));
    gh.factory<_i334.GetLoggedUserInfoUseCase>(() =>
        _i334.GetLoggedUserInfoUseCase(
            profileRepository: gh<_i539.ProfileRepository>()));
    gh.factory<_i200.UploadPhotoUseCase>(() => _i200.UploadPhotoUseCase(
        profileRepository: gh<_i539.ProfileRepository>()));
    gh.factory<_i912.AuthRepository>(
        () => _i392.AuthRepositoryImpl(gh<_i1056.AuthRemoteDataSource>()));
    gh.factory<_i120.ForgotPasswordUseCase>(() =>
        _i120.ForgotPasswordUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i759.VerifyResetCodeUseCase>(() =>
        _i759.VerifyResetCodeUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i755.LogoutUseCase>(
        () => _i755.LogoutUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i498.OccasionCubit>(() => _i498.OccasionCubit(
          gh<_i239.OccasionsUseCase>(),
          gh<_i321.GetOccasionProductUseCase>(),
        ));
    gh.factory<_i76.GetHomeDataUseCase>(
        () => _i76.GetHomeDataUseCase(gh<_i839.HomeRepository>()));
    gh.factory<_i1048.CartRepository>(
        () => _i756.CartRepositoryImpl(gh<_i469.CartRemoteDataSource>()));
    gh.factory<_i322.SignUpUseCase>(
        () => _i322.SignUpUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i305.GetBestSellerProductsUseCase>(() =>
        _i305.GetBestSellerProductsUseCase(
            repository: gh<_i839.HomeRepository>()));
    gh.factory<_i299.GetProductDetailsUseCase>(() =>
        _i299.GetProductDetailsUseCase(repository: gh<_i839.HomeRepository>()));
    gh.factory<_i423.CategoriesViewModel>(() => _i423.CategoriesViewModel(
          gh<_i787.GetAllCategoriesUseCase>(),
          gh<_i283.CategoriesProductUseCase>(),
        ));
    gh.factory<_i671.ChangePasswordViewModel>(
        () => _i671.ChangePasswordViewModel(gh<_i912.AuthRepository>()));
    gh.factory<_i495.ChangePasswordUseCase>(
        () => _i495.ChangePasswordUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i58.HomeViewModel>(
        () => _i58.HomeViewModel(gh<_i76.GetHomeDataUseCase>()));
    gh.factory<_i603.ResetPasswordUseCase>(() =>
        _i603.ResetPasswordUseCase(authRepository: gh<_i912.AuthRepository>()));
    gh.factory<_i275.ProfileCubit>(() => _i275.ProfileCubit(
          gh<_i334.GetLoggedUserInfoUseCase>(),
          gh<_i729.EditeProfileUseCase>(),
          gh<_i755.LogoutUseCase>(),
          gh<_i200.UploadPhotoUseCase>(),
        ));
    gh.factory<_i700.AddProductToCartUseCase>(
        () => _i700.AddProductToCartUseCase(gh<_i1048.CartRepository>()));
    gh.factory<_i217.ClearCartUseCase>(
        () => _i217.ClearCartUseCase(gh<_i1048.CartRepository>()));
    gh.factory<_i960.RemoveProductFromCartUseCase>(
        () => _i960.RemoveProductFromCartUseCase(gh<_i1048.CartRepository>()));
    gh.factory<_i408.LogInUseCase>(
        () => _i408.LogInUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i134.ProductDetailsCubit>(
        () => _i134.ProductDetailsCubit(gh<_i299.GetProductDetailsUseCase>()));
    gh.factory<_i351.ForgetPasswordCubit>(() => _i351.ForgetPasswordCubit(
          gh<_i120.ForgotPasswordUseCase>(),
          gh<_i759.VerifyResetCodeUseCase>(),
          gh<_i603.ResetPasswordUseCase>(),
        ));
    gh.factory<_i18.GetCartProductsUseCase>(
        () => _i18.GetCartProductsUseCase(gh<_i1048.CartRepository>()));
    gh.factory<_i742.UpdateCartProductQuantityUseCase>(() =>
        _i742.UpdateCartProductQuantityUseCase(gh<_i1048.CartRepository>()));
    gh.factory<_i140.SignUpCubit>(
        () => _i140.SignUpCubit(gh<_i322.SignUpUseCase>()));
    gh.factory<_i298.BestSellerViewModel>(() =>
        _i298.BestSellerViewModel(gh<_i305.GetBestSellerProductsUseCase>()));
    gh.factory<_i10.CartViewModel>(() => _i10.CartViewModel(
          gh<_i18.GetCartProductsUseCase>(),
          gh<_i700.AddProductToCartUseCase>(),
          gh<_i742.UpdateCartProductQuantityUseCase>(),
          gh<_i960.RemoveProductFromCartUseCase>(),
          gh<_i217.ClearCartUseCase>(),
        ));
    gh.factory<_i97.LoginViewModel>(
        () => _i97.LoginViewModel(gh<_i408.LogInUseCase>()));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
