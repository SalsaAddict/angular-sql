var app = angular.module("angular-sql", ["ngRoute", "ui.bootstrap", "ngStorage"]);

app.config(["$logProvider", "$routeProvider", function ($logProvider, $routeProvider) {
    $logProvider.debugEnabled(true);
    $routeProvider
        .when("/exec", { caseInsensitiveMatch: true, templateUrl: "views/exec.html", controller: "ExecController" })
        .when("/home", { caseInsensitiveMatch: true, templateUrl: "views/home.html" })
        .when("/binders", { caseInsensitiveMatch: true, templateUrl: "views/binders.html", controller: "BindersController" })
        .otherwise({ redirectTo: "/home" });
}]);

app.run(["$rootScope", "$localStorage", "$modal", function ($rootScope, $localStorage, $modal) {

    $rootScope.$localStorage = $localStorage;

    $rootScope.LoggedIn = function () { return ($localStorage.Token) ? true : false; };

    $rootScope.Login = function (Message, Success, Failure) {
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

    $rootScope.Logout = function () { $localStorage.Token = null; }

}]);
