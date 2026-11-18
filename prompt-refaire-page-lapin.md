# Prompt à donner à une IA : refaire la page « Nouvel onglet · Lapin »

> **Emplacement du projet** : tout est regroupé dans le dossier `nouvel-onglet-lapin\` de `C:\Users\Eleve\Documents\Projet par défaut\` — page (`nouvel-onglet-lapin.html`), serveur (`serveur_lapin.py`), scripts de lancement/autostart, cette spec et `a-savoir-brixhub.txt`. Les autres éléments de `Projet par défaut` (scanner souris, mullvad…) n'appartiennent pas à ce projet.

Copie tout ce qui suit dans une IA (Claude, ChatGPT, etc.). Le résultat attendu est une page de nouvel onglet Firefox, locale, mignonne et fonctionnelle.

---

## Rôle

Tu es développeur front-end. Tu vas reproduire **à l'identique** une page de nouvel onglet Firefox sur le thème « lapin », en français, servie en local. Tu écris du HTML/CSS/JS **sans framework, sans build, sans CDN** : un seul fichier `.html` autonome + quelques scripts Python/BAT pour le lancement.

## Mission

Créer une page de nouvel onglet qui remplace celle de Firefox, avec :

- une horloge, une date et une salutation en **heure européenne (Europe/Paris)**, avec options (secondes, format 12/24 h, deuxième fuseau) ;
- une barre de recherche dont le moteur par défaut est **Google**, avec des moteurs secondaires appelés par `@`, et un **historique de recherche local** (rappel par `↑`, suppression ligne par ligne) ;
- des raccourcis **personnalisables** (ajouter, modifier, supprimer, réordonner, réinitialiser) ;
- un **lapin blanc tout rond en SVG** (grandes oreilles roses) dont le visage suit la souris, qui saute quand on clique dessus, et qu'on peut **nourrir** avec la carotte posée à côté ;
- un thème **jour / nuit** (automatique selon le soleil ou une plage horaire réglable, ou forcé) avec **4 palettes pastel**, et un **ciel dynamique** qui suit les phases du soleil (aube, lever, jour, heure dorée, coucher, crépuscule, nuit) **et la météo** (clair, nuageux, pluie, neige, brouillard, orage) ;
- la **météo + prévisions 3 jours + prévisions horaires + risque de pluie dans l'heure**, avec **géolocalisation** (Open-Meteo, sans clé API) ;
- un **pense-bête multi-pages** (cases à cocher, export `.txt`/`.md`), un **calcul rapide**, une **calculatrice** (mémoire, mode scientifique, conversions d'unités), un **minuteur + Pomodoro**, un **traducteur Google**, une **aide** (`?`) et un **widget Paramètres** (`⚙️`) ;
- des **options de confort** (animations, contraste, taille du texte, mode calme) et un **export/import/réinitialisation des réglages** ;
- **plusieurs widgets ouverts en même temps**, empilés en haut à droite sans se chevaucher, avec **mémoire d'ouverture**, **repli** et **« tout fermer »** ;
- une **citation / un mot du jour**, et quelques **easter eggs** cachés.

> **Discord** : affiché comme BrixHub, dans un grand cadre ouvert par l'utilisateur uniquement (bouton `🎮` ou touche `D`) — jamais au chargement de la page, rien n'est stocké, pas de connexion automatique.

La page doit être **servie par un petit serveur HTTP local** (obligatoire : les extensions Firefox ne peuvent plus ouvrir un `file://`).

## Livrables

1. `nouvel-onglet-lapin.html` — toute la page (HTML + CSS + SVG + JS).
2. `serveur_lapin.py` — serveur HTTP local sur `127.0.0.1:8765`.
3. `lancer_page_lapin.bat` — démarre le serveur en caché et ouvre la page.
4. `arreter_page_lapin.bat` — arrête le serveur.
5. `installer_demarrage_auto.bat` + `.ps1` — raccourci dans le dossier Démarrage de Windows.
6. `desinstaller_demarrage_auto.bat` + `.ps1` — retire ce raccourci.

## Règles absolues

