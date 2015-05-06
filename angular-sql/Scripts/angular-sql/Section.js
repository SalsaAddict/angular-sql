app.controller("SectionController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiSection = new Procedure({
        Name: "apiBinderSection", UserId: true, Type: "singleton", ngModel: "Section",
        Parameters: [{ Name: "SectionId", Type: "route", Required: true }]
    });
    apiSection.Execute($scope);

    var apiClass = new Procedure({ Name: "apiClassOfBusiness", UserId: true, Type: "array", ngModel: "Classes" });
    apiClass.Execute($scope);

    var apiAdjusters = new Procedure({
        Name: "apiBinderSectionAdjuster", UserId: true, Type: "array", ngModel: "Adjusters",
        Parameters: [{ Name: "SectionId", Type: "route" }]
    });
    apiAdjusters.Execute($scope);

    $scope.Save = {};

}]);