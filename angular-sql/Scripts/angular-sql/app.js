function asqlIsBlank(Value) {
    if (Value === undefined) return true;
    else if (Value === null) return true;
    else if (Value.toString().length === 0) return true;
    else return false;
};

function asqlIfBlank(Value, DefaultValue) {
    return (asqlIsBlank(Value)) ? DefaultValue : Value;
};

function asqlRestrict(Value, AllowedValues, DefaultValue) {
    if (!asqlIsBlank(Value)) { if (AllowedValues.indexOf(Value) >= 0) { return Value; } }
    return asqlIfBlank(DefaultValue, null);
};

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

    $rootScope.$ls = $localStorage;

    $rootScope.LoggedIn = function () { return ($localStorage.Token) ? true : false; };

    $rootScope.Login = function (Message) {
        var LoginModal = $modal.open({
            templateUrl: "LoginForm.html",
            controller: "LoginController",
            resolve: { Message: function () { return Message; } }
        });
    };

    $rootScope.Logout = function () { $localStorage.Token = null; }

}]);

app.controller("ExecController", ["$scope", "$http", function ($scope, $http) {

    $scope.$ls.$default({ Input: { Name: "", Type: "", Parameters: [] } });

    $scope.Exec = function () {
        $scope.$ls.Input.Token = $scope.$ls.Token;
        $http.post("exec.ashx", $scope.$ls.Input)
            .success(function (Data) { $scope.Output = Data; })
            .error(function (Response) { $scope.Output = Response; });
    };

}]);

app.controller("BindersController", ["$scope", "Procedure", function ($scope, Procedure) {

    $scope.Procedure = new Procedure({ Name: "apiBinders", Type: "array", UserId: true, Parameters: [{ Name: "Test" }] });
    $scope.Procedure.AddParameter({ Name: "UserId", Type: "scope" });

}]);