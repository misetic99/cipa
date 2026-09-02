# SB Digital Advertising — Web stranica

Statička web stranica za **SB Digital Advertising**, agenciju za digitalno oglašavanje iz Ljubuškog, BiH.

Produkcija: <https://sbdigitaladvertising.com>

## Stranice

| Datoteka | URL | Opis |
|----------|-----|------|
| `index.html` | `/` | Početna stranica (hero, o nama, usluge, kontakt forma, mapa) |
| `o-nama.html` | `/o-nama` | O nama — misija, vrijednosti, tim |
| `usluge.html` | `/usluge` | Pregled usluga (social media, Google Ads, web dizajn, brendiranje) |
| `kontakt.html` | `/kontakt` | Kontakt forma + mapa lokacije |
| `privatnost.html` | `/privatnost` | Politika privatnosti (GDPR) |
| `kalkulator.html` | `/kalkulator` | Kalkulator cijena — **isključen** iz navigacije i sitemap-a (`noindex`, `Disallow`). Zadržan za eventualno ponovno uključivanje. |
| `404.html` | — | Stranica za nepostojeće URL-ove (`error_page 404`) |

URL-ovi su čisti (bez `.html`). Nginx to rješava kroz `try_files $uri $uri.html`,
a stari `.html` URL-ovi imaju 301 redirect na čistu verziju.

## Tehnologije

- Čisti HTML, CSS, JavaScript — bez frameworka ili builda
- Formspree za slanje kontakt forme (AJAX)
- Google Maps (embed) za prikaz lokacije
- Responzivan dizajn (mobile-first)

## Lokalni razvoj

Stranica je statička, ali zbog čistih URL-ova treba lokalni server:

```bash
python -m http.server 8000
# pa otvoriti http://localhost:8000/index.html
```

Za vjernu simulaciju produkcije (čisti URL-ovi, redirecti, headeri) koristi Docker:

```bash
docker compose up --build
# http://localhost
```

## Deploy (VPS + Docker)

Image se builda automatski na git tag i objavljuje na GitHub Container Registry.

**1. Objavi novu verziju:**

```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Action (`.github/workflows/docker-publish.yml`) buildá i pushá
`ghcr.io/misetic99/cipa:v1.0.0` i `:latest`.

**2. Na serveru:**

```bash
docker compose pull
docker compose up -d
```

Ili build direktno na serveru bez registryja: `docker compose up -d --build`.

### Konfiguracija

| Datoteka | Namjena |
|----------|---------|
| `Dockerfile` | `nginx:1.27-alpine` + samo datoteke koje se stvarno koriste |
| `nginx.conf` | Ide u `/etc/nginx/conf.d/default.conf` — čisti URL-ovi, 301 redirecti, gzip, cache, 404 |
| `security-headers.conf` | Ide u `/etc/nginx/snippets/` — CSP, HSTS, X-Frame-Options itd. |
| `docker-compose.yml` | Port `80:80`, `restart: unless-stopped` |

Container sluša na portu 80 i mapiran je na host port 80 (stranica je sama na
serveru). Ako ispred dođe reverse proxy (Traefik/Caddy/nginx na hostu),
promijeni mapiranje u `8080:80` — `nginx.conf` čita `X-Forwarded-Proto` pa
`www → apex` redirect radi ispravno i iza proxyja.

Health check: `GET /healthz` → `200 ok`.

## Zaštita

- Honeypot spam zaštita na kontakt formama
- Blokiranje desnog klika, drag-and-drop slika, Ctrl+U/S/P
- `rel="noopener"` na svim vanjskim linkovima
- Sigurnosni headeri: CSP, HSTS, X-Frame-Options, X-Content-Type-Options,
  Referrer-Policy, Permissions-Policy
- Politika privatnosti za GDPR usklađenost

## Preostalo prije produkcije

- [ ] Zamijeniti `href="#"` Instagram linkove pravim URL-om (LinkedIn je uklonjen — radi se samo Instagram)
- [ ] Postaviti DNS `A` zapis za `sbdigitaladvertising.com` i `www` na IP servera
- [ ] Postaviti SSL certifikat (Let's Encrypt) — HSTS header je već uključen
- [ ] Obrisati neiskorištene assete iz repoa (`5-ORL-004102-DB_Campaign...jpg`, `logo/1.png`, `logo/3.png`, `logo/2.svg`) — u Docker image ionako ne ulaze

## Autor

Dizajn i razvoj: [ITASEL](https://www.itasel.org)
Klijent: SB Digital Advertising, Ljubuški, BiH
