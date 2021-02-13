

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/model/payment_intent_response.dart';
import 'package:stripe_app/model/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {

  //Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl    = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_51IKD4sJ0GPbdxhhR6TegWFho799JXnETXTecXDAXE71ZF8F67O4RgCYGyb53yLrpyOPUNZgDI5nXaW4kJK8UtcWg00PGGrlEHw';
  String _apiKey           = 'pk_test_51IKD4sJ0GPbdxhhRUZa4hqjKKttpH9TblaXINS3si0IUICFZYG9oQjdp3DejLjkFaXPX5YdIXoMo5MOwpY7CabXz000X9i7L7g';

  final headerOptions = new Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      'Authorization': 'Bearer ${StripeService._secretKey}'
    }
  );


  void init(){
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      )
    );
  }
  
  Future<StripeCustomResponse> pagarConTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {

     try {

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );

      final resp = await this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;
      
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {

    try {

      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      final resp = await this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;
      
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future pagarApplePayGooglePay({
    @required String amount,
    @required String currency,
  }) async {

  }

  Future<PaymentIntentResponse> _crearPaymentIntent({
    @required String amount,
    @required String currency,
  }) async {
    
    try {

      final dio = new Dio();
      final data = {
        'amount': amount,
        'currency': currency
      };

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions
      );

      return PaymentIntentResponse.fromJson(resp.data);

    } catch (e) {
      
      print('Error en el intento: ${e.toString()}');
      return PaymentIntentResponse(
        status: '400'
      );
    }
  }

  Future<StripeCustomResponse> _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {

    try {
      
      final paymentIntent = await this._crearPaymentIntent(
        amount: amount, 
        currency: currency
      );

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id
        )
      );

      if(paymentResult.status == 'succeeded'){
        return StripeCustomResponse(ok: true);
      }else{
        return StripeCustomResponse(ok: false, msg: 'Fallo ${paymentResult.status}');
      }
      
    } catch (e) {
      
      print(e.toString());
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }
  
}