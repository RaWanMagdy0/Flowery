import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/cart/responses/cart_response_model.dart';
import 'package:flowery/domain/entities/cart/cart_response_entity.dart';
import 'package:flowery/domain/use_case/cart/add_product_to_cart_use_case.dart';
import 'package:flowery/domain/use_case/cart/clear_cart_use_case.dart';
import 'package:flowery/domain/use_case/cart/get_cart_products_use_case.dart';
import 'package:flowery/domain/use_case/cart/remove_product_from_cart_use_case.dart';
import 'package:flowery/domain/use_case/cart/update_cart_product_quantity_use_case.dart';
import 'package:flowery/presentation/home_layout/screens/cart/view_model/cart_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'cart_view_model_test.mocks.dart';

@GenerateMocks([
  GetCartProductsUseCase,
  AddProductToCartUseCase,
  UpdateCartProductQuantityUseCase,
  RemoveProductFromCartUseCase,
  ClearCartUseCase,
])
void main() {
  late MockGetCartProductsUseCase mockGetCartProductsUseCase;
  late MockAddProductToCartUseCase mockAddProductToCartUseCase;
  late MockUpdateCartProductQuantityUseCase
      mockUpdateCartProductQuantityUseCase;
  late MockRemoveProductFromCartUseCase mockRemoveProductFromCartUseCase;
  late MockClearCartUseCase mockClearCartUseCase;
  late CartViewModel cartViewModel;

  setUp(() {
    mockGetCartProductsUseCase = MockGetCartProductsUseCase();
    mockAddProductToCartUseCase = MockAddProductToCartUseCase();
    mockUpdateCartProductQuantityUseCase =
        MockUpdateCartProductQuantityUseCase();
    mockRemoveProductFromCartUseCase = MockRemoveProductFromCartUseCase();
    mockClearCartUseCase = MockClearCartUseCase();

    cartViewModel = CartViewModel(
      mockGetCartProductsUseCase,
      mockAddProductToCartUseCase,
      mockUpdateCartProductQuantityUseCase,
      mockRemoveProductFromCartUseCase,
      mockClearCartUseCase,
    );
  });

  group('CartViewModel -- Get Cart Products', () {
    // no cart Exception
    final noCartException = Exception('404 - No Cart Found');
    final mockednoCartExceptionResult =
        Fail<CartResponse?>(exception: noCartException);
    provideDummy<Result<CartResponse?>>(mockednoCartExceptionResult);

    // Empty cart data
    final emptyData = CartResponse();
    final mockedEmptyDataResult = Success<CartResponse?>(data: emptyData);
    provideDummy<Result<CartResponse?>>(mockedEmptyDataResult);

    // Cart data
    final Map<String, dynamic> jsonData = jsonDecode(
      fixtureReader(
        folderName: 'cart',
        fileName: 'logged_user_cart_products.json',
      ),
    );
    final successData = CartResponseModel.fromJson(jsonData);
    final successEntityData = successData.toEntity();
    final mockedSuccessDataResult =
        Success<CartResponse?>(data: successEntityData);
    provideDummy<Result<CartResponse?>>(mockedSuccessDataResult);

    // Exception data
    final exception = Exception('Error getting cart products');
    final mockedFailDataResult = Fail<CartResponse?>(exception: exception);
    provideDummy<Result<CartResponse?>>(mockedFailDataResult);

    blocTest<CartViewModel, CartState>(
      'should get no cart found',

      // arrange
      build: () {
        when(mockGetCartProductsUseCase.call())
            .thenAnswer((_) async => mockednoCartExceptionResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.getCartProducts(),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartEmpty>(),
        ];
      },

      verify: (_) {
        verify(mockGetCartProductsUseCase.call()).called(1);
      },
    );

    blocTest<CartViewModel, CartState>(
      'should get empty cart',

      // arrange
      build: () {
        when(mockGetCartProductsUseCase.call())
            .thenAnswer((_) async => mockedEmptyDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.getCartProducts(),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartEmpty>(),
        ];
      },

      verify: (_) {
        verify(mockGetCartProductsUseCase.call()).called(1);
      },
    );

    blocTest<CartViewModel, CartState>(
      'should get cart products',

      // arrange
      build: () {
        when(mockGetCartProductsUseCase.call())
            .thenAnswer((_) async => mockedSuccessDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.getCartProducts(),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartLoaded>(),
        ];
      },

      verify: (_) {
        verify(mockGetCartProductsUseCase.call()).called(1);
      },
    );

    blocTest<CartViewModel, CartState>(
      'should get Error getting cart products',

      // arrange
      build: () {
        when(mockGetCartProductsUseCase.call())
            .thenAnswer((_) async => mockedFailDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.getCartProducts(),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartError>(),
        ];
      },

      verify: (_) {
        verify(mockGetCartProductsUseCase.call()).called(1);
      },
    );
  });

  group('CartViewModel -- Add Product to Cart', () {
    // Success data
    final String productId = '1';
    final mockedSuccessResult = Success<bool?>(data: true);
    provideDummy<Result<bool?>>(mockedSuccessResult);

    // Exception data
    final exception = Exception('Error getting cart products');
    final mockedFailDataResult = Fail<bool?>(exception: exception);
    provideDummy<Result<bool?>>(mockedFailDataResult);

    blocTest<CartViewModel, CartState>(
      'should get success adding product to cart',

      // arrange
      build: () {
        when(mockAddProductToCartUseCase.call(productId))
            .thenAnswer((_) async => mockedSuccessResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.addProductToCart(productId),

      // assert
      expect: () {
        return [
          isA<AddToCartLoading>(),
          isA<AddToCartSuccess>(),
        ];
      },

      verify: (_) {
        verify(mockAddProductToCartUseCase.call(productId)).called(1);
      },
    );

    blocTest<CartViewModel, CartState>(
      'should get Error getting cart products',

      // arrange
      build: () {
        when(mockAddProductToCartUseCase.call(productId))
            .thenAnswer((_) async => mockedFailDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.addProductToCart(productId),

      // assert
      expect: () {
        return [
          isA<AddToCartLoading>(),
          isA<AddToCartError>(),
        ];
      },

      verify: (_) {
        verify(mockAddProductToCartUseCase.call(productId)).called(1);
      },
    );
  });

  group('CartViewModel -- Update Cart Product Quantity', () {
    final String productId = '1';
    final int quantity = 2;

    // Cart data
    final Map<String, dynamic> jsonData = jsonDecode(
      fixtureReader(
        folderName: 'cart',
        fileName: 'logged_user_cart_products.json',
      ),
    );
    final successData = CartResponseModel.fromJson(jsonData);
    final successEntityData = successData.toEntity();
    final mockedSuccessDataResult =
        Success<CartResponse?>(data: successEntityData);
    provideDummy<Result<CartResponse?>>(mockedSuccessDataResult);

    // Exception data
    final exception = Exception('Error getting cart products');
    final mockedFailDataResult = Fail<CartResponse?>(exception: exception);
    provideDummy<Result<CartResponse?>>(mockedFailDataResult);

    blocTest<CartViewModel, CartState>(
      'should update cart product quantity',

      // arrange
      build: () {
        when(mockUpdateCartProductQuantityUseCase.call(productId, quantity))
            .thenAnswer((_) async => mockedSuccessDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.updateCartProductQuantity(productId, quantity),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartLoaded>(),
        ];
      },

      verify: (_) {
        verify(mockUpdateCartProductQuantityUseCase.call(productId, quantity))
            .called(1);
      },
    );

    blocTest<CartViewModel, CartState>(
      'should get Error getting cart products',

      // arrange
      build: () {
        when(mockGetCartProductsUseCase.call())
            .thenAnswer((_) async => mockedFailDataResult);

        return cartViewModel;
      },

      // act
      act: (cubit) => cubit.getCartProducts(),

      // assert
      expect: () {
        return [
          isA<CartLoading>(),
          isA<CartError>(),
        ];
      },

      verify: (_) {
        verify(mockGetCartProductsUseCase.call()).called(1);
      },
    );
  });
}
