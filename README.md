## 目的:
验证: iOS 使用tel://phone 可以不弹出系统弹框

## 结论:
不行, iOS 10.3以上所有对 tel://phone 都需要用户确认框.

[官网说明: RN-iOSSDK-10.3](https://developer.apple.com/library/content/releasenotes/General/RN-iOSSDK-10.3/)
>openURL
>
>When a third party application invokes openURL: on a tel://, facetime://, or facetime-audio:// URL, iOS displays a prompt and requires user confirmation before dialing.


## 验证:

1. 使用`UIApplication.shared.openURL(xxx)`

	1.1 使用`shared.openURL("tel://135....")`	
	
	1.2 使用`shared.open("tel://135....", options: [:], completionHandler: nil)`
	
2. 使用`UIApplication.shared.open(url, options:, completionHandler:)

	2.1 使用`shared.openURL("telprompt://135....")`
	
	2.2 使用`shared.open("telprompt://135....", options: [:], completionHandler: nil)`
3. 使用webView.loadRequest

	```
	let request = URLRequest(url: callURL)
	let webView = UIWebView()
	self.view.addSubview(webView)
	webView.loadRequest(request)
	```

*Demo下载地址:[https://github.com/antwork/TelDemo](https://github.com/antwork/TelDemo)*
