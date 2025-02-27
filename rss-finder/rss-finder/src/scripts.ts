(() => {
	chrome.runtime.onMessage.addListener((request, _, sendResponse): void => {
		if (request.message === 'getRssUrl') {
			const urlList = Array.from(document.getElementsByTagName('link'))
				.filter(
					element =>
						element.type == 'application/rss+xml' ||
						element.type == 'application/atom+xml',
				)
				.map(element => element.href);
			sendResponse(urlList);
		}
	});
})();
