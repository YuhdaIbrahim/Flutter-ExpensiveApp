import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expensive_apps/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transaction.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'No Transaction yet!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FittedBox(
                          child: Text(
                            '\$${transaction[index].amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(transaction[index].title),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transaction[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onPressed: () => deleteTx(transaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
