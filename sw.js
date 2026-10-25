const CACHE='mat-pilot-shell-v2';
const SHELL=['assets/css/style.css','assets/js/app.js','manifest.webmanifest','assets/icons/icon-192.svg','assets/icons/icon-512.svg'];
self.addEventListener('install',event=>event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(SHELL))));
self.addEventListener('activate',event=>event.waitUntil(self.clients.claim()));
self.addEventListener('fetch',event=>{if(event.request.method!=='GET')return;const url=new URL(event.request.url);if(url.origin!==location.origin||!SHELL.some(path=>url.pathname.endsWith(path)))return;event.respondWith(caches.match(event.request).then(cached=>cached||fetch(event.request)));});
