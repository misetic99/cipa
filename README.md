# SB Digital Advertising — Web stranica

Statička web stranica za **SB Digital Advertising**, agenciju za digitalno oglašavanje iz Ljubuškog, BiH.

## Stranice

| Datoteka | Opis |
|----------|------|
| `main.html` | Početna stranica (hero, o nama, usluge, kontakt forma, mapa) |
| `o-nama.html` | O nama — misija, vrijednosti, tim |
| `usluge.html` | Pregled usluga (social media, Google Ads, web dizajn, brendiranje) |
| `kalkulator.html` | Interaktivni kalkulator cijena oglašavanja — **isključen** iz navigacije i sitemap-a (`noindex`), cijena se sada traži putem "Zatražite ponudu". Datoteka je zadržana za eventualno ponovno uključivanje. |
| `kontakt.html` | Kontakt forma + mapa lokacije |
| `privatnost.html` | Politika privatnosti (GDPR) |
| `404.html` | Stranica za nepostojeće URL-ove |

## Tehnologije

- Čisti HTML, CSS, JavaScript — bez frameworka ili builda
- Formspree za slanje kontakt forme
- Google Maps (embed) za prikaz lokacije
- Responzivan dizajn (mobile-first)

## Zaštita

- Honeypot spam zaštita na kontakt formama
- Blokiranje desnog klika, drag-and-drop slika, Ctrl+U/S/P
- `rel="noopener"` na svim vanjskim linkovima
- Politika privatnosti za GDPR usklađenost

## Pokretanje

Otvoriti `main.html` u pregledniku. Nema potrebe za serverom ni instalacijom.

## Prije produkcije

- [ ] Odabrati domenu i postaviti hosting
- [ ] Zamijeniti `href="#"` social linkove pravim URL-ovima (Instagram, LinkedIn)
- [ ] Ažurirati `og:image`, `og:url` i `canonical` na apsolutne URL-ove
- [ ] Ažurirati `sitemap.xml` i `robots.txt` s punom domenom
- [ ] Popuniti `url` u JSON-LD structured data (main.html)
- [ ] Obrisati staru sliku (`5-ORL-004102-DB_Campaign...jpg`)

## Autor

Dizajn i razvoj: [ITASEL](https://www.itasel.org)
Klijent: SB Digital Advertising, Ljubuški, BiH
