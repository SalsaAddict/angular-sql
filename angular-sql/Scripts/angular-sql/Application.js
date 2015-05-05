var app = angular.module("angular-sql", ["ngRoute", "ui.bootstrap", "ngStorage"]);

app.config(["$logProvider", "$routeProvider", function ($logProvider, $routeProvider) {
    $logProvider.debugEnabled(true);
    $routeProvider
        .when("/exec", { caseInsensitiveMatch: true, templateUrl: "views/exec.html", controller: "ExecController" })
        .when("/home", { caseInsensitiveMatch: true, templateUrl: "views/home.html" })
        .when("/companies", { caseInsensitiveMatch: true, templateUrl: "views/companies.html", controller: "CompaniesController" })
        .when("/company/:New", { caseInsensitiveMatch: true, templateUrl: "views/company.html", controller: "CompanyController" })
        .when("/company/:CountryId/:Name", { caseInsensitiveMatch: true, templateUrl: "views/company.html", controller: "CompanyController" })
        .when("/binders", { caseInsensitiveMatch: true, templateUrl: "views/binders.html", controller: "BindersController" })
        .when("/binder", { caseInsensitiveMatch: true, templateUrl: "views/binder.html", controller: "BinderController" })
        .when("/binder/:BinderId", { caseInsensitiveMatch: true, templateUrl: "views/binder.html", controller: "BinderController" })
        .otherwise({ redirectTo: "/home" });
}]);

app.run(["$rootScope", "$route", "$localStorage", "$modal", function ($rootScope, $route, $localStorage, $modal) {

    $rootScope.navBarCollapsed = true;
    $rootScope.$on("$routeChangeSuccess", function (event) { $rootScope.navBarCollapsed = true; });

    $rootScope.$localStorage = $localStorage;

    $rootScope.LoggedIn = function () { return ($localStorage.Token) ? true : false; };

    $rootScope.Login = function (Message, Success, Failure) {
        $rootScope.navBarCollapsed = true;
        var LoginModal = $modal.open({
            templateUrl: "LoginForm.html",
            controller: "LoginController",
            backdrop: "static",
            resolve: {
                Message: function () { return Message; },
                Success: function () { return Success; },
                Failure: function () { return Failure; }
            }
        });
    };

    $rootScope.Logout = function () {
        $rootScope.navBarCollapsed = true;
        $localStorage.Token = null;
    }

}]);
