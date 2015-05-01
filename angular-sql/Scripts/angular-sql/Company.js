app.controller("CompaniesController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiCompanies = new Procedure({ Name: "apiCompanies", UserId: true, Type: "array", ngModel: "Companies" });
    apiCompanies.Execute($scope);

}]);

app.controller("CompanyController", ["$scope", "$routeParams", "Procedure", function ($scope, $routeParams, Procedure) {

    var apiCompany = new Procedure({
        Name: "apiCompany", UserId: true, Type: "singleton", ngModel: "Company",
        Parameters: [
            { Name: "CountryId", Type: "route", Required: true },
            { Name: "Name", Type: "route", Required: true }
        ]
    });
    apiCompany.Execute($scope);

    var apiCompanyRoles = new Procedure({ Name: "apiCompanyRoles", Type: "array", ngModel: "Roles" });
    apiCompanyRoles.Execute($scope);

    var apiCountries = new Procedure({ Name: "apiCountries", Type: "array", ngModel: "Countries" });
    apiCountries.Execute($scope);

    $scope.Save = new Procedure({
            Name: "apiCompanySave", UserId: true, Type: "singleton",
            Parameters: [
                { Name: "Name", Type: "scope", Value: "Company.Name", Required: true },
                { Name: "Address", Type: "scope", Value: "Company.Address" },
                { Name: "Postcode", Type: "scope", Value: "Company.Postcode" },
                { Name: "CountryId", Type: "scope", Value: "Company.CountryId", Required: true }
            ]
        });
    angular.forEach($scope.Roles, function (Item) { $scope.Save.AddParameter({ Name: Item.Id, Type: "scope", Value: "Company." + Item.Id }) });
    if (!$routeParams.New) $scope.Save.AddParameter({ Name: "CompanyId", Type: "scope", Value: "Company.CompanyId" });

    $scope.Delete = new Procedure({
        Name: "apiCompanyDelete", UserId: true,
        Parameters: [{ Name: "CompanyId", Type: "scope", Value: "Company.CompanyId", Required: true }]
    });

}]);