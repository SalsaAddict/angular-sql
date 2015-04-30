app.controller("LoginController",
    ["$scope", "$http", "$modalInstance", "Message", "Success", "Failure",
    function ($scope, $http, $modalInstance, Message, Success, Failure) {

        $scope.Message = Message;

        $scope.Login = function () {
            $http.post("login.ashx", { Email: $scope.$localStorage.Email, Password: $scope.Password })
                .success(function (Data) {
                    $scope.$localStorage.Token = Data.Token;
                    if (angular.isFunction(Success)) Success();
                    $modalInstance.close();
                })
                .error(function (Response) {
                    $scope.$localStorage.Token = null;
                    $scope.Message = Response;
                    if (angular.isFunction(Failure)) Failure();
                });
        };

        $scope.Cancel = function () {
            if (angular.isFunction(Failure)) Failure();
            $modalInstance.dismiss("Cancel");
        };

        $scope.DismissMessage = function () { $scope.Message = null; };

    }]);