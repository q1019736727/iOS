// This file contains the source for the Javascript side of the
// WebViewJavascriptBridge. It is plaintext, but converted to an NSString
// via some preprocessor tricks.
//
// Previous implementations of WebViewJavascriptBridge loaded the javascript source
// from a resource. This worked fine for app developers, but library developers who
// included the bridge into their library, awkwardly had to ask consumers of their
// library to include the resource, violating their encapsulation. By including the
// Javascript as a string resource, the encapsulation of the library is maintained.

#import "WebViewJavascriptBridge_JS.h"



NSString * WebViewJavascriptBridge_js() {
	#define __wvjb_js_func__(x) #x
	
	// BEGIN preprocessorJSCode
	static NSString * preprocessorJSCode = @__wvjb_js_func__(
;(function() {
        
        
        
    /*
    其实我们发现整个js文件就是一个立即执行的javascript方法。
        
    1. 首先我们发现会初始化一个WebViewJavascriptBridge对象。并且这个对象是赋值给window对象，这里window对象可以理解为webview。
    2. 所以说我们后面在OC环境中如果要调用js方法，就可以通过window.WebViewJavascriptBridge在加上具体方法来调用。
    3. WebViewJavascriptBridge对象中有javascript环境注入的提供给OC调用的方法registerHandler，javascript调用OC环境方法的callHandler。
    4. _fetchQueue这个方法的作用就是把javascript环境的方法序列化成JSON字符串，然后传入OC环境再转换。
    5. _handleMessageFromObjC就是处理OC发给javascript环境的方法。
        
    在这个文件中也初始化了一个iframe实现webview的url跳转功能，从而激发webview代理方法的调用。
     */

        
    //如果已经初始化了，则返回。
	if (window.WebViewJavascriptBridge) {
		return;
	}

	if (!window.onerror) {
		window.onerror = function(msg, url, line) {
			console.log("WebViewJavascriptBridge: ERROR:" + msg + "@" + url + ":" + line);
		}
	}
        
    //初始化桥接对象，OC可以通过WebViewJavascriptBridge来调用JS里面的各种方法。
	window.WebViewJavascriptBridge = {
		registerHandler: registerHandler,
		callHandler: callHandler,
		disableJavscriptAlertBoxSafetyTimeout: disableJavscriptAlertBoxSafetyTimeout,
		_fetchQueue: _fetchQueue,
		_handleMessageFromObjC: _handleMessageFromObjC
	};
    //初始化一些属性。
	var messagingIframe;
    //用于存储消息列表
	var sendMessageQueue = [];
    //用于存储消息
	var messageHandlers = {};
    //通过下面两个协议组合来确定是否是特定的消息，然后拦击。
	var CUSTOM_PROTOCOL_SCHEME = 'https';
	var QUEUE_HAS_MESSAGE = '__wvjb_queue_message__';
    //oc调用js的回调
	var responseCallbacks = {};
    //消息对应的id
	var uniqueId = 1;
    //是否设置消息超时
	var dispatchMessagesWithTimeoutSafety = true;
    //web端注册一个消息方法
	function registerHandler(handlerName, handler) {
		messageHandlers[handlerName] = handler;
	}
	
	function callHandler(handlerName, data, responseCallback) {
		if (arguments.length == 2 && typeof data == 'function') {
			responseCallback = data;
			data = null;
		}
		_doSend({ handlerName:handlerName, data:data }, responseCallback);
	}
	function disableJavscriptAlertBoxSafetyTimeout() {
		dispatchMessagesWithTimeoutSafety = false;
	}
        
    //把消息从JS发送到OC，执行具体的发送操作。
	function _doSend(message, responseCallback) {
		if (responseCallback) {
			var callbackId = 'cb_'+(uniqueId++)+'_'+new Date().getTime();
            //存储消息的回调ID
			responseCallbacks[callbackId] = responseCallback;
            //把消息对应的回调ID和消息一起发送，以供消息返回以后使用。
			message['callbackId'] = callbackId;
		}
        //把消息放入消息列表
		sendMessageQueue.push(message);
        //下面这句话会出发JS对OC的调用
        //让webview执行跳转操作，从而可以在
        //webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler 中拦截到JS发给OC的消息
		messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE;
	}
    //把消息转换成JSON字符串返回
	function _fetchQueue() {
		var messageQueueString = JSON.stringify(sendMessageQueue);
		sendMessageQueue = [];
		return messageQueueString;
	}
    //处理从OC返回的消息。
	function _dispatchMessageFromObjC(messageJSON) {
		if (dispatchMessagesWithTimeoutSafety) {
			setTimeout(_doDispatchMessageFromObjC);
		} else {
			 _doDispatchMessageFromObjC();
		}
		
		function _doDispatchMessageFromObjC() {
			var message = JSON.parse(messageJSON);
			var messageHandler;
			var responseCallback;
            //回调
			if (message.responseId) {
				responseCallback = responseCallbacks[message.responseId];
				if (!responseCallback) {
					return;
				}
				responseCallback(message.responseData);
				delete responseCallbacks[message.responseId];
			} else {//主动调用
				if (message.callbackId) {//有 callbackId 说明OC传入了回调
					var callbackResponseId = message.callbackId;
					responseCallback = function(responseData) {
						_doSend({ handlerName:message.handlerName, responseId:callbackResponseId, responseData:responseData });
					};
				}
                //获取JS注册的函数
				var handler = messageHandlers[message.handlerName];
				if (!handler) {
					console.log("WebViewJavascriptBridge: WARNING: no handler for message from ObjC:", message);
				} else {
                    //调用JS中的对应函数处理
					handler(message.data, responseCallback);
				}
			}
		}
	}
    //OC调用JS的入口方法
	function _handleMessageFromObjC(messageJSON) {
        _dispatchMessageFromObjC(messageJSON);
	}

	messagingIframe = document.createElement('iframe');
	messagingIframe.style.display = 'none';
	messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE;
	document.documentElement.appendChild(messagingIframe);
        
    //注册_disableJavascriptAlertBoxSafetyTimeout方法，让OC可以关闭回调超时，默认是开启的。
	registerHandler("_disableJavascriptAlertBoxSafetyTimeout", disableJavscriptAlertBoxSafetyTimeout);
    //执行_callWVJBCallbacks方法
	setTimeout(_callWVJBCallbacks, 0);
        
    //初始化WEB中注册的方法。这个方法会把WEB中的hander注册到bridge中。
    //下面的代码其实就是执行WEB中的callback函数。
	function _callWVJBCallbacks() {
		var callbacks = window.WVJBCallbacks;
		delete window.WVJBCallbacks;
		for (var i=0; i<callbacks.length; i++) {
			callbacks[i](WebViewJavascriptBridge);
		}
	}
})();
	); // END preprocessorJSCode

	#undef __wvjb_js_func__
	return preprocessorJSCode;
};
