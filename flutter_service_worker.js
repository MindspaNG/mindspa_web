'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/assets/fonts/Roboto/Roboto-Regular.ttf": "f36638c2135b71e5a623dca52b611173",
"assets/assets/images/png/Mind-Spa-Logo-Green.png": "9d0bf36d2fa8207bebc4631356ea06c3",
"assets/assets/images/png/Frame%2520665.png": "16cc387e567f9c65e1e535886cae159e",
"assets/assets/images/png/Ellipse%252077.png": "956c4dc8ab1639984ad082a207f5e8ef",
"assets/assets/images/png/facebook_logo.png": "5fe9b9339f28e66c7d0c8f71fec41f9c",
"assets/assets/images/png/Group%25201028.png": "cebf432d09554958085a059aa8bbf20b",
"assets/assets/images/png/Frame%2520660.png": "b86f4c4b23df492a9c49e577ec83ed45",
"assets/assets/images/png/Group%2520667.png": "41244af2fdc4730864a70c2a36075626",
"assets/assets/images/png/instagram%25202.png": "dea3da568346fa804ea8561fae756000",
"assets/assets/images/png/facebook.png": "43a1bfeffcaddeab90becfd5dbc29a27",
"assets/assets/images/png/mind-spa_logo_green_with_white_backgound.png": "d156d34caf14ed72529404a5e0f946a5",
"assets/assets/images/png/Group%2520mobile%25201.png": "b0a2a11414d31b6afb90627a32d03399",
"assets/assets/images/png/Ellipse%252078.png": "440eef475ed453f93457709060bc36c8",
"assets/assets/images/png/Group%2520mobile%25203.png": "d540baffdf6f1006a1302eb9ec75bd79",
"assets/assets/images/png/Frame%2520662.png": "816e67c94a0d05cbff8b891d0e5f21bf",
"assets/assets/images/png/Group%25201029%2520(1).png": "09053618a784fb75014e0e8043603d59",
"assets/assets/images/png/instagram.png": "77a75a5acc7b7a91a54b2f6e27b0bba7",
"assets/assets/images/png/Group%2520mobile%25202.png": "a52607ae3ef259de9b33eaa1c58b0e88",
"assets/assets/images/svg/Frame%2520660.svg": "3d5b855b0b07a1e5397c8390b07069bb",
"assets/assets/images/svg/Group%2520667.svg": "e7b3dbf00da3a8c58b81867903944943",
"assets/assets/images/svg/Ellipse%252079.svg": "4a322a11fe6476715f2a04e0fc543ac9",
"assets/assets/images/svg/Ellipse%252077.svg": "5c450b926a739ccb4b10372d78b4b1ce",
"assets/assets/images/svg/Ellipse%252078.svg": "28e52bb9f82c98bf886114382e15d592",
"assets/assets/images/svg/Group%2520667%2520(1).svg": "29024a8226b513ee4a160ff0b278f148",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/AssetManifest.json": "d6c984fbcb4f64b44689956a10b1ac41",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "f013c85b34e57130d968e52f19c61323",
"assets/FontManifest.json": "23e0c41e876f69c9d38103ace30f69ab",
"manifest.json": "3a5ce9e105be1aa9159f7dffed67838c",
"index.html": "1d113c7dd60194efbe7c994ce4dec48e",
"/": "1d113c7dd60194efbe7c994ce4dec48e",
"main.dart.js": "ce92082984c283fb5133b0a2a8e6c56a",
"version.json": "26e39f2081dce5125e953a6afe8f95e1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
