app.controller("BindersController", ["$scope", "$location", "Procedure", function ($scope, $location, Procedure) {

    var apiBinders = new Procedure({ Name: "apiBinders", UserId: true, Type: "array", ngModel: "Binders" });
    apiBinders.Execute($scope);

    $scope.New = function () { $location.path("/binder"); };
    $scope.View = function (BinderId) { $location.path("/binder/" + BinderId); };

}]);

app.controller("BinderController", ["$scope", "$routeParams", "$route", "$location", "Procedure", function ($scope, $routeParams, $route, $location, Procedure) {

    $scope.IsNew = function () { return asqlIsBlank($routeParams.BinderId); };

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

    var apiDomiciled = new Procedure({
        Name: "apiBinderDomiciled", UserId: true, Type: "singleton", ngModel: "Domiciled",
        Parameters: [
            { Name: "CoverholderId", Type: "scope", Value: "Binder.CoverholderId", Required: true },
            { Name: "DomiciledTerritoryId", Type: "scope", Value: "Binder.DomiciledTerritoryId", Required: true }
        ]
    });
    apiDomiciled.AutoExec($scope);

    var apiSections = new Procedure({
        Name: "apiBinderSections", UserId: true, Type: "array", ngModel: "Sections",
        Parameters: [{ Name: "BinderId", Type: "route", Required: true }]
    });
    apiSections.Execute($scope);

    $scope.NewSection = function () { $location.path("/binder/" + $routeParams.BinderId + "/section"); };
    $scope.ViewSection = function (SectionId) { $location.path("/binder/" + $routeParams.BinderId + "/section/" + SectionId); };

    $scope.Save = new Procedure({
        Name: "apiBinderSave",
        UserId: true, Type: "singleton",
        Parameters: [
            { Name: "BinderId", Type: "route" },
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
        Success: function (Data) {
            if ($routeParams.BinderId) $scope.Binder = Data;
            else $route.updateParams({ BinderId: Data.BinderId });
        }
    });

}]);
