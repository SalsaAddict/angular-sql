app.controller("LoginController", ["$scope", "$http", "$modalInstance", "Message", function ($scope, $http, $modalInstance, Message) {

    $scope.Message = Message;

    $scope.Login = function () {
        $http.post("login.ashx", { Email: $scope.$ls.Email, Password: $scope.Password })
            .success(function (Data) {
                $scope.$ls.Token = Data.Token;
                $modalInstance.close();
            })
            .error(function (Response) {
                $scope.$ls.Token = null;
                $scope.Message = Response;
            });
    };

    $scope.Cancel = function () { $modalInstance.dismiss("Cancel"); };

    $scope.DismissMessage = function () { $scope.Message = null; };

}]);