import 'package:flutter/material.dart';

class TransactionsTile extends StatelessWidget {
  final IconData icon;
  final String transactions;
  final String price;
  final String type;

  const TransactionsTile({
    Key? key,
    required this.icon,
    required this.transactions,
    required this.price,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Icon(
                      icon,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
