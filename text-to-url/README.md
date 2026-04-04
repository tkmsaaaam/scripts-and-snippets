# 📝 URL-Memo

A minimalist, serverless web application that stores long text directly within the URL using Gzip compression. No database, no backend—just a URL.

## ✨ Features

- **URL-Based Storage**: Your text is compressed and stored in the URL query parameters.
- **Real-time Updates**: The URL updates instantly as you type.
- **High Compression**: Uses the browser-native `CompressionStream` (Gzip) to keep URLs as short as possible.
- **Mobile Friendly**: Responsive design with a "Copy URL" button for easy sharing on smartphones.
- **Privacy First**: Since there is no server-side storage, your data never leaves your browser (except when you share the link).
- **Preserves Formatting**: Keeps all line breaks and white spaces.

## 🛠️ How to Use

1. **Type or Paste**: Enter your long text into the editor.
2. **Monitor Size**: Check the live character count and URL length indicators.
   - _Note: While modern browsers support long URLs, staying under 2,000 characters ensures compatibility with most apps and social media platforms._
3. **Copy & Share**: Click "Copy URL" and send it to yourself or others.
4. **Restore**: Simply open the generated link to see your original text instantly.

## 🔧 Technical Details

This project uses modern Web APIs:

- **`CompressionStream` / `DecompressionStream`**: For Gzip compression.
- **`Base64URL` Encoding**: To ensure the compressed binary data is safe for URL transmission.
- **`history.replaceState`**: To update the browser address bar without reloading the page.

## 📦 Installation & Deployment

Since this is a single-file application, deployment is easy:

1. Create a new repository on GitHub named `url-memo`.
2. Upload `index.html`.
3. Enable **GitHub Pages** in the repository settings (Settings > Pages).
4. Your app is live!
