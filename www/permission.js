cordova.define("cordova-plugin-ios-grant-permission.permission", function(require, exports, module) {
    var cordova = require('cordova');
    
    // Empty constructor
    function GrantPermissionsFunction() {}
    
    GrantPermissionsFunction.prototype.grantNotificationPermission = function (text, success, error) {
        cordova.exec(success, error, 'meomeopermission', 'grantNotificationPermission', [text]);
    };
    
    GrantPermissionsFunction.prototype.grantCameraPermission = function (arg0, success, error) {
        cordova.exec(success, error, 'meomeopermission', 'grantCameraPermission', [arg0]);
    };
    
    GrantPermissionsFunction.prototype.openSetting = function (arg0, success, error) {
        cordova.exec(success, error, 'meomeopermission', 'openSetting', [arg0]);
    };
    
    GrantPermissionsFunction.prototype.isGrantPermission = function (arg0, success, error) {
        cordova.exec(success, error, 'meomeopermission', 'isGrantPermission', [arg0]);
    };
    
    
    
    // Register the plugin
    var grantPermissionsFunc = new GrantPermissionsFunction();
    module.exports = grantPermissionsFunc;
    });
    