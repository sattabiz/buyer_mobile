class ApiUrls{
  static const String baseUrl = "https://test.satta.biz/api/v1";
  static const String login = "$baseUrl/login.json";
  static const String logout = "$baseUrl/logout.json";
  static const String proposals = "$baseUrl/supplier_proposals_by_state.json?proposal_state='pending','replied','proposal_stvs','last_offer'&customer_company_id=91";
  static const String replyProposal = "$baseUrl/supplier_reply_proposal.json";
  static const String currencies = "$baseUrl/list_available_currencies.json";
  static const String orders = "$baseUrl/supplier_order_list_by_state.json?state='order_approved','order_prepared','order_on_the_way','order_delivered','order_confirmed'&customer_id=1";
  static const String confirmOrder = "$baseUrl/supplier_confirm_order.json";
  static const String shipment = "$baseUrl/supplier_shipment_list.json?state='order_prepared'&customer_id=1";
  static const String invoices = "$baseUrl/supplier_invoice_list_by_state.json?state='invoice_sended','invoice_approved','invoice_approved_dbs','invoice_collecting','invoice_discounted','invoice_goods_delivered'&customer_company_id=1";
  static const String invoicesPaid = "$baseUrl/supplier_invoice_paid.json";
  static const String createMultiOrderInvoice = "$baseUrl/supplier_generate_multi_order_shipment.json";
  static const String address = "$baseUrl/list_avaliable_customer_addresses.json?customer_company_id=1";
  
  ///supplier_confirm_order.json
}