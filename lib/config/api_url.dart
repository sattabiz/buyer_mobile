class ApiUrls{
  static const String baseUrl = String.fromEnvironment('API_URL', defaultValue: 'https://test.satta.biz/api/v1');

  static const String customerCompanyId = String.fromEnvironment('CUSTOMER_COMPANY_ID', defaultValue: '91');

  static const String login = "$baseUrl/login.json";
  static const String logout = "$baseUrl/logout.json";
  static const String forgotPassword = "$baseUrl/forgot_password.json";


  static const String proposals = "$baseUrl/supplier_proposals_by_state.json?proposal_state='pending','replied','proposal_stvs','last_offer'&customer_company_id=$customerCompanyId";
  static const String replyProposal = "$baseUrl/supplier_reply_proposal.json";
  static const String currencies = "$baseUrl/list_available_currencies.json";

  
  static const String orders = "$baseUrl/supplier_order_list_by_state.json?state='order_approved','order_prepared','order_on_the_way','order_delivered','order_confirmed'&customer_company_id=$customerCompanyId";
  static const String confirmOrder = "$baseUrl/supplier_confirm_order.json";

  
  static const String shipment = "$baseUrl/supplier_shipment_list.json?state='order_prepared'&customer_id=$customerCompanyId";
  static const String createShipment = "$baseUrl/supplier_create_shipment_record.json";
  static String cancelPreparedShipment (String id){
    return "$baseUrl/supplier_cancel_prepared_shipment.json?shipment_id=$id";
  }


  static const String invoices = "$baseUrl/supplier_invoice_list_by_state.json?state='invoice_sended','invoice_approved','invoice_approved_dbs','invoice_collecting','invoice_discounted','invoice_goods_delivered'&customer_company_id=$customerCompanyId";
  static const String invoicesPaid = "$baseUrl/supplier_invoice_paid.json";
  static const String createMultiOrderInvoice = "$baseUrl/supplier_generate_multi_order_shipment.json";


  static const String address = "$baseUrl/list_avaliable_customer_addresses.json?customer_company_id=1";


  static String getMessage (String id){
    return "$baseUrl/list_messages.json?$id";
  }
  static const String createMessage = "$baseUrl/post_message.json";

  static const String notifications = "$baseUrl/supplier_list_current_notifications.json?customer_company_id=$customerCompanyId";

  static const String userInfo = "$baseUrl/current_user_info.json";


  ///supplier_confirm_order.json
}