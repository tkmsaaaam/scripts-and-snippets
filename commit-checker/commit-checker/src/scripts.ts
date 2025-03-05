chrome.runtime.onMessage.addListener((request, _, sendResponse): void => {
	if (request.message === 'getTodaysCommit') {
		console.log('getTodaysCommit');
		const today = new Date().toISOString().split('T')[0];
		const t = document.querySelector(`td[data-date="${today}"]`);
		if (!t) {
			sendResponse(0);
			return;
		}
		sendResponse(Number(t.getAttribute('data-level')));
	}
});
