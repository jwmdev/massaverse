import 'package:massaverse/api/network_service.dart';
import 'package:massaverse/models/address_response.dart';
import 'package:massaverse/models/block_response.dart';
import 'package:massaverse/models/cliques_response.dart';
import 'package:massaverse/models/operations_response.dart';
import 'package:massaverse/models/send_transaction.dart';
import 'package:massaverse/models/status_response.dart';

class SendResponse {
  bool status;
  String txHash;
  SendResponse({required this.status, required this.txHash});
}

class ApiService {
  //Singleton class
  static final ApiService _instance = ApiService.internal();
  ApiService.internal();
  factory ApiService() => _instance;

  final Map<String, dynamic> _body = {
    "jsonrpc": "2.0",
    "id": 123,
    "method": "",
  };

  final Uri privUri = Uri.http("test.massa.net:33034", "");
  final Uri pubUri = Uri.http("test.massa.net:33035", "");

  //final Uri proxyUri = Uri.http("proxy.net-main.metahashnetwork.com:9999", "");

  final NetworkService _client = NetworkService();

  Future<dynamic> getStatus() async {
    var method = "get_status";
    var response = await _post(pubUri, method, null);
    response = response["result"];
    var data = Map<String, dynamic>.from(response);
    return StatusResponse.decode(data);
  }

  Future<dynamic> getCliques() async {
    var method = "get_cliques";
    var response = await _post(pubUri, method, null);
    response = response["result"];
    var data = List<dynamic>.from(response);
    return CliquesResponse.decode(data[0]);
  }

// getStakers returns a map of addresses with their respective staked rolls
  Future<Map<dynamic, dynamic>> getStakers() async {
    var method = "get_stakers";
    var response = await _post(pubUri, method, null);
    response = response["result"];
    var data = Map<dynamic, dynamic>.from(response);
    return data;
  }

  Future<dynamic> getOperations(List<String> ops) async {
    var method = "get_operations";
    var params = [ops];
    var response = await _post(pubUri, method, params);
    response = response["result"];
    var data = List<dynamic>.from(response);
    if (data.isNotEmpty) {
      return OperationsResponse.decode(
          data[0]); //currently returning a single operation
    }
    return [];
  }

  Future<dynamic> getEndosements(List<String> endosement) async {
    var method = "get_endorsements";
    var params = [endosement];
    var response = await _post(pubUri, method, params);
    print("endosement: $response");
    response = response["result"];
    print("endosement: $response");
    var data = List<dynamic>.from(response);
    /*if (data.isNotEmpty) {
      return OperationsResponse.decode(
          data[0]); //currently returning a single operation
    }*/
    return [];
  }

  Future<dynamic> getBlock(String blockHash) async {
    var method = "get_block";
    var params = [blockHash];
    var response = await _post(pubUri, method, params);
    //print("block: $response");
    response = response["result"];
    var data = Map<String, dynamic>.from(response);
    return BlockResponse.decode(data);
  }

  Future<dynamic> getAddresses(List<String> addresses) async {
    var method = "get_addresses";
    var params = [addresses];
    var response = await _post(pubUri, method, params);
    //print("addresses: $response");
    response = response["result"];

    /*var data = List<dynamic>.from(response);
    if (data.isNotEmpty) {
      return AddressResponse.decode(
          data[0]); //currently returning a single operation
    }*/
    return response;
  }

//send
  Future<dynamic> sendTransaction(final SendTransaction tx) async {
    var method = "send_operations";
    var params = [
      [tx.encode()]
    ];
    var response = await _post(pubUri, method, params);
    //print("addresses: $response");
    //response = response["result"];
    return response;
  }
/*

//send fund and returns transaction id
  Future<SendResponse> send(final MetaTxArg tx) async {
    var method = "mhc_send";
    var params = {
      "to": tx.toAddress,
      "value": tx.value,
      "fee": tx.fee,
      "nonce": tx.nonce,
      "data": tx.data,
      "pubkey": tx.publicKey,
      "sign": tx.signature
    };
    var response = await _post(proxyUri, method, params);
    if (response == null) {
      return SendResponse(status: false, txHash: "");
    }

    if (response["result"] == "ok") {
      return SendResponse(status: true, txHash: response["params"]);
    }
    return SendResponse(status: false, txHash: response["params"]);
  }*/

  Future<dynamic> _post(Uri url, String method, dynamic params) {
    _body["method"] = method;
    if (params != null) {
      _body["params"] = params;
    }
    //print("body: ")
    return _client.post(url, body: _body);
  }
}
