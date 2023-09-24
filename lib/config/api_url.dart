class ApiUrls{
  static const String baseUrl = "https://test.satta.biz/api/v1";
  static const String login = "$baseUrl/login.json";
  static const String logout = "$baseUrl/logout.json";
  static const String proposals = "$baseUrl/supplier_proposals_by_state.json?proposal_state='proposal_stvs','ordered'&customer_company_id=91";
  static const String orders = "$baseUrl/supplier_order_list_by_state.json?state='order_approved','order_pending','order_confirmed'&customer_id=91";
  static const String invoices = "$baseUrl/supplier_invoice_list_by_state.json?state='invoice_approved','invoice_pending'&customer_company_id=91";
  static const String invoicesPaid = "$baseUrl/supplier_invoice_paid.json";
  
}