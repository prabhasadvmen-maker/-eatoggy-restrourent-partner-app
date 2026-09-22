class FaqItemModel {
  final String id;
  final String question;
  final String answer;

  const FaqItemModel({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class HelpSupportModel {
  final String phoneNumber;
  final String email;
  final String operatingHoursText;
  final List<String> issueCategories;
  final List<FaqItemModel> faqs;

  const HelpSupportModel({
    required this.phoneNumber,
    required this.email,
    required this.operatingHoursText,
    required this.issueCategories,
    required this.faqs,
  });

  static HelpSupportModel get dummy => const HelpSupportModel(
        phoneNumber: '+91 9999 8888 77',
        email: 'partner@eatoggy.com',
        operatingHoursText:
            'Support is operational everyday from 9:00 AM to 9:00 PM',
        issueCategories: [
          'Payout Issue',
          'Order Delay',
          'App Technical Glitch',
          'Menu Update Problem',
          'Customer Dispute',
          'Other',
        ],
        faqs: [
          FaqItemModel(
            id: 'faq_1',
            question: 'How to manage orders?',
            answer:
                'Go to the "Orders" tab. New incoming orders will flash in the "New" tab. You can accept, mark as preparing, and subsequently update status to Ready for pickup once cooked.',
          ),
          FaqItemModel(
            id: 'faq_2',
            question: 'How to update kitchen menu?',
            answer:
                'Navigate to the "Menu" tab from the bottom bar. You can add new dishes, modify existing prices, or toggle item availability with a single tap.',
          ),
          FaqItemModel(
            id: 'faq_3',
            question: 'How to handle order refunds?',
            answer:
                'Refund requests are reviewed under the Orders history section. You can inspect dispute reasons, accept them directly, or escalate to customer support.',
          ),
          FaqItemModel(
            id: 'faq_4',
            question: 'Subscription plan management?',
            answer:
                'Manage weekly or monthly tiffin delivery plans directly from the Subscriptions dashboard under the Kitchen tab.',
          ),
        ],
      );
}
