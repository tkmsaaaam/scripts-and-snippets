(() => {
	document.getElementById('get')?.addEventListener('click', e => {
		e.preventDefault();
		chrome.tabs.query(
			{ active: true, lastFocusedWindow: true },
			(tabs: chrome.tabs.Tab[]): void => {
        if (tabs.length < 1) return;
				if (!tabs[0].id) return;
				chrome.tabs.sendMessage(
					tabs[0].id,
					{ message: 'getRssUrl' },
					(responseList: string[]): void => {
						let html = '';
						responseList.forEach(res => {
							html += `<button id="sub-${res}">Copy(subscribe)</button><button id="url-${res}">Copy(URL)</button><a>/feed subscribe ${res}</a><br>`;
						});
						document
							.getElementById('results')
							?.insertAdjacentHTML('afterbegin', html);
						responseList.forEach(res => {
							document
								.getElementById('sub-' + res)
								?.addEventListener('click', async e => {
									e.preventDefault();
									await navigator.clipboard.writeText(`/feed subscribe ${res}`);
								});
							document
								.getElementById('url-' + res)
								?.addEventListener('click', async e => {
									e.preventDefault();
									await navigator.clipboard.writeText(`${res}`);
								});
						});
					}
				);
			}
		);
	});
})();
