app.controller("BindersController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiBinders = new Procedure({ Name: "apiBinders", UserId: true, Type: "array", ngModel: "Binders" });
    apiBinders.Execute($scope);

}]);

app.controller("BinderController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiBinder = new Procedure({
        Name: "apiBinder", UserId: true, Type: "singleton", ngModel: "Binder",
        Parameters: [{ Name: "BinderId", Type: "route", Required: true }]
    });
    apiBinder.Execute($scope);

    var apiCoverholders = new Procedure({
        Name: "apiBinderCoverholder", UserId: true, Type: "array", ngModel: "Coverholders",
        Parameters: [{ Name: "BinderId", Type: "route" }]
    });
    apiCoverholders.Execute($scope);

    var apiBrokers = new Procedure({
        Name: "apiBinderBroker", UserId: true, Type: "array", ngModel: "Brokers",
        Parameters: [{ Name: "BinderId", Type: "route" }]
    });
    apiBrokers.Execute($scope);

    var apiTerritories = new Procedure({ Name: "apiTerritories", Type: "array", ngModel: "Territories" });
    apiTerritories.Execute($scope);

    $scope.Save = {};

}]);