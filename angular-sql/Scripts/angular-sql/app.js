﻿var app = angular.module("angular-sql", ["ngRoute", "ui.bootstrap"]);

app.config(["$logProvider", "$routeProvider", function ($logProvider, $routeProvider) {
    $logProvider.debugEnabled(true);
    $routeProvider
        .when("/home", { caseInsensitiveMatch: true, templateUrl: "views/home.html" })
        .otherwise({ redirectTo: "/home" });
}]);

app.run(["$rootScope", "$modal", function ($rootScope, $modal) {

    $rootScope.Login = function () {
        var LoginModal = $modal.open({
            templateUrl: "LoginForm.html",
            controller: "LoginController"
        });
    };

}]);