- **Aucune dépendance externe** : pas de React, pas de Tailwind, pas de Google Fonts, pas d'image distante. Le lapin est un SVG écrit à la main dans le HTML.
- **Tout en français** (textes, messages, commentaires de code).
- Le HTML doit rester **un seul fichier** : CSS dans `<style>`, JS dans `<script>`, SVG inline.
- Code JS en **IIFE** (`(function(){ "use strict"; ... })();`), style ES5 (`var`, `function`), pas de modules.
- **Aucune erreur console** ne doit apparaître.
- La page doit fonctionner **hors ligne** pour tout ce qui est local (seule la météo a besoin d'Internet).
- Ne jamais promettre l'accès aux marque-pages ou aux onglets Firefox : c'est **interdit** à une page web (voir plus bas).

## Direction artistique (à respecter scrupuleusement)

Palette « crème / rose / carotte », douce et enfantine :

```
--ink:        #4a3426   (texte principal, brun)
--ink-soft:   #7d6252   (texte secondaire)
--pink:       #ffb3c7   (rose lapin)
--carrot:     #ff9f43   (orange carotte)
fond de page: #fdf3e7   (crème)
```

- Ciel : un dégradé piloté par des **variables CSS** (`--ciel-haut`, `--ciel-milieu`, `--ciel-bas`, `--ciel-lueur-a`, `--ciel-lueur-b`) sur `body`, avec un **état `data-ciel`** :
  - `jour` : reprend les variables de la palette (`#eaf7ff` → `#fdf3e7` → `#f8e6d4` en crème) ;
  - `aube` : `#5d6ea8` → `#b98ab0` → `#f6c3a4` ; `lever` : `#8ea8d8` → `#f0b6b0` → `#ffd9a8` ;
  - `dore` : `#a8c8e8` → `#ffd9a8` → `#ffb887` ; `coucher` : `#7d6fae` → `#e79a9a` → `#ffb27a` ;
  - `crepuscule` : `#2f3768` → `#5a4a7d` → `#a06a86` ; `nuit` : `#131a3a` → `#1d2247` → `#33294a` (variantes par palette).
- Météo : un **état `data-meteo`** (`clair`, `nuageux`, `couvert`, `pluie`, `neige`, `brouillard`, `orage`) ajoute un voile de couleur (`.sky::before`) et une animation de précipitations (`.sky::after` : gouttes de pluie courtes et inclinées, flocons, brume, éclairs). Le soleil/la lune pâlit ou se floute selon le temps.
- Collines vertes en bas (`#cdeecb` → `#b8e2b6`), version bleu-vert la nuit, réchauffées à l'heure dorée et au coucher.
- Typographie : `"Segoe UI Variable Display", "Segoe UI", Nunito, system-ui, -apple-system, sans-serif`.
- Formes : coins très arrondis (recherche = pilule `border-radius: 999px`), cartes en verre dépoli (`backdrop-filter: blur(16px)`, fond `rgba(255,255,255,.55)`), ombres douces `0 10px 30px rgba(120,80,60,.12)`.
- Animations lentes et douces (0,2 s à 1 s), et **respect de `prefers-reduced-motion`** (tout réduire à ~0 ms).
- Le dock de réglages est en **haut à droite** (pas en bas), sous forme de pilule.

## Structure de la page

De l'arrière vers l'avant (z-index) :

1. **Décor fixe** : `.sky` (dégradé piloté par `data-ciel` + brume d'horizon, avec `.sky::before` pour la teinte météo et `.sky::after` pour la pluie/neige/brume/éclairs), `.stars` (étoiles animées, visibles à l'aube, au crépuscule et la nuit), `.orb` (soleil le jour / lune la nuit, qui descend vers l'horizon au lever et au coucher), **6 `.cloud` qui dérivent** (4 formes SVG distinctes en `mask-image` — `--nuage-1` duveteuse à 4 bosses, `--nuage-2` longue à 5 bosses, `--nuage-3` petite et dodue à 3 bosses, `--nuage-4` effilochée à double étage — plus 2 nuages en miroir via `scale(-x, x)` ; tailles, vitesses et hauteurs variées ; opacité et teinte selon `data-meteo` : la couleur passe par `background-color`, la forme reste fixe), `.hills` (2 collines).
2. **Dock** en haut à droite : bouton météo (icône + température + ville), bouton traducteur `🌐`, bouton calculatrice `🧮`, bouton minuteur `⏱️`, bouton fond du ciel `🌗` (ouvre le petit panneau de choix), bouton pense-bête `📝` avec une pastille rose quand il y a du texte, bouton paramètres `⚙️` (ouvre le widget réglages). **BrixHub et Discord ne sont pas dans le dock** : ils vivent dans le **volet gauche** (puce suivante, voir 9 quinquies/9 sexies).
2 bis. **Volet gauche** (`.volet` + `.volet-zone`) : un volet vertical coulissant collé au bord gauche, presque caché (seule la patte `🐾` dépasse). Il **glisse quand le curseur touche le bord gauche** de l'écran (zone invisible de 10 px sur toute la hauteur, ouverture en CSS pur `:hover`, maintenue par `.volet:hover`/`.volet:focus-within`) ; la patte `🐾` est un bouton cliquable (tactile, classe `.ouvert`, refermé au clic extérieur). Il contient deux gros boutons empilés — BrixHub `🕵️` et Discord `🎮` — qui surlignés (fond carotte) quand leur cadre est ouvert.
3. **Zone `#widgets`** sous le dock (conteneur fixe en haut à droite, largeur ~360 px, `overflow-y: auto`) : formulaire météo + prévisions + heures + pluie, carte traducteur, carte calculatrice, carte minuteur/Pomodoro, carte notes, carte paramètres — toutes les cartes widgets ont la **même largeur (340 px)**, y compris la carte minuteur (`.timer-card`). Les widgets sont **empilés verticalement** et **plusieurs peuvent être ouverts en même temps** ; ils ne se ferment pas mutuellement. Une petite **barre `#widgetsBar`** (avec « Tout fermer ») apparaît quand au moins un widget est ouvert. Chaque widget a un bouton **repli/dépli** (`▾`/`▸`). La carte aide reste **centrée** sur la page.
4. **`<main>`** centré verticalement :
   - salutation : « Bonjour, **petit lapin** 🥕 » (le prénom est cliquable et modifiable) ;
   - horloge géante `HH:MM` (ex. `22:15`), avec `#clock2` pour un éventuel deuxième fuseau ;
   - date en toutes lettres (« Jeudi 12 novembre ») ;
   - barre de recherche avec loupe + palette de moteurs en dessous + historique ;
   - pastilles `@perplexity`, `@qwant`, `@startpage`, `@wiki`, `@brave` + une pastille `@…` qui ouvre la palette ;
   - **raccourcis générés dynamiquement** (6 par défaut : Google, YouTube, Wikipédia, GitHub, Twitch, Gmail) + une tuile pointillée « ✏️ Modifier » qui ouvre l'éditeur ;
   - une **citation du jour** (`#citation`, cliquable pour passer à la suivante).
5. **Lapin** : fixé à droite, grand SVG `viewBox="0 0 340 384"`. Sa **carotte est cliquable** (`#carotte`) pour le nourrir.
6. **Aucun pied de page** : pas de bandeau de raccourcis en bas de l'écran (il a été retiré). Les raccourcis sont rappelés dans l'aide `?`.

### Le lapin (SVG)

- Lapin blanc tout rond façon peluche (inspiré d'une image de référence) : **un seul gros corps-œuf assis au sol** (pas de pattes visibles), **deux grandes oreilles dressées** blanc dehors / rose vif dedans, visage minimal **deux yeux ronds marron avec reflet + petite bouche en « w »** (pas de nez, moustaches, cils ni dents). La carotte est **posée à côté sur le sol** (à gauche), légèrement devant le corps.
- Le lapin est **vivant** : flottement (`float`), **respiration** du corps (`.corps`, scale doux), **clignements** des yeux (`.eye`), **balancement + tressaillement aléatoire** des oreilles (`.ear` / `.flick`), bouche qui frétille (`.nose`), sparkles ✨ animés autour.
- Le **visage suit la souris** : écouter `pointermove`, convertir en coordonnées SVG (`svg.createSVGPoint()` + `getScreenCTM().inverse()`), puis translater le groupe `.face` (max ±9 px horizontal / ±6 px vertical, transition douce ; un `setTimeout` de secours relance si `requestAnimationFrame` ne tourne pas).
- Au clic sur le lapin : il **saute** (classe d'animation), des carottes/étincelles s'envolent, et un petit message apparaît.
- La **carotte est cliquable** : elle disparaît un instant, le lapin fait mine de la manger (`mange`), des carottes s'envolent et un toast s'affiche (« Miam ! » puis « rassasié » après 5 carottes).
- Tout le lapin (corps, oreilles, visage, carotte) est dans `.rabbit` : le réglage **« Cacher le lapin »** (`body.sans-lapin`) masque tout d'un coup.

## Fonctionnalités détaillées

### 1. Horloge, date, salutation — heure européenne

- Constante `FUSEAU = "Europe/Paris"`.
- L'horloge, la date et la salutation utilisent `Intl.DateTimeFormat` avec `timeZone: FUSEAU`, **jamais** `getHours()` (l'heure système peut être fausse).
- Salutation : 5 h–12 h « Bonjour », 12 h–18 h « Bon après-midi », 18 h–22 h « Bonsoir », sinon « Bonne nuit ».
- Mise à jour toutes les secondes.
- **Options mémorisées** dans `lapinHorloge` (`{secondes, format, fuseau2}`) et réglables dans l'aide :
  - afficher/masquer les **secondes** ;
  - format **12 h / 24 h** (`hour12` / `hourCycle: "h23"`) ;
  - **deuxième fuseau** (`#clock2`), ex. « Tokyo · 15:50 » (liste : Paris, Londres, New York, Montréal, Tokyo, Sydney, UTC).
- Écrire une fonction `decalageFuseau(ms)` qui renvoie le décalage en secondes entre Paris et UTC à cet instant, via `formatToParts` + `Date.UTC`. **Piège important** : arrondir avec `Math.floor(ms / 1000) * 1000` dans le calcul, sinon on obtient 3599 au lieu de 3600 à cause des millisecondes.
- Un **script inline placé tout au début du `<body>`** applique la classe `night`, la palette (`data-palette`), les états du ciel (`data-ciel`, `data-meteo`), le confort (`no-anim`, `contraste`) et la taille du texte avant l'affichage, pour éviter un flash blanc la nuit (même logique que le thème auto ci-dessous, en lisant `localStorage`).

### 2. Recherche et moteurs `@`

- Le formulaire ne recharge pas la page (`preventDefault`).
- Sans préfixe → **Google** : `https://www.google.com/search?q=<valeur encodée>`.
- Avec `@moteur` → recherche sur ce moteur, en retirant le préfixe.
- Tableau `MOTEURS` avec : `token`, `alias` (sans accents, minuscules), `nom`, `badge`, `couleur`, `home`, `url`. Moteurs : Perplexity, Qwant, Startpage, Wikipédia FR, Brave Search, Google, YouTube, GitHub, DuckDuckGo + deux entrées spéciales (voir plus bas).
- La saisie d'un alias doit être **insensible aux accents** (`normalize("NFD").replace(/[\u0300-\u036f]/g,"")`).
- **Palette** : dès que la valeur commence par `@`, afficher une liste filtrée sous la barre. Navigation `ArrowUp`/`ArrowDown`, `Enter` valide, `Escape` ferme, clic valide. `Tab` **complète** en `@token ` (sans envoyer).
- La palette se place **sous** la barre ; si la place manque, elle bascule **au-dessus** (classe `.up`) et sa hauteur max est calculée.
- Un clic sur une pastille remplit `@token ` et remet le focus dans le champ.
- **Marque-pages / onglets** : `@bookmarks` / `*` et `@tabs` / `%` ne peuvent **pas** fonctionner depuis une page web. Les afficher quand même, mais au clic afficher un message clair du type : « Les marque-pages ne sont pas accessibles depuis une page web. Utilise la barre d'adresse Firefox : Ctrl+L, puis *mot-clé. » Idem pour les onglets avec `%`.
- **Historique de recherche local** (`lapinRecherches`, 10 entrées max, les plus récentes d'abord) :
  - chaque recherche validée (Google, moteur `@`, URL) est ajoutée (doublons déplacés en tête) ;
  - quand le champ est **vide et a le focus**, ou sur `↑`/`↓`, la palette affiche l'historique (icône 🕘) au lieu des moteurs ;
  - un clic sur une entrée la remplit et referme la palette ; chaque ligne a une croix `✕` pour la supprimer ;
  - `Tab`/`Entrée` en mode historique choisit l'entrée sélectionnée.

### 3. Raccourcis personnalisables

- Les raccourcis sont **rendus dynamiquement** depuis `lapinRaccourcis` (tableau `{emoji, nom, url}`, 12 max).
- Défaut (`RACCOURCIS_DEFAUT`) : Google, YouTube, Wikipédia, GitHub, Twitch, Gmail, **BrixHub**.
- Migration douce : au premier chargement après mise à jour, si `lapinRaccourcisBrix` n'existe pas et que la liste enregistrée ne contient pas déjà BrixHub (et fait moins de 12 entrées), l'ajouter **à la fin** sans rien écraser, puis poser le drapeau. Ne jamais réinsérer un raccourci que l'utilisateur a supprimé ensuite.
- Une tuile pointillée « ✏️ Modifier » ouvre un **éditeur modal** (`#shortcutModal`) :
  - une ligne par raccourci avec champs **emoji / nom / adresse** ;
  - boutons **↑ / ↓** pour réordonner, **✕** pour supprimer, « Ajouter » pour créer ;
  - validation d'URL : ajout automatique de `https://` si absent, `mailto:` accepté, champ marqué `.invalide` en rouge si l'adresse est invalide ; les entrées invalides sont **ignorées** à l'enregistrement ;
  - bouton « Réinitialiser » (confirmation) qui remet les 7 défauts ;
  - « Terminé »/`✕`/clic extérieur/`Échap` enregistrent et referment.
- Sur mobile, ne plus masquer les raccourcis (ils restent visibles et passent à la ligne).

### 4. Fond du ciel (auto / jour / nuit / aube / crépuscule), palettes et plage horaire

Le bouton `🌗` du dock ouvre un **petit panneau** (`#themeCard`, empilé dans `#widgets` comme les autres cartes, repliable via ▾, mémorisé dans `lapinWidgets`) qui propose **5 modes** : `Auto 🌗`, `Jour ☀️`, `Nuit 🌙`, `Aube 🌅`, `Crépuscule 🌆`. Le mode choisi est mémorisé dans `localStorage` (`lapinTheme`), l'option active est marquée (fond carotte + `aria-pressed`), un toast confirme le choix. Le panneau se ferme avec `✕`, `Échap`, `🌗` ou « tout fermer ». Pas de cycle caché : on voit et on choisit.

**Deuxième rangée du panneau : « La météo du ciel : »** (`#meteoChoix`, mêmes pilules `.theme-choix`, surlignage via le même `majChoixGroupe()`) avec **8 choix** : `Auto 🌤️`, `Clair ☀️`, `Nuageux ☁️`, `Couvert 🌥️`, `Pluie 🌧️`, `Neige 🌨️`, `Brouillard 🌫️`, `Orage ⛈️`. Le choix est mémorisé dans `localStorage` (`lapinMeteoForcee`) et confirmé par un toast (« Météo du ciel : neige »). En `auto`, le fond suit la **vraie météo de la ville sélectionnée** ; un autre choix **force** la météo du fond : `appliquerCiel()` pose `data-meteo` sur la valeur forcée au lieu de `categorieCiel(code)`, donc le voile (`.sky::before`), les précipitations (`.sky::after` : pluie, flocons, brume, éclairs), les nuages et le soleil/lune se règlent dessus. **Le script anti-flash du début du `<body>` doit aussi lire `lapinMeteoForcee`** (valeur valide ≠ `auto` → pose `data-meteo` dessus), sinon le premier rendu contredit le panneau.

- `jour` : retire la classe `night` et force le ciel de jour. `nuit` : ajoute la classe `night` et force le ciel de nuit. `aube` / `crepuscule` : figent le ciel sur ces phases (avec la classe `night`, textes clairs). `auto` : tout suit le soleil.
- `auto` : la **phase du ciel** est calculée à partir du lever/coucher du soleil **de la ville météo**, mais uniquement si cette ville est bien au fuseau de Paris (comparer `cacheMeteo.decalage` à `decalageFuseau(Date.now())`) et si le jour du cache correspond au jour de Paris. Sinon, repli sur la **plage horaire réglable** (`lapinPlageNuit`, défaut `{debut: 7, fin: 20}`).
- La classe `night` (textes clairs) est active pendant `nuit`, `aube` et `crepuscule` (y compris en mode forcé `aube`/`crepuscule`) ; le jour, le lever, l'heure dorée et le coucher gardent les textes foncés, pour rester lisibles.
- La plage de nuit est réglable dans l'aide (deux champs « début » et « fin ») et lue aussi par le script anti-flash.
- Le `title` du bouton doit expliquer le mode et les horaires (« Fond du ciel : automatique — jour de 07:36 à 17:12 (soleil) — clique pour choisir »).
- La transition de fond doit être douce (~0,8 s).
- **Le script anti-flash du début du `<body>` doit connaître les 5 modes** : `aube`/`crepuscule` forcent `data-ciel` sur ces phases (et activent `night` via la règle « phase sombre »), sinon le premier rendu contredit le panneau.

**Ciel dynamique (phases du soleil + météo)** :

- `bornesSoleil()` renvoie `{lever, coucher}` : ceux de `soleilDuJour()` s'ils sont connus, sinon les heures de `lapinPlageNuit` converties en epoch pour le jour de Paris (minuit local via `Intl` + `decalageFuseau`).
- `phaseSoleil()` découpe la journée en fenêtres (M = 60 000 ms) :
  - `nuit` avant `lever − 75 min` ;
  - `aube` de `lever − 75` à `lever − 20` ; `lever` de `lever − 20` à `lever + 25` ;
  - `jour` de `lever + 25` à `coucher − 70` ;
  - `dore` de `coucher − 70` à `coucher − 20` ; `coucher` de `coucher − 20` à `coucher + 25` ;
  - `crepuscule` de `coucher + 25` à `coucher + 75` ; puis `nuit`.
- `categorieCiel(code)` : 0 → `clair` ; 1–2 → `nuageux` ; 3 → `couvert` ; 45/48 → `brouillard` ; 51–67 et 80–82 → `pluie` ; 71–77 et 85–86 → `neige` ; 95+ → `orage`.
- Le fond est **enrichi mais toujours pastel** : au dégradé de base s'ajoute une **brume d'horizon** (3e couche radiale en bas du ciel, `--ciel-horizon`, définie pour chaque phase et chaque palette — chaude le jour, violette le crépuscule, sombre la nuit) et le dégradé linéaire porte un **palier médian** (`--ciel-milieu` maintenu de 46 % à 64 %) pour un passage plus doux. Les collines ont aussi un palier médian (3 arrêts). Ne pas toucher à `.sky::before` (voile météo) ni `.sky::after` (précipitations).
- `appliquerCiel()` pose `document.body.dataset.ciel` et `dataset.meteo` (uniquement si la valeur change, pour éviter les recalculs de style). Elle est appelée par `appliquerTheme()` (donc chaque seconde via `tick()`), après chaque rafraîchissement météo et à chaque changement de thème.
- Le ciel n'utilise **que la météo de la ville sélectionnée** : `cacheMeteo.ville` doit être égal à `villeMeteo.ville` (et le script anti-flash compare `lapinMeteo.ville` à `lapinMeteoCache.ville`). Pendant un changement de ville, le ciel reste neutre (`clair`) au lieu d'afficher l'ancienne météo.
- Les palettes définissent les variables `--ciel-*` du jour et de la nuit (`body[data-ciel="nuit"][data-palette=…]`) ; les autres phases imposent leurs propres couleurs, tout en gardant la teinte de la palette la nuit.
- Le voile météo est `.sky::before` ; les précipitations sont `.sky::after` (`pluieTombe`, `neigeTombe`, `brume`, `eclair`). La pluie est faite de **gouttes courtes** (3 couches de `radial-gradient` elliptiques, tailles/positions différentes) qui tombent verticalement avec un léger angle (`rotate(7deg)`), pas d'un motif de rayures qui glisse. `body.lapin-calme` et `body.no-anim` figent ces animations.

**Palettes pastel** (`lapinPalette`, appliquée via `body[data-palette]`) :

- `creme` (défaut) : fond `#fdf3e7`, ciel et collines crème/roses.
- `menthe` : fond `#eef8f0`, ciel et collines verts.
- `lavande` : fond `#f4f0fb`, ciel et collines mauves.
- `ciel` : fond `#eef6fd`, ciel et collines bleus.
- Chaque palette a aussi une variante **nuit** (`body[data-ciel="nuit"][data-palette=…]`). La palette est choisie dans l'aide et appliquée sans flash au chargement.

**Options de confort / accessibilité** (`lapinConfort`, appliquées sur `<body>`/`<html>`) :

- `animations` (bool) : si faux, classe `no-anim` (coupe animations/transitions).
- `contraste` (bool) : classe `contraste` (textes et bordures renforcés).
- `taille` (`normal` / `grand` / `tres-grand`) : classes `taille-grand` / `taille-tres-grand` sur `<html>`.
- `calme` (bool) : classe `lapin-calme` ; le lapin ne suit plus la souris et n'anime plus ses oreilles.
- La variable `calme` vaut vrai si `prefers-reduced-motion` **ou** animations coupées **ou** mode calme ; elle est relue à chaque interaction (pas seulement au chargement).

### 5. Météo (Open-Meteo, sans clé)

- Au clic sur le bouton météo : petit formulaire avec un champ ville (vide = retirer la météo) + bouton OK, et un bouton **« 📍 Utiliser ma position »** (géolocalisation).
- Géocodage : `https://geocoding-api.open-meteo.com/v1/search?count=1&language=fr&format=json&name=<ville>`. Mémoriser `{ville, lat, lon}`.
- Géolocalisation : `navigator.geolocation.getCurrentPosition` → coordonnées → **reverse-géocodage** via BigDataCloud (`https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=…&longitude=…&localityLanguage=fr`) pour obtenir un nom de ville ; repli « Ma position » si l'API échoue.
- Météo : `https://api.open-meteo.com/v1/forecast?latitude=…&longitude=…&current=temperature_2m,weather_code&hourly=temperature_2m,precipitation_probability,weather_code,precipitation&daily=sunrise,sunset,temperature_2m_max,temperature_2m_min,weather_code&forecast_days=3&timezone=auto`.
- Afficher dans le bouton : emoji météo + température arrondie + ville (ex. « 🌧️ 11° Lyon »). L'emoji porte une **classe d'animation** (`meteo-soleil`, `meteo-nuage`, `meteo-pluie`, `meteo-neige`, `meteo-orage`…) pour un petit effet animé.
- Sous le champ, afficher **3 prévisions** : « Auj. » puis les jours abrégés en français, avec emoji et `max° / min°`.
- Afficher aussi les **8 prochaines heures** (`#meteoHeures`, classe `.mh` : heure, emoji, température, % de pluie) et un **message de pluie dans l'heure** (`#meteoPluie`, ex. « 🌤️ Pas de pluie en vue dans les prochaines heures » ou « 🌧️ Pluie probable dans l'heure »).
- Correspondance `weather_code` → emoji + libellé (0 ☀️, 1–2 🌤️, 3 ☁️, 45/48 🌫️, 51–57 🌦️, 61–67 🌧️, 71–77 🌨️, 80–82 🌦️, 85–86 🌨️, 95+ ⛈️). Le même code alimente `categorieCiel()` pour teinter et animer le fond (`data-meteo`).
- Cache dans `localStorage` pendant 15 min (`lapinMeteoCache`, incluant `heures` et `pluie`), rafraîchissement toutes les 20 min et au retour sur l'onglet si le cache a plus de 15 min.
- Si la ville est retirée : effacer le cache, les prévisions et revenir au bouton « 🌤️ Météo ».

### 6. Pense-bête multi-pages

- Bouton `📝` ou touche `N` : ouvre une carte avec un `<textarea>`.
- **Plusieurs pages** : onglets (`#notesTabs`, `.notes-tab`) en haut de la carte, bouton `＋` pour ajouter une page. Chaque page = `{id, titre, texte}`.
  - Double-clic sur un onglet pour **renommer** (via `prompt()`).
  - Bouton `notesSupprPage` pour **supprimer** la page courante (confirmation), en conservant au moins une page.
  - Les pages sont stockées dans `lapinNotesPages` (tableau) et la page active dans `lapinNotesActif`.
- **Sauvegarde automatique** à chaque frappe, avec un petit texte « Sauvegardé automatiquement » / nombre de caractères.
- **Cases à cocher markdown** : bouton « ☑ » (`notesCheck`) insère `- [ ] ` au début de la ligne ; bouton « Cocher » (`notesCocher`) bascule `- [ ]` ↔ `- [x]` sur la ligne du curseur.
- **Export** : boutons `.txt` et `.md` (`exporterNotes("txt"|"md")`) → téléchargement via `Blob` + `URL.createObjectURL` ; le `.md` préfixe le titre en `# Titre`.
- Migration : si `lapinNotesPages` n'existe pas mais `lapinNotes` (ancienne clé) contient du texte, créer une page avec ce texte.
- Bouton « Effacer » avec confirmation, bouton « ✕ » pour fermer.
- Une **pastille rose** sur le bouton du dock indique qu'il y a du texte (même quand la carte est fermée).

### 7. Calcul rapide

- Une saisie commençant par `=` calcule l'expression (ex. `= 12*8` → `96`).
- Accepter les espaces, `×`, `x` (remplacés par `*`) et la **virgule française** (remplacée par `.`).
- Autoriser uniquement `[0-9+\-*/().]`, calculer avec `Function` en mode strict, refuser `NaN`/`Infinity`, arrondir à 10 décimales.
- Afficher le résultat dans un toast **et** le copier dans le presse-papiers si possible. Vider le champ.
- Si l'expression est invalide : message d'erreur doux, pas de plantage.

### 7 bis. Calculatrice (panneau dédié)

- Bouton `🧮` dans le dock, touche `=` (hors champ de saisie) ou clic : ouvre une **vraie calculatrice** (et non un simple calcul rapide), affichée comme widget empilé dans `#widgets`.
- Panneau `.calc-card` : écran avec l'expression (`#calcExpression`) et le résultat en direct (`#calcResultat`), puis un pavé 4 colonnes :
  `C`, `⌫`, `(`, `)`, `7 8 9 ÷`, `4 5 6 ×`, `1 2 3 −`, `± 0 . +`, `%`, `=` (le `=` occupe 3 colonnes).
- Le résultat se met à jour **à chaque touche** en réutilisant `calculer()` (mêmes règles de sécurité que le calcul rapide).
- Touches `±` : inverse le signe du **dernier nombre** (ex. `5+3` → `5+(-3)` → `5+3`), sans casser l'expression.
- `%` : divise par 100 (`50%` → `0.5`).
- `⌫` efface le dernier caractère, `C` vide l'expression.
- Boutons opérateurs : remplacer un opérateur consécutif, interdire `)` sans `(`, autoriser `−` en début d'expression.
- **Historique** : les 8 derniers calculs (`{e, r}`) sont stockés dans `localStorage` (`lapinCalculs`) et listés sous le pavé ; un clic sur une ligne réutilise le résultat. Bouton « vider » pour effacer.
- Cliquer sur le résultat le copie dans le presse-papiers (repli toast si refusé).
- **Onglets de mode** (`data-calc-tab`) : `standard`, `sci`, `conv`.
- **Mémoire** (`data-mem` = `M+`, `M−`, `MR`, `MC`), stockée dans `lapinCalcMemoire` (`{v, actif}`) :
  - `M+`/`M−` ajoutent/retirent la valeur courante (résultat de l'expression ou résultat affiché) ;
  - `MR` réinjecte la mémoire dans l'expression ; `MC` efface ;
  - `#calcM` (indicateur) prend la classe `.actif` quand la mémoire est non vide.
- **Mode scientifique** (classe `.mode-sci`) : boutons `sin(`, `cos(`, `tan(`, `√(`, `ln(`, `log(`, `^`, `^2`, `π`, `e`, `abs(`.
  - `calculer()` étend la whitelist pour accepter `sin|cos|tan|sqrt|ln|log|abs|pi|e|^` ; conversion vers `Math.*`.
  - **Piège** : remplacer `log` **avant** `ln` (sinon `ln` devient `log10`).
- **Convertisseur** (classe `.mode-conv`, `#calcConv*`) : catégorie (longueur, masse, température, durée, volume, données), valeur, unité de départ, unité d'arrivée, résultat en direct.
  - Table `CONVERSIONS` avec facteurs vers l'unité de base ; la **température** a une formule dédiée (C/F/K).
- Clavier : quand la calculatrice a le focus, chiffres, `+ - * / . ( ) %`, `Entrée`/`=` calcule, `Retour arrière` efface, `Suppr`/`C` vide, `Échap` ferme. Si le focus est dans un `INPUT`/`TEXTAREA`/`SELECT` (y compris les champs du convertisseur), la calculatrice **ne capte pas** les touches.
- Widget **empilé** avec les autres dans `#widgets` (plusieurs ouverts en même temps) ; il se ferme par `✕`, `Échap` ou en recliquant son bouton. Il ne se ferme pas au clic extérieur. La zone de widgets défile (`overflow-y: auto`) et reste dans la fenêtre.

### 8. Minuteur + Pomodoro

- Bouton `⏱️` dans le dock ou touche `T`.
- **Deux onglets de mode** (`timerModeMin` / `timerModePomo`) : Minuteur simple et Pomodoro.
- **Minuteur simple** :
  - presets : 5, 10, 25, 45 min + champ libre 1–180 min + bouton « Démarrer » ;
  - pendant le compte à rebours, le bouton du dock affiche `⏱️ MM:SS` (ou `H:MM:SS` si ≥ 1 h) et le titre/`aria-label` sont mis à jour ;
  - persistance : stocker la **date de fin** (`Date.now() + minutes*60000`) dans `lapinMinuteur` ; au rechargement, reprendre le compte si la fin est dans le futur ;
  - à la fin : retirer le stockage, toast « ⏱️ Minuteur terminé ! », **bip** via Web Audio, animation de pulsation du bouton pendant ~4 s ;
  - bouton « Arrêter le minuteur ».
- **Pomodoro** (`lapinPomodoro`, `{actif, fin, phase, sessions}`) :
  - durées `POMO_DUREES = {focus: 25, pause: 5, pauseLong: 15}` ;
  - phase Focus → Pause (5 min) → Focus… et **pause longue (15 min) toutes les 4 sessions** ;
  - compte des sessions affiché en **4 points** (`#pomoSessions`) ;
  - boutons Démarrer/Pause et Arrêter (remet à zéro phase et sessions) ;
  - le dock affiche `🍅 MM:SS` et une classe `pomo-actif` pendant le focus ;
  - à la fin d'une phase : bip + toast (focus terminé / pause terminée) et passage automatique à la phase suivante ;
  - état restauré au rechargement si la fin est dans le futur.
- **Choix du son** (`#timerSon`, mémorisé dans `lapinSon`) : `cloche` (3 notes 880 Hz), `carillon` (arpège), `goutte` (2 notes), `muet`. Le son est joué via un `AudioContext` créé/résumé à la première interaction (`preparerAudio`).

### 9. Aide `?` + widget Paramètres `⚙️`

- Touche `?` (hors champ de saisie) : overlay centré, **défilable**, listant les raccourcis (`/`, `@ Tab`, `=`, `N`, `T`, `L`, `?`, `Échap`, etc.) et le mot du jour. **Les réglages ne sont plus dans l'aide** : ils ont leur propre widget.
- **Bouton `⚙️` dans le dock** : ouvre le **widget Paramètres** (`#reglagesCard`), empilé dans `#widgets` comme les autres cartes — repliable (`▾`/`▸` injecté), mémorisé dans `lapinWidgets` (clé `reglages` + `reglagesRepli`), restauré sans voler le focus. Fermeture par `✕` (`#reglagesClose`), en recliquant `⚙️`, par `Échap` ou « Tout fermer ». Il ne se ferme pas au clic extérieur.
- Sections de réglages du widget (`#reglagesCard > .reglages`, mêmes IDs qu'avant) :
  - **Apparence** : palette pastel (`#setPalette`), plage de nuit début/fin (`#setNuitDebut`, `#setNuitFin`).
  - **Horloge** : secondes (`#setSecondes`), format 12/24 (`#setFormat`), deuxième fuseau (`#setFuseau2`).
  - **Confort** : animations (`#setAnimations`), contraste (`#setContraste`), taille du texte (`#setTaille`), mode calme (`#setCalme`).
  - **Données** : exporter (`#setExport`), importer (`#setImport` + `#setImportFichier` caché), réinitialiser (`#setReset`).
- **Export** : construit un objet `{version:1, date, donnees}` avec **toutes les clés `lapin*`** (valeurs brutes) et télécharge un `.json` (`lapin-reglages-AAAAMMJJ.json`).
- **Import** : lit un fichier JSON, vérifie `donnees`, réécrit uniquement les clés commençant par `lapin`, puis recharge la page ; fichier invalide → toast doux.
- **Réinitialisation** : confirmation, supprime **toutes** les clés `lapin*`, puis recharge.
- **Piège CSS** : l'overlay est centré avec `transform: translate(-50%,-50%)`. Ne pas lui appliquer un `@keyframes` qui remet `transform: none` (ça le décale). Créer une animation dédiée qui conserve `translate(-50%,-50%)`.
- Fermeture de l'**aide** par `✕`, `Échap` ou clic à l'extérieur. C'est le **seul** panneau qui se ferme au clic extérieur ; les widgets empilés (dont les paramètres) restent ouverts.

### 9 bis. Citation / mot du jour

- `#citation` affiche une citation du jour (`CITATIONS`, choisie par `Math.floor(Date.now()/86400000) % length`), avec auteur en gras. Un clic passe à la citation suivante.
- `#motJour` affiche un « Mot du jour » tiré de `MOTS_JOUR`.

### 9 ter. Easter eggs

Tout doit rester discret et amusant, sans gêner l'usage normal :

- **Code Konami** (`↑↑↓↓←→←→BA`) → pluie de carottes + étincelles + toast « 🥕 Code carotte activé ! ».
- **Mots tapés au clavier** (hors champ de saisie) : `oeuf` → pluie d'œufs, `paques` → pluie 🥚🐰🐣, `magie` → étincelles, `coucou` → le lapin saute, `pluie` → gouttes, `carotte` → carottes, `doudou` → 🧸 + 💛, `bonjour` → 👋, `42` → toast « la réponse à la grande question ».
- **12 clics rapides sur le lapin** (< 4 s) → pluie de carottes + toast « le lapin est surexcité ».
- **Carotte cliquable** → le lapin mange, particules + toast.
- **Triple-clic sur l'horloge** → « Il est l'heure du goûter ! » + carottes.
- **Triple-clic sur le soleil/la lune** → pluie d'étoiles + toast.
- Indice dans l'aide : « Des surprises se cachent dans la page… 👀 ».
- Les emojis tombent via une classe `.chute` (`position: fixed`, `@keyframes` qui translate de `-6vh` à `118vh`, rotation et dérive aléatoires), puis sont supprimés du DOM.
- Attention : les mots secrets doivent éviter les lettres déjà utilisées comme raccourcis (`N`, `T`, `L`, `?`, `/`, `=`), sinon le panneau s'ouvre pendant la saisie du mot.

### 9 quater. Traducteur (Google Traduction)

- Bouton `🌐` dans le dock, raccourci `L`, et moteur `@traduire` (alias `trad`, `tr`, `translate`, `traduction`) dans la palette.
- Panneau avec deux listes de langues (source avec « Détection auto », cible), bouton d'inversion `⇄`, zone de texte, boutons « Traduire » et « Copier », et lien vers Google Traduction.
- Traduction via l'endpoint public :
  `https://translate.googleapis.com/translate_a/single?client=gtx&sl=SOURCE&tl=CIBLE&dt=t&q=TEXTE`
  (CORS autorisé ; la réponse est un tableau JSON : concaténer `data[0][i][0]`, langue détectée dans `data[2]`).
- `@traduire un texte` ouvre le panneau, pré-remplit la zone et lance la traduction. `@traduire` seul ouvre le panneau avec le focus dans la zone.
- `Ctrl + Entrée` dans la zone traduit. « Copier » copie le résultat (avec repli `document.execCommand("copy")` si l'API presse-papiers est refusée).
- Mémoriser les langues choisies dans `localStorage` (`lapinTrad`, objet `{de, vers}`), les restaurer au chargement.
- Widget **empilé** avec les autres dans `#widgets` (plusieurs ouverts en même temps) ; il se ferme par `Échap` ou en recliquant son bouton, et reste dans la fenêtre grâce au défilement de la zone.
- Gérer les erreurs réseau avec un toast doux, sans plantage.

### 9 quinquies. BrixHub (cadre intégré, sans petit panneau — extension Firefox requise)

- Bouton `🕵️` dans le **volet gauche** (volet vertical coulissant collé au bord gauche : il glisse quand le curseur touche le bord — zone `.volet-zone` de 10 px sur toute la hauteur, ouverture CSS pure ; la patte `🐾` cliquable l'ouvre/le referme pour le tactile, `.ouvert` refermé au clic extérieur) et raccourci `H` : ils ouvrent **directement `#brixCadre`**, la grande fenêtre du site dans la page. Il n'y a **pas de petit panneau** BrixHub dans `#widgets` (supprimé).
- **Le cadre est docké à gauche, en vertical** : `left: 14px`, `top: 70px`, largeur `min(560px, 100vw − 28px)`, hauteur `100vh − 90px` (portrait, sur toute la hauteur). Le bouton **`⛶` de la barre** (`#brixPlein`) bascule la classe `.plein` = grand écran (`inset: 0`, `100vw × 100vh`, sans arrondi) ; `Échap` **sort d'abord du grand écran**, puis referme le cadre à l'appui suivant ; la fermeture (`✕`/`H`/exclusion) réinitialise toujours l'état plein.
- **Contrainte** : BrixHub envoie `X-Frame-Options` ; le navigateur refuse l'affichage intégré et rien dans la page ne peut le contourner. Il faut installer une fois l'extension Firefox « **Ignore X-Frame-Options Header** » (voir `a-savoir-brixhub.txt`) ; sans elle, le cadre affiche le message de sécurité du navigateur et le repli « Dans un onglet ↗ » reste utilisable.
- Barre du cadre : titre, champ e-mail facultatif (`#brixEmail`), bouton « **Copier** » (`#brixCopier`), lien « **Dans un onglet ↗** » (`#brixOnglet`, lien natif `target="_blank"` ; au clic, copie l'e-mail valide saisi), bouton **`⛶` grand écran** (`#brixPlein`), bouton ✕ (`#brixCadreFermer`). Ligne d'état `#brixEtat` (`aria-live="polite"`) sous la barre, puis la zone iframe `#brixCadreZone`.
- **Aucune recherche automatique, aucun stockage** ; validation d'e-mail simple ; un e-mail valide saisi est copié en même temps que l'ouverture de l'onglet.
- L'iframe porte `referrerpolicy="no-referrer"`, créé une seule fois et conservé caché après fermeture (réouverture instantanée). Il ne se charge qu'à l'ouverture par l'utilisateur (`🕵️`/`H`/raccourci de grille), **jamais au chargement de la page ni à la restauration** (BrixHub n'est plus dans `PANNEAUX`/`lapinWidgets` : toujours fermé après un rechargement).
- `Échap`/`✕`/`H` et « tout fermer » ferment le cadre en une seule action ; `aria-expanded` synchronisé sur `#brixBtn` ; `aria-controls="brixCadre"`.
- Le raccourci `🕵️ BrixHub` de la grille (voir critère 34) ouvre le cadre, jamais d'onglet.
- Documentation utilisateur : `nouvel-onglet-lapin\a-savoir-brixhub.txt`.

### 9 sexies. Discord (cadre intégré, même principe que BrixHub)

- Bouton `🎮` dans le **volet gauche** (même volet coulissant que BrixHub) et raccourci `D` : ils ouvrent directement `#discordCadre`, la grande fenêtre verticale de gauche avec `https://discord.com/app` dedans (même CSS de cadre que BrixHub : `.brix-cadre`/`.brix-barre`/`.brix-zone` réutilisés, donc docké à gauche, bouton `⛶` `#discordPlein` = grand écran, `Échap` sort du plein puis referme).
- Discord envoie aussi `X-Frame-Options` : la **même extension** « Ignore X-Frame-Options » débloque l'affichage intégré ; sans elle, message de sécurité du navigateur dans le cadre et repli « Dans un onglet ↗ » (`#discordCadre` contient un lien natif `target="_blank"`).
- Barre du cadre : titre « Discord », lien « Dans un onglet ↗ », bouton **`⛶` grand écran** (`#discordPlein`), bouton ✕ (`#discordCadreFermer`) ; ligne d'état `#discordEtat` (`aria-live="polite"`), puis zone iframe `#discordCadreZone`.
- **Un seul grand cadre à la fois** : ouvrir Discord referme BrixHub et inversement.
- L'iframe porte `referrerpolicy="no-referrer"`, créé une seule fois et conservé caché ; il ne se charge **jamais** au chargement de la page. `Échap`/`✕`/`D`/« tout fermer » referment le cadre ; `aria-expanded` synchronisé sur `#discordBtn` ; rien n'est stocké, connexion manuelle dans le cadre.

### 10. Toast

- Petit message flottant en haut, centré, fond sombre translucide, texte blanc, apparition/disparition en fondu.
- Un seul toast à la fois (réutiliser l'élément), `role="status"`.

### 11. Widgets empilés, mémoire, repli et clavier

- **Plusieurs widgets ouverts en même temps** : météo, traducteur, calculatrice, minuteur et notes vivent dans un conteneur `#widgets` fixé sous le dock. Ils s'empilent verticalement, avec un espace de 8 px, sans jamais se chevaucher. Chaque bouton du dock ouvre/ferme **son** widget indépendamment.
- Le conteneur a `pointer-events: none` et ses enfants `pointer-events: auto`, pour laisser cliquer la page autour. Il défile (`overflow-y: auto`, `max-height: calc(100vh - 90px)`) si trop de widgets sont ouverts.
- **Barre `#widgetsBar`** visible dès qu'un widget est ouvert, avec un bouton **« Tout fermer »** (`#widgetsCloseAll`) qui ferme tous les panneaux et remet les `aria-expanded` à `false`.
- **Mémoire d'ouverture** (`lapinWidgets`) : un objet `{meteo, trad, calc, timer, notes, theme, reglages}` (+ clés `…Repli`) enregistré à chaque ouverture/fermeture/repli. Au chargement, les widgets sont restaurés **sans voler le focus** (affecter `hidden` directement, pas via les fonctions d'ouverture).
- **Repli/dépli** : chaque carte a un bouton `.widget-collapse` (`▾`/`▸`) dans son en-tête (la météo utilise `#meteoRepli`) ; l'état est mémorisé (`collapsed` + clé `…Repli`).
- L'aide reste **centrée** et est le **seul** panneau qui se ferme au clic à l'extérieur. Les widgets empilés ne se ferment pas au clic extérieur.
- `Échap` ferme tous les widgets, l'aide, l'éditeur de raccourcis, et enlève le focus du champ actif.
- `/` met le focus dans la recherche, **sans fermer** les widgets.
- `=` ouvre la calculatrice (hors champ de saisie).
- Ne pas déclencher les raccourcis `N`/`T`/`L`/`H`/`=`/`?` quand on tape dans un `INPUT`/`TEXTAREA`/`SELECT`.
- La calculatrice ne capte le clavier que si le focus est **dans sa carte** (ou hors d'un champ) ; on peut donc taper dans les notes, le minuteur, le traducteur ou le convertisseur même quand elle est ouverte.

## Détails techniques

- **Clés `localStorage`** :
  - base : `lapinNom`, `lapinTheme`, `lapinMeteoForcee`, `lapinMeteo`, `lapinMeteoCache`, `lapinMinuteur`, `lapinTrad`, `lapinCalculs` ;
  - raccourcis : `lapinRaccourcis`, `lapinRaccourcisBrix` (drapeau de migration unique) ;
  - widgets : `lapinWidgets` ;
  - minuteur/Pomodoro : `lapinPomodoro`, `lapinSon` ;
  - notes : `lapinNotesPages`, `lapinNotesActif` (et migration depuis `lapinNotes`) ;
  - recherche : `lapinRecherches` ;
  - calculatrice : `lapinCalcMemoire` ;
  - apparence/horloge/confort : `lapinPalette`, `lapinPlageNuit`, `lapinHorloge`, `lapinConfort`.
- Exception à la règle « aucune ressource externe » : les API **Google Traduction** (`translate.googleapis.com`), **Open-Meteo** (météo/géocodage) et **BigDataCloud** (reverse-géocodage pour la géolocalisation). Plus aucune iframe Discord.
- Toujours entourer les accès `localStorage` d'un `try/catch` (mode privé).
- **Ordre des z-index** : décor négatif, `main` à 3, dock à 32, zone `#widgets` à 42, aide à 60, toast au-dessus.
- **Piège de clic** : `main` a `pointer-events: none` pour laisser passer la souris vers le décor, et `main > *` a `pointer-events: auto` pour rester cliquable. Même principe pour `#widgets` / `.widgets > *`.
- `overflow-x: hidden` sur `body` ; aucun débordement horizontal à aucune largeur.
- Le prénom est mémorisé (`lapinNom`), modifiable par `prompt()` au clic, limité à 24 caractères.
- Accessibilité : `aria-label` sur les boutons icônes, `aria-expanded` sur les panneaux, `role="search"`, `role="listbox"` pour la palette, focus visible.

## Responsive

Tester au minimum : **320×568, 360×640, 375×667, 414×896, 520×700, 640×700, 800×606, 1024×768, 1366×768, 1920×1080**.

- Jamais de scroll horizontal.
- Sous 640 px : lapin réduit (~132 px), horloge en `clamp(3rem, 18vw, 5rem)`, raccourcis resserrés mais **toujours visibles** (ils passent à la ligne ; ne plus en masquer).
- Sous 520 px : la zone `#widgets` passe en `width: calc(100% - 24px)` et `right: 12px`, `max-height: calc(100vh - 68px)` ; l'éditeur de raccourcis passe en grille 3 colonnes avec les actions sur toute la largeur.
- Sous 360 px : dock remonté (`top: 8px`, `right: 8px`, `gap: 4px`), libellé météo masqué (`#wTxt`) et boutons resserrés pour faire tenir les 7 boutons, zone `#widgets` à `top: 52px`, pour ne pas chevaucher la salutation.
- L'aide (avec ses réglages) doit **défiler** et tenir dans la fenêtre à toutes ces tailles.
- La calculatrice est un widget **empilé** (plusieurs ouverts à la fois) : elle n'est plus centrée. C'est la zone `#widgets` qui défile, donc tout tient en 320×568 sans scroll horizontal.

## Serveur local + démarrage automatique + Firefox

### `serveur_lapin.py`

- Python 3 standard uniquement (`http.server`, `ThreadingHTTPServer`).
- Écoute **uniquement** `127.0.0.1:8765`.
- Sert `/`, `/index.html`, `/nouvel-onglet-lapin.html` et `/nouvel-onglet-lapin` avec `Content-Type: text/html; charset=utf-8` et **`Cache-Control: no-store`** (indispensable pour voir les modifications).
- Sert un favicon SVG 🐰 sur `/favicon.ico`.
- `--check` : code 0 si le serveur tourne déjà. `--stop` : tue le processus via un fichier PID dans `%TEMP%`.
- Au démarrage, si le port est déjà occupé, ne pas créer de doublon : afficher « Le serveur lapin tourne déjà » et sortir en 0.

### `.bat`

- `lancer_page_lapin.bat` : si `--check` échoue, lancer le serveur avec `pythonw.exe` (sans fenêtre), puis ouvrir `http://127.0.0.1:8765/`.
- `arreter_page_lapin.bat` : appeler `python serveur_lapin.py --stop`.
- Démarrage auto : créer un raccourci `.lnk` dans `shell:startup` qui pointe vers `pythonw.exe` avec le script en argument ; prévoir l'installation et la désinstallation.

### Firefox

- Installer l'extension **New Tab Override** et lui donner l'URL `http://127.0.0.1:8765/`.
- C'est ce qui remplace la page de nouvel onglet de Firefox et **supprime le groupe de raccourcis natif** de Firefox (ne pas le réintroduire).

## Critères d'acceptation (à vérifier avant de rendre)

1. La page s'ouvre sur `http://127.0.0.1:8765/` sans erreur console.
2. L'horloge affiche l'heure de Paris, même si le PC est réglé sur un autre fuseau ; les options secondes / 12-24 h / deuxième fuseau fonctionnent et se mémorisent.
3. Une recherche `test lapin` ouvre réellement Google avec la requête.
4. `@per` + `Tab` complète en `@perplexity ` ; `Entrée` lance la recherche Perplexity.
5. `@bookmarks` et `@tabs` affichent le message d'explication (pas de navigation).
6. Le bouton `🌗` ouvre le petit panneau du fond du ciel avec 5 modes (auto, jour, nuit, aube, crépuscule) **et une rangée « La météo du ciel » de 8 pilules (auto, clair, nuageux, couvert, pluie, neige, brouillard, orage)** ; les deux choix se mémorisent après rechargement (`lapinTheme` / `lapinMeteoForcee`), l'option active est surlignée, `Échap`/`✕` referment le panneau ; en mode forcé, le ciel (`data-ciel`), la classe `night` et la météo du fond (`data-meteo` : voile, pluie, flocons, brume, éclairs) suivent le mode (aube/crépuscule → textes clairs) ; en auto, la météo du fond est la vraie météo de la ville.
7. En mode auto, si le soleil de la ville est connu, le thème et le ciel suivent lever/coucher ; sinon ils suivent la plage de nuit réglable (défaut 07:00–20:00). Les phases aube → lever → jour → heure dorée → coucher → crépuscule → nuit se succèdent aux bonnes heures.
8. Ajouter « Lyon » affiche la température, **3 cartes de prévisions**, **8 heures** et le message de pluie ; vider le champ les retire ; « 📍 Utiliser ma position » fonctionne.
9. `= 12*8` affiche `96` (toast) et copie le résultat.
10. `N` ouvre les notes ; on peut créer/renommer/supprimer des pages, cocher des tâches, exporter en `.txt`/`.md` ; le texte survit à un rechargement ; la pastille apparaît.
11. `T` ouvre le minuteur ; `5 min` lance un compte à rebours visible dans le dock ; il survit à un rechargement ; à zéro : toast + son choisi.
12. `?` ouvre l'aide (défilable, sans les réglages) ; `⚙️` ouvre le widget Paramètres (empilé, repliable, mémorisé) ; `Échap` ferme tout.
13. Le lapin est vivant (respiration, clignements, oreilles), son visage suit la souris, il saute au clic ; la carotte posée à côté le nourrit.
14. Aucun chevauchement dock / salutation / horloge de 320 px à 1920 px, pas de scroll horizontal.
15. Plusieurs widgets peuvent être ouverts **en même temps** (météo + traducteur + calculatrice + minuteur + notes + paramètres) : ils s'empilent sans se chevaucher, chacun se ferme indépendamment, la zone défile si nécessaire ; l'état d'ouverture et de repli survit au rechargement ; « Tout fermer » fonctionne.
16. Aucun bouton, panneau, raccourci ni mention Discord n'existe ; la touche `D` ne fait rien.
17. Le code Konami et les mots `oeuf`, `paques`, `magie`, `coucou`, `pluie`, `carotte`, `doudou`, `bonjour`, `42` déclenchent leur effet, sans ouvrir de panneau par erreur.
18. 12 clics sur le lapin, triple-clic sur l'horloge et triple-clic sur le soleil/la lune déclenchent leurs surprises.
19. `L` ou le bouton `🌐` ouvre le traducteur ; « Traduire » affiche une traduction Google réelle et les langues choisies sont mémorisées.
20. `@traduire un texte` ouvre le panneau avec la traduction ; `@traduire` seul ouvre le panneau, focus dans la zone.
21. `=` ouvre la calculatrice ; `12 + 8 =` affiche `20`, `(2+3)×4` affiche `20`, `50%` affiche `0.5`, `±` inverse le signe du dernier nombre, `⌫` et `C` fonctionnent.
22. L'historique de la calculatrice (8 calculs max) survit à un rechargement, une ligne réutilise son résultat et « vider » l'efface.
23. La calculatrice reste utilisable quand les notes ou le traducteur ont le focus (elle ne capte pas les touches tapées dans ces champs) ; `Échap` ferme les widgets ; le tout tient de 320×568 à 1920×1080 sans scroll horizontal.
24. Aucun pied de page ni bandeau de raccourcis en bas de l'écran.
25. L'éditeur de raccourcis ajoute/modifie/supprime/réordonne/réinitialise, valide les URL, et se mémorise.
26. La mémoire de calculatrice (`M+`, `M−`, `MR`, `MC`), le mode scientifique (`√9` = `3`) et les conversions (100 m = 0,1 km) fonctionnent.
27. Le Pomodoro enchaîne focus 25 min → pause 5 min → pause longue après 4 sessions, avec points de session, son choisi et état dans le dock.
28. L'historique de recherche s'affiche à vide / sur `↑`, permet de choisir et de supprimer une entrée, et se mémorise.
29. Les 4 palettes pastel changent réellement les couleurs ; les options de confort (animations, contraste, taille, calme, lapin) s'appliquent et se mémorisent.
30. L'export produit un JSON valide, l'import le restaure, et la réinitialisation efface toutes les clés `lapin*` puis recharge.
31. La citation et le mot du jour s'affichent ; cliquer la citation en change.
32. Le ciel change réellement selon la phase du soleil et la météo : `data-ciel` et `data-meteo` sont posés sur `<body>`, le voile et les animations (pluie, neige, brouillard, éclairs) sont visibles, le soleil/la lune se déplace et pâlit selon le temps, et les palettes + la nuit restent cohérentes.
33. Le bouton `🕵️` (dans le volet coulissant du bord gauche, révélé au survol du bord ou au clic sur la patte `🐾`) ou `H` ouvre **directement le grand cadre BrixHub dans la page** (fenêtre verticale dockée à gauche, toute la hauteur ; bouton `⛶` de la barre = grand écran, `Échap` en sort d'abord ; pas de petit panneau ; l'extension Firefox « Ignore X-Frame-Options » doit être installée, sinon message de sécurité du navigateur dans le cadre) ; la barre du cadre contient le champ e-mail, « Copier », « Dans un onglet ↗ », `⛶` et ✕ ; un e-mail invalide est refusé, rien n'est stocké et aucune recherche automatique (nom/prénom) n'est lancée ; `Échap`/`✕`/`H` ferment le cadre en un seul geste ; le cadre ne se charge jamais au chargement de la page.
34. Le raccourci `🕵️ BrixHub` apparaît dans la grille (défaut ou migration unique) sans écraser les raccourcis existants ; un clic dessus **n'ouvre pas d'onglet ni de navigation** : il affiche le widget BrixHub dans la page (cadre intégré), comme la touche `H` ; seul le bouton « Dans un onglet ↗ » du widget ouvre le site dans un onglet.
35. Le bouton `🎮` (volet gauche, même volet que BrixHub) ou `D` ouvre **le grand cadre Discord** (`discord.com/app`) dans la page, même mécanique que BrixHub : fenêtre verticale à gauche, `⛶` = grand écran, `Échap` sort du plein puis referme (extension « Ignore X-Frame-Options » nécessaire, sinon message du navigateur) ; ouvrir l'un referme l'autre ; `Échap`/`✕`/`D`/« tout fermer » le ferment ; l'iframe ne se charge jamais au chargement de la page et rien n'est stocké.

## Pièges à éviter

- ❌ Utiliser `new Date().getHours()` pour l'heure affichée → utiliser `Intl` avec `Europe/Paris`.
- ❌ Oublier `Math.floor(ms/1000)*1000` dans le calcul du décalage → décalage 3599 au lieu de 3600.
- ❌ Mettre un `@keyframes` avec `transform: none` sur un élément centré en `translate(-50%,-50%)`.
- ❌ Oublier `pointer-events: auto` sur les enfants de `main` → plus rien n'est cliquable. Idem pour les enfants de `#widgets`.
- ❌ Rendre les panneaux mutuellement exclusifs : plusieurs widgets doivent pouvoir rester ouverts et s'empiler.
- ❌ Restaurer les widgets mémorisés en appelant `ouvrir…()` : cela volerait le focus ; affecter `hidden = false` directement.
- ❌ Laisser un pied de page ou un bouton/raccourci Discord : ils ont été retirés.
- ❌ Mettre le dock en bas : il doit être **en haut à droite**, et ne pas recouvrir la salutation sur petit écran.
- ❌ Essayer d'accéder aux marque-pages/onglets Firefox depuis le JS de la page.
- ❌ Charger une police ou une image depuis Internet.
- ❌ Remplacer `ln` **après** `log` dans le calcul scientifique (sinon `ln` devient `log10`).
- ❌ Laisser le garde-clavier de la calculatrice capter les frappes dans les champs `INPUT`/`TEXTAREA`/`SELECT` (notamment le convertisseur).
- ❌ Mettre `Cache-Control` absent : sinon les modifications ne s'affichent pas.
- ❌ Utiliser `file://` : l'extension New Tab Override doit pointer vers `http://127.0.0.1:8765/`.
- ❌ Laisser des `console.log` ou des hooks de test dans le fichier final.
- ❌ Recalculer le ciel à chaque image avec `requestAnimationFrame` : poser `data-ciel` / `data-meteo` seulement quand la valeur change, et laisser le CSS animer.
- ❌ Mettre les règles `data-ciel` **avant** les palettes ou la règle `body.night .sky` : elles seraient écrasées. Les phases doivent être définies après, et la nuit doit passer par `data-ciel="nuit"`.
- ❌ Lire `getComputedStyle` juste après un changement de palette ou de météo : la transition (0,6–0,8 s) renvoie encore l'ancienne couleur ; couper la transition pour tester.
- ❌ Animer `.sky::after` sans vérifier `body.no-anim` / `body.lapin-calme` / `prefers-reduced-motion`.
- ❌ Automatiser une recherche de nom/prénom sur BrixHub, scraper le site ou pré-remplir une requête personnelle : le widget se contente d'ouvrir `https://brixhub.to/` dans un onglet et de copier l'e-mail si l'utilisateur le demande.
- ❌ Compter sur l'iframe de BrixHub sans extension : le site envoie `X-Frame-Options` ; sans l'extension Firefox « Ignore X-Frame-Options Header » installée, le cadre affiche le message de sécurité du navigateur. Toujours garder le repli « Dans un onglet ↗ » visible, et ne pas construire de proxy serveur (le DNS de la machine bloque le site).
- ❌ Stocker l'e-mail saisi dans `localStorage` ou l'envoyer à un serveur.
- ❌ Compter sur un pré-remplissage d'URL de recherche BrixHub : le widget ouvre la page d'accueil et copie l'e-mail, sans inventer de paramètre de requête.

## Ton de la réponse attendue

Livre les fichiers complets, prêts à copier, avec des commentaires en français. Explique ensuite en 5–10 lignes comment lancer la page, comment l'installer comme nouvel onglet Firefox, et comment tout désinstaller. Signale clairement la limite des marque-pages/onglets.
