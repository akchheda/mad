'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a302ce41e0c3b243908ad00dc7ae6cb5",
"assets/AssetManifest.bin.json": "a4174d0d2a6b413ea0c5482ed1c3954e",
"assets/AssetManifest.json": "ef76200dd6f4d919cfb165fb9b15fbc9",
"assets/assets/biryani.jpg": "a010d6c6fb9edadae0a820d6506c6417",
"assets/assets/breakfast.jpg": "52330cf97a99360de29c0c758b96d153",
"assets/assets/butter_chicken.jpg": "8721eca72b20184f31456cb6e71292de",
"assets/assets/cheeseburger.jpeg": "cb9098ae19c315fe856f30b0ee90955a",
"assets/assets/Chicken-Biryani-Recipe.jpg": "da2592e0d25f079cbf9aedf436cabf6f",
"assets/assets/chinese.jpg": "439549dddebdc150e933202066bf6eed",
"assets/assets/chole_bhature.jpg": "42e56f6bbc3d198fc710317be8da283e",
"assets/assets/croissant.jpg": "a73229942f1808a0c44685a886c97955",
"assets/assets/desserts.jpg": "99d0d9f8c241b631dda5941723157e27",
"assets/assets/dinner.jpg": "65dcea1cc0c4e674813ef4d3cd59dea7",
"assets/assets/dumplings.jpg": "e09c8d11ad2d2e8465325c5474912862",
"assets/assets/enchiladas.jpg": "0cbd7907d73009681dfa4720fe5ea508",
"assets/assets/falafel.jpg": "98220cba9d5348f23fdfd54d2b626b54",
"assets/assets/fried_rice.jpg": "cfd320863cde8a1063ebc27fb208e4cf",
"assets/assets/guacamole.jpg": "8105055e822700a6926409b27e7bc33a",
"assets/assets/hot_and_sour_soup.jpg": "cf1005d96305d262ef010fdc13a52765",
"assets/assets/image1.png": "49c1ffb70755233def8aefb4ba91eddc",
"assets/assets/image2.png": "8bdf170407e2e3f149609877affc3a26",
"assets/assets/image3.png": "2bc83489383c4984dc2a67e6f1444928",
"assets/assets/indian.jpg": "95c5bc24173a52509c53bc6b1bbb3228",
"assets/assets/italian.jpg": "33b53588a6bbf93c888b504730d2dee0",
"assets/assets/kimchi_fried_rice.jpg": "d12843a55ac4cc34a04d1a6c8623093f",
"assets/assets/kung_pao_chicken.jpg": "a622ab4c940412480078b5b50f17f390",
"assets/assets/lasagna.jpg": "6570ff98b3f88c80f45fa12cd48c26b0",
"assets/assets/lunch.jpg": "5e942be70c3618aa72875fd58d9bdae0",
"assets/assets/mexican.jpg": "98227c34c9ba90fabf91f64044575f0c",
"assets/assets/pad_thai.jpg": "10fa250ecf388f9dc96eef41a012efdc",
"assets/assets/paella.jpg": "10eb2009fb6fb7178f3b4134930d568d",
"assets/assets/pasta.jpg": "696dce1753b7631fa5a9aa70136ba8ef",
"assets/assets/pizza.jpg": "f69a36b6ec9eabcc873a47278f64bf59",
"assets/assets/risotto.jpg": "b2671bafdba7bf0e5fffebc638f1b07e",
"assets/assets/salad.jpg": "194d421abc653adc2986e7ba98faccab",
"assets/assets/samosas.jpg": "41c570d1f9f432aa157775437dd84b81",
"assets/assets/snacks.jpg": "92d6f922484e5aab4c800c511f6b44b0",
"assets/assets/spaghetti_carbonara.jpg": "29630a2e44e65bd7f704cc88cb5a67a7",
"assets/assets/sushi.jpg": "33bcfa6118a10152b3b08b9434c02006",
"assets/assets/sweet_sour_pork.jpg": "15177fffd926a9bf8ad8e030d7c0ff61",
"assets/assets/tacos.jpg": "04d15901c58dff630cdbf8848a1b2d5c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "719e4aa3a4a3d7d9dac469885de8dbad",
"assets/NOTICES": "117cd3f2e933d96eb7926c35c2270717",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"cors.json": "9c2c7b1fcfc5258cb5f5be78674670cb",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "ba6d9a0953269c990214eb3d87f3d1be",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "90abe234ac1e815ebe2ca0915df85a12",
"/": "90abe234ac1e815ebe2ca0915df85a12",
"main.dart.js": "8d315567ec4368a23638bc3d6d0740d1",
"manifest.json": "b7dceffa923f492c8a77095e414fe152",
"version.json": "5b806985bbe8ee72d880c09eb63eb5d3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
