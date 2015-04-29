app.controller("LoginController", ["$scope", "$http", "$modalInstance", function ($scope, $http, $modalInstance) {

    $scope.Login = function () {
        $http.post("login.ashx", { Email: $scope.Email, Password: $scope.Password })
            .success(function (Data) { window.alert(JSON.stringify(Data)); })
            .error(function (Data) { window.alert(JSON.stringify(Data)); });
    };

    $scope.Cancel = function () { $modalInstance.dismiss("Cancel"); };

}]);