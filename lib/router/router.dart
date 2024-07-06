import "package:atk_inventoris/admin/additem.dart";
import "package:atk_inventoris/admin/dashboard.dart";
import "package:atk_inventoris/admin/itemdetail.dart";
import "package:atk_inventoris/admin/itemreport.dart";
import "package:atk_inventoris/admin/itemrequests.dart";
import "package:atk_inventoris/admin/orderstatus.dart";
import "package:atk_inventoris/admin/retrieveitem.dart";
import "package:atk_inventoris/admin/stockitem.dart";
import "package:atk_inventoris/admin_user/cs_contact.dart";
import "package:atk_inventoris/admin_user/error.dart";
import "package:atk_inventoris/admin_user/fpassword.dart";
import "package:atk_inventoris/admin_user/login.dart";
import "package:atk_inventoris/admin_user/mainpage.dart";
import "package:atk_inventoris/admin_user/profile.dart";
import "package:atk_inventoris/admin_user/register.dart";
import "package:atk_inventoris/cust_service/cs_front_page.dart";
import "package:atk_inventoris/cust_service/customer_complaints.dart";
import "package:atk_inventoris/cust_service/dashboard.dart";
import "package:atk_inventoris/cust_service/history.dart";
import "package:atk_inventoris/cust_service/maintenance.dart";
import "package:atk_inventoris/cust_service/maintenance_page.dart";
import "package:atk_inventoris/router/routernamed.dart";
import "package:atk_inventoris/user/dashboard.dart";
import "package:atk_inventoris/user/itemdetail.dart";
import "package:atk_inventoris/user/itemrequest.dart";
import "package:atk_inventoris/user/orderstatus.dart";
import "package:atk_inventoris/user/retrieveitem.dart";
import "package:atk_inventoris/user/stockitem.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class MyRouter {
  GoRouter router = GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          name: RouterName.mainPageName,
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: "/login",
          name: RouterName.loginPageName,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginPage());
          },
        ),
        GoRoute(
            path: "/register",
            name: RouterName.registerPageName,
            pageBuilder: (context, state) {
              return const MaterialPage(child: RegisterPage());
            }),
        GoRoute(
            path: "/forgot_password",
            name: RouterName.forgotPassPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ForgotPage());
            }),
        GoRoute(
            path: "/profile",
            name: RouterName.profilePage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProfilePage());
            }),
        GoRoute(
            path: "/dashboard_admin",
            name: RouterName.dashboardAdminPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: DashboardAdminPage());
            }),
        GoRoute(
            path: "/dashboard_user",
            name: RouterName.dashboardUserPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: DashboardUserPage());
            }),
        GoRoute(
            path: "/stock_item_admin",
            name: RouterName.stockItemAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: StockItemAdmin());
            }),
        GoRoute(
            path: "/stock_item_user",
            name: RouterName.stockItemUserPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: StockItemUser());
            }),
        GoRoute(
            path: "/add_item",
            name: RouterName.addItemAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: AddItem());
            }),
        GoRoute(
            path: "/item_request_user",
            name: RouterName.itemRequestsUserPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ItemRequest());
            }),
        GoRoute(
            path: "/order_status_admin",
            name: RouterName.orderStatusAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: OrderStatusAdmin());
            }),
        GoRoute(
            path: "/item_report_admin",
            name: RouterName.itemReportsAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ItemReportAdmin());
            }),
        GoRoute(
            path: "/item_request_admin",
            name: RouterName.itemRequestsAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ItemRequestAdmin());
            }),
        GoRoute(
            path: "/item_retrieve_admin",
            name: RouterName.retrieveItemAdminPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ItemRetrieveAdmin());
            }),
        GoRoute(
          path: "/item_details_admin/:index",
          name: RouterName.itemDetailAdminPage,
          pageBuilder: (context, state) {
            final int index = int.parse(state.pathParameters['index']!);
            return MaterialPage(
              child: ItemDetailsAdmin(
                itemIndex: index,
              ),
            );
          },
        ),
        GoRoute(
            path: "/order_status_user",
            name: RouterName.orderStatusUserPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: OrderStatusUser());
            }),
        GoRoute(
            path: "/item_retrieve_user",
            name: RouterName.itemRetrieveUserPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ItemRetrieveUser());
            }),
        GoRoute(
          path: "/item_details_user/:index",
          name: RouterName.itemDetailUserPage,
          pageBuilder: (context, state) {
            final int index = int.parse(state.pathParameters['index']!);
            return MaterialPage(
              child: ItemDetailsUser(itemIndex: index),
            );
          },
        ),
        GoRoute(
            path: "/cs",
            name: RouterName.customerServicePage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: OrderStatusUser());
            }),
        GoRoute(
            path: "/cs_contact",
            name: RouterName.csContact,
            pageBuilder: (context, state) {
              return const MaterialPage(child: CSContact());
            }),
        GoRoute(
            path: "/cust_complaint",
            name: RouterName.custComplaint,
            pageBuilder: (context, state) {
              return const MaterialPage(child: CustomerComplaintPage());
            }),
        GoRoute(
            path: "/dashboard_cs",
            name: RouterName.dashboardCSPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: DashboardCSPage());
            }),
        GoRoute(
            path: "/maintenance-service",
            name: RouterName.maintenanceService,
            pageBuilder: (context, state) {
              return const MaterialPage(child: MaintenanceService());
            }),
        GoRoute(
            path: "/maintenance",
            name: RouterName.maintenancePage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: Maintenance());
            }),
        GoRoute(
            path: "/maintenance_history",
            name: RouterName.maintenanceHistory,
            pageBuilder: (context, state) {
              return const MaterialPage(child: MaintenanceHistoryPage());
            }),
        GoRoute(
            path: "/cs_front",
            name: RouterName.custServiceFrontPage,
            pageBuilder: (context, state) {
              return const MaterialPage(child: CsFrontPage());
            }),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage(key: state.pageKey));
      });
}
