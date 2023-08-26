import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(
    this.summaryData, {
    super.key,
  });

  final Map<String, Object> summaryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: summaryData['is_correct'] as bool
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        border: Border.all(
          color: summaryData['is_correct'] as bool ? Colors.green : Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: summaryData['is_correct'] as bool
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${summaryData['question_index']}',
              style: TextStyle(
                color: summaryData['is_correct'] as bool
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${summaryData['question']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Correct Answer: ${summaryData['correct_answer']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 61, 156, 66),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your Answer: ${summaryData['user_answer']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
