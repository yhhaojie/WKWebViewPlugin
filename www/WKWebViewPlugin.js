module.exports = {

  openPage:function (arg, successCallback, errorCallback) {

    cordova.exec(successCallback, errorCallback, "WKWebViewPlugin", "openPage", [arg]);
  }


};
