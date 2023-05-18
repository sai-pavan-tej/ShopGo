import 'package:flutter/material.dart';
import 'AddPage.dart';
import 'ViewPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'package:eventify/eventify.dart';
import 'model.dart';
import 'ChatBot.dart';
import 'AboutPage.dart';
import 'LastPage.dart';

//For Google Payments initialization

class Razorpay {
  // Response codes from platform
  static const _CODE_PAYMENT_SUCCESS = 0;
  static const _CODE_PAYMENT_ERROR = 1;
  static const _CODE_PAYMENT_EXTERNAL_WALLET = 2;

  // Event names
  static const EVENT_PAYMENT_SUCCESS = 'payment.success';
  static const EVENT_PAYMENT_ERROR = 'payment.error';
  static const EVENT_EXTERNAL_WALLET = 'payment.external_wallet';

  // Payment error codes
  static const NETWORK_ERROR = 0;
  static const INVALID_OPTIONS = 1;
  static const PAYMENT_CANCELLED = 2;
  static const TLS_ERROR = 3;
  static const INCOMPATIBLE_PLUGIN = 4;
  static const UNKNOWN_ERROR = 100;

  static const MethodChannel _channel = const MethodChannel('razorpay_flutter');

  // EventEmitter instance used for communication
  EventEmitter _eventEmitter;

  Razorpay() {
    _eventEmitter = new EventEmitter();
  }

  /// Opens Razorpay checkout
  void open(Map<String, dynamic> options) async {
    Map<String, dynamic> validationResult = _validateOptions(options);

    if (!validationResult['success']) {
      _handleResult({
        'type': _CODE_PAYMENT_ERROR,
        'data': {
          'code': INVALID_OPTIONS,
          'message': validationResult['message']
        }
      });
      return;
    }

    var response = await _channel.invokeMethod('open', options);
    print(
        "print the response of payment success-full-----------\n ${response}");
    _handleResult(response);
  }

  /// Handles checkout response from platform
  void _handleResult(Map<dynamic, dynamic> response) {
    String eventName;
    Map<dynamic, dynamic> data = response["data"];

    dynamic payload;

    switch (response['type']) {
      case _CODE_PAYMENT_SUCCESS:
        eventName = EVENT_PAYMENT_SUCCESS;
        payload = PaymentSuccessResponse.fromMap(data);
        break;

      case _CODE_PAYMENT_ERROR:
        eventName = EVENT_PAYMENT_ERROR;
        payload = PaymentFailureResponse.fromMap(data);
        break;

      case _CODE_PAYMENT_EXTERNAL_WALLET:
        eventName = EVENT_EXTERNAL_WALLET;
        payload = ExternalWalletResponse.fromMap(data);
        break;

      default:
        eventName = 'error';
        payload =
            PaymentFailureResponse(UNKNOWN_ERROR, 'An unknown error occurred.');
    }

    _eventEmitter.emit(eventName, null, payload);
  }

  /// Registers event listeners for payment events
  void on(String event, Function handler) {
    EventCallback cb = (event, cont) {
      handler(event.eventData);
    };
    _eventEmitter.on(event, null, cb);
    _resync();
  }

  /// Clears all event listeners
  void clear() {
    _eventEmitter.clear();
  }

  /// Retrieves lost responses from platform
  void _resync() async {
    var response = await _channel.invokeMethod('resync');
    if (response != null) {
      _handleResult(response);
    }
  }

  /// Validate payment options
  static Map<String, dynamic> _validateOptions(Map<String, dynamic> options) {
    var key = options['key'];
    if (key == null) {
      return {
        'success': false,
        'message': 'Key is required. Please check if key is present in options.'
      };
    }
    return {'success': true};
  }
}

class PaymentSuccessResponse {
  String paymentId;
  String orderId;
  String signature;

  PaymentSuccessResponse(this.paymentId, this.orderId, this.signature);

  static PaymentSuccessResponse fromMap(Map<dynamic, dynamic> map) {
    String paymentId = map["razorpay_payment_id"];
    String signature = map["razorpay_signature"];
    String orderId = map["razorpay_order_id"];

    return new PaymentSuccessResponse(paymentId, orderId, signature);
  }
}

class PaymentFailureResponse {
  int code;
  String message;

  PaymentFailureResponse(this.code, this.message);

  static PaymentFailureResponse fromMap(Map<dynamic, dynamic> map) {
    var code = map["code"] as int;
    var message = map["message"] as String;
    return new PaymentFailureResponse(code, message);
  }
}

class ExternalWalletResponse {
  String walletName;

  ExternalWalletResponse(this.walletName);

  static ExternalWalletResponse fromMap(Map<dynamic, dynamic> map) {
    var walletName = map["external_wallet"] as String;
    return new ExternalWalletResponse(walletName);
  }
}

//ENDS HERE

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('items');

  //DatabaseReference _rfiddatabaseReference=FirebaseDatabase.instance.reference().child('items');
  // DatabaseReference _itemsdatabaseReference = FirebaseDatabase.instance.reference().child('brought');

  var _razorpay = Razorpay();
  var options;
  Model _item, temp;

  var items = ["egg", "mobile", "soap"];
  var price = 0;
  var docs = [];

  getPrice() async {
    for (var i = 0; i < items.length; i++) {
      _databaseReference.child(items[i]).onValue.listen((event) {
        setState(() {
          _item = Model.fromSnapshot(event.snapshot);
          price = price + _item.price;
        });
      });
    }
  }

  getamount() {
    return (price * 100);
  }

  @override
  void initState() {
    super.initState();
    this.getPrice();
  }

  Future payData() async {
    options = {
      'key': 'rzp_test_4s6BZTBRMPnha3',
      'amount': 353.0, //in the smallest currency sub-unit.
      'name': 'Shop Go',
      'description': 'Your total items costs ',
      'prefill': {'contact': '8945529381', 'email': 'mashutoshrao@gmail.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("error occured !! ");
    }

//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    navigateToAddPage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LastPage();
      }));
    }
  }

  final headerTextStyle = TextStyle(fontFamily: 'Poppins').copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  final regularTextStyle = TextStyle(fontFamily: 'Poppins').copyWith(
      color: Colors.white,
      fontSize: 9.0,
      fontWeight: FontWeight.w400);

  final subHeaderTextStyle = TextStyle(fontFamily: 'Poppins').copyWith(
      color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w600);

  navigateToAddPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPage();
    }));
  }

  navigateToViewPage(id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ViewPage(id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Shop Go",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26.0,
                color: Colors.white,
                fontFamily: 'Poppins'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
          ),
        ],
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return GestureDetector(
                onTap: () {
                  navigateToViewPage(snapshot.key);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Container(
                        height: 124.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Container(
                          margin:
                              new EdgeInsets.fromLTRB(76.0, 10.0, 16.0, 16.0),
                          constraints: new BoxConstraints.expand(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(height: 4.0),
                              new Text(
                                "${snapshot.value['data']['name']}",
                                style: headerTextStyle,
                              ),
                              new Container(height: 10.0),
                              new Text("${snapshot.value['data']['weight']}g",
                                  style: regularTextStyle),
                              new Container(
                                  margin:
                                      new EdgeInsets.symmetric(vertical: 8.0),
                                  height: 2.0,
                                  width: 18.0,
                                  color: new Color(0xff00c6ff)),
                              new Row(
                                children: <Widget>[
                                  new Container(width: 8.0),
                                  new Text(
                                    "Rs. ${snapshot.value['data']['price']}",
                                    style: subHeaderTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          payData();
        },
        icon: Icon(Icons.payment),
        label: Text("PAY"),
      ),
    );
  }
}
