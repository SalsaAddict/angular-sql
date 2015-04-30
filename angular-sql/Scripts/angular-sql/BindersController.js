app.controller("BindersController", ["$scope", "Procedure", function ($scope, Procedure) {

    var P1 = new Procedure({
        Name: "apiUserLogin",
        Type: "singleton",
        ngModel: "UserLogin"
    });
    P1.AddParameter({ Name: "Email", Type: "scope", Value: "$localStorage.Email" });
    P1.AutoExec($scope);

}]);