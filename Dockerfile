# ── SB Digital Advertising — staticka stranica na nginxu ───────────
FROM nginx:1.27-alpine

# nginx konfiguracija
COPY nginx.conf            /etc/nginx/conf.d/default.conf
COPY security-headers.conf /etc/nginx/snippets/security-headers.conf

# Sadrzaj stranice — kopira se samo ono sto se stvarno referencira,
# pa neiskoristeni asseti iz repoa ne zavrsavaju u imageu.
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

COPY index.html o-nama.html usluge.html kontakt.html \
     privatnost.html kalkulator.html 404.html ./
COPY robots.txt sitemap.xml ./
COPY hero-campaign.jpg ./
COPY logo/2.png ./logo/2.png

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/healthz >/dev/null 2>&1 || exit 1
