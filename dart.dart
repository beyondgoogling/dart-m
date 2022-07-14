import 'dart:io';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

const String privateKey =
    'bbb739d33b5190e49323ba71957e735c66f91bc4b70f5988765dc7b67fe688fe';
const String rpcUrl =
    'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';

Future<void> main() async {
  // start a client we can use to send transactions
  final client = Web3Client(rpcUrl, Client());
  while (true) {
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = credentials.address;
    print(address.hexEip55);

    var walletBalance = await client.getBalance(address);
    var bintWalletBalance = walletBalance.getValueInUnitBI(EtherUnit.wei);
    //int gtz = .@override

    print(bintWalletBalance);
    print(bintWalletBalance.runtimeType);
    final minimumGas =
        EtherAmount.fromUnitAndValue(EtherUnit.wei, 364200000000000);
    final bintminimunGas = minimumGas.getValueInUnitBI(EtherUnit.wei);
    final zero = EtherAmount.fromUnitAndValue(EtherUnit.wei, 0);
    final bintzero = zero.getValueInUnitBI(EtherUnit.ether);
    print(walletBalance);

    final added = EtherAmount.fromUnitAndValue(EtherUnit.wei, 70000);
    final bintadded = added.getValueInUnitBI(EtherUnit.wei);
    // + bintadded);
    print(minimumGas);
    print(bintWalletBalance);
    print(bintzero);
    final gasPrice = await client.getGasPrice();
    final gasPricebint = gasPrice.getInWei;
    final bintValue = bintWalletBalance - (gasPricebint);
    final value = EtherAmount.fromUnitAndValue(EtherUnit.wei, bintValue);
    print(' value to be sent $bintValue');

    //sleep(const Duration(seconds: 40));

    //await Web3client.estimateGas
    if (bintWalletBalance >= bintzero && bintWalletBalance > gasPricebint) {
      print('Money full the wallet');
      var transaction = Transaction(
          to: EthereumAddress.fromHex(
              '0xBB5723d1aB9ED49b3bCD6E770A7a65B3924395AE'),
          //gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 10),
          //maxGas: 21000,
          value: value);

      final maxGas = await client.estimateGas(
          sender: address,
          to: transaction.to,
          value: transaction.value,
          data: transaction.data);
      print(maxGas);
      final fees = gasPricebint * maxGas;
      print('The gass fees is $fees');
      await client.sendTransaction(
          credentials,
          Transaction(
              to: EthereumAddress.fromHex(
                  '0xBB5723d1aB9ED49b3bCD6E770A7a65B3924395AE'),
              gasPrice:
                  gasPrice, // EtherAmount.fromUnitAndValue(EtherUnit.gwei, 10),
              maxGas: 21000,
              value:
                  value //EtherAmount.fromUnitAndValue(EtherUnit.wei, 100000000000000000),
              ),
          chainId: 1);

      print('Transaction Completed');
      print('Balance Is $value');
      await client.dispose();
      sleep(const Duration(seconds: 5));
      print(walletBalance);
      //sleep.(const Duration(seconds: 20));
      //var walletBalance = await client.getBalance(address);
      // var bintWalletBalance = walletBalance.getValueInUnitBI(EtherUnit.wei);
    } else {
      print('wallet finished.');
    }
  }
}
