app.controller("BindersController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiBinders = new Procedure({ Name: "apiBinders", UserId: true, Type: "array", ngModel: "Binders" });
    apiBinders.Execute($scope);

}]);

app.controller("BinderController", ["$scope", "$routeParams", "$route", "Procedure", function ($scope, $routeParams, $route, Procedure) {

    var New = asqlIsBlank($routeParams.BinderId);

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

    $scope.Save = new Procedure({
        Name: (New === true) ? "apiBinderInsert" : "apiBinderUpdate",
        UserId: true, Type: "singleton",
        Parameters: [
            { Name: "UMR", Type: "scope", Value: "Binder.UMR" },
            { Name: "Reference", Type: "scope", Value: "Binder.Reference" },
            { Name: "CoverholderId", Type: "scope", Value: "Binder.CoverholderId" },
            { Name: "BrokerId", Type: "scope", Value: "Binder.BrokerId" },
            { Name: "InceptionDate", Type: "scope", Value: "Binder.InceptionDate" },
            { Name: "ExpiryDate", Type: "scope", Value: "Binder.ExpiryDate" },
            { Name: "RisksTerritoryId", Type: "scope", Value: "Binder.RisksTerritoryId" },
            { Name: "DomiciledTerritoryId", Type: "scope", Value: "Binder.DomiciledTerritoryId" },
            { Name: "LimitsTerritoryId", Type: "scope", Value: "Binder.LimitsTerritoryId" }
        ],
        Success: function (Data) { $scope.Binder = Data; }
    });
    if (New !== true) $scope.Save.AddParameter({ Name: "BinderId", Type: "route" });

}]);