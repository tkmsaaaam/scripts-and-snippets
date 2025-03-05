(() => {
	document.getElementById('get')?.addEventListener('click', e => {
		e.preventDefault();
		chrome.tabs.query(
			{ active: true, lastFocusedWindow: true },
			(tabs: chrome.tabs.Tab[]): void => {
				if (tabs.length < 1) return;
				if (!tabs[0].id) return;
				console.log('getTodaysCommit');
				chrome.tabs.sendMessage(
					tabs[0].id,
					{ message: 'getTodaysCommit' },
					(response: number): void => {
						let html = '';
						if (response === 0) {
							html = '<p>No commit today</p>';
						} else {
							html = `<p>Commit count: ${response}</p>`;
						}
						document
							.getElementById('results')
							?.insertAdjacentHTML('afterbegin', html);
					},
				);
			},
		);
	});
})();
