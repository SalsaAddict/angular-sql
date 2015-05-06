var app = angular.module("angular-sql", ["ngRoute", "ui.bootstrap", "ngStorage"]);

app.config(["$logProvider", "$routeProvider", function ($logProvider, $routeProvider) {
    $logProvider.debugEnabled(true);
    $routeProvider
        .when("/exec", { caseInsensitiveMatch: true, templateUrl: "views/exec.html", controller: "ExecController" })
        .when("/home", { caseInsensitiveMatch: true, templateUrl: "views/home.html" })
        .when("/companies", { caseInsensitiveMatch: true, templateUrl: "views/companies.html", controller: "CompaniesController" })
        .when("/company/:CompanyId?", { caseInsensitiveMatch: true, templateUrl: "views/company.html", controller: "CompanyController" })
        .when("/binders", { caseInsensitiveMatch: true, templateUrl: "views/binders.html", controller: "BindersController" })
        .when("/binder/:BinderId?", { caseInsensitiveMatch: true, templateUrl: "views/binder.html", controller: "BinderController" })
        .when("/binder/:BinderId/section/:SectionId?", { caseInsensitiveMatch: true, templateUrl: "views/bindersection.html", controller: "SectionController" })
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
    };

    $rootScope.Success = function (Message) {
        var SuccessModal = $modal.open({
            templateUrl: "Success.html",
            controller: ["$scope", "$modalInstance", "Message", function ($scope, $modalInstance, Message) {
                $scope.Message = Message;
                $scope.OK = function () { $modalInstance.close(); };
            }],
            resolve: { Message: function () { return Message; } }
        });
    };

    $rootScope.Error = function (Message) {
        var SuccessModal = $modal.open({
            templateUrl: "Error.html",
            controller: ["$scope", "$modalInstance", "Message", function ($scope, $modalInstance, Message) {
                $scope.Message = Message;
                $scope.OK = function () { $modalInstance.close(); };
            }],
            resolve: { Message: function () { return Message; } }
        });
    };

}]);
