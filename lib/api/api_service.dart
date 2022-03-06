import 'package:massaverse/api/network_service.dart';

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
    //print("response: $response");
    return response;
  }

/*
//get address balance
  Future<Wallet> fetchBalance(String address) async {
    var method = "fetch-balance";
    var params = {"address": address};
    //Uri uri = Uri.http(torUrl, "");
    var response = await _post(torUri, method, params);
    //print(response);
    response = response["result"];
    var data = Map<String, dynamic>.from(response);
    return Wallet.fromJson(data);
  }

  Future<List<Wallet>> fetchBalances(List<String> addresses) async {
    var method = "fetch-balances";
    var params = {"addresses": addresses};
    var response = await _post(torUri, method, params);

    response = response["result"];

    List<Wallet> wallets = List.empty();
    for (Map<String, dynamic> pro in response) {
      wallets.add(Wallet.fromJson(pro));
    }

    return wallets;
  }

  //Fetch address transactions history
  Future<List<TransactionHistory>> fetchHistory(String address) async {
    var method = "fetch-history";
    //var params = {"address": address, "beginTx": start, "countTxs": txNumber};
    var params = {"address": address};
    var response = await _post(torUri, method, params);
    response = response["result"];
    //print("response: ${response.toString()}");
    //response = List.from(response);

    List<TransactionHistory> history = [];
    for (Map<String, dynamic> pro in response) {
      //print("transaction: ${pro.toString()}");
      history.add(TransactionHistory.fromJson(pro));
    }

    return history;
  }

  //Fetch active delegation of a given
  Future<List<Delegation>> fetchDelegation(
      String address, int start, int txNumber) async {
    var method = "get-address-delegations";
    var params = {"address": address, "beginTx": start, "countTxs": txNumber};
    var response = await _post(torUri, method, params);
    response = response["result"];

    List<Delegation> delegations = List.empty();
    for (Map<String, dynamic> pro in response["states"]) {
      delegations.add(Delegation.fromJson(pro));
    }

    return delegations;
  }

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

  Future<dynamic> _post(Uri url, String method, Map? params) {
    _body["method"] = method;
    if (params != null) {
      _body["params"] = params;
    }
    //print("body: ")
    return _client.post(url, body: _body);
  }
}
