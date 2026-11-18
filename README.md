# 🐰 Nouvel onglet Lapin

Une page de **nouvel onglet Firefox** pastel, cosy et interactive — un seul fichier HTML, sans framework, sans build, sans CDN.

Ciel dynamique qui suit la vraie météo et la position du soleil, horloge de Paris, recherche multi-moteurs, météo, traducteur, calculatrice, minuteur/Pomodoro, notes, raccourcis personnalisables, volet coulissant avec BrixHub et Discord… et un petit lapin blanc qui respire, cligne des yeux, suit ta souris et saute quand tu cliques dessus. 🥕

> 📸 *Ajoute ici une capture d'écran de la page (`docs/apercu.png`) pour égayer le README sur GitHub.*

---

## ✨ Fonctionnalités

### Décor vivant
- **Ciel dynamique** : dégradés pastel qui changent selon l'heure (aube, lever, jour, heure dorée, coucher, crépuscule, nuit) et selon la **météo réelle** de ta ville (pluie, neige, brouillard, éclairs).
- **Soleil / lune** qui se déplace et se couche à l'horizon, nuages qui dérivent, étoiles animées la nuit.
- **4 palettes pastel** au choix (crème/rose/carotte et compagnie).
- **Lapin animé en SVG** : il respire, cligne des yeux, remue les oreilles, son visage suit la souris, il saute au clic et on peut le nourrir avec sa carotte (posée à côté de lui). Réglage « Cacher le lapin » dans Paramètres.

### Outils du quotidien
- 🕐 **Horloge** à l'heure de Paris (secondes, 12/24 h, 2ᵉ fuseau en option), date et salutation personnalisée (clique sur ton prénom pour le changer).
- 🔎 **Recherche** avec moteurs au choix : tape `@` puis le nom (`@wiki`, `@yt`, `@ddg`, `@gh`…). Historique des recherches (touche `↑`).
- 🌤️ **Météo** : température, prévisions sur 3 jours, 8 prochaines heures, message de pluie. Mise à jour automatique toutes les 20 minutes. Géolocalisation possible.
- 🌐 **Traducteur** intégré (Google Traduction).
- 🧮 **Calculatrice** avec historique, mémoire (`M+`, `M−`, `MR`, `MC`), mode scientifique et conversions.
- ⏱️ **Minuteur / Pomodoro** : compte à rebours, sessions focus/pause, son de fin.
- 📝 **Notes** : plusieurs pages, tâches à cocher, export `.txt` / `.md`.
- ⚙️ **Paramètres** : animations, contraste, taille du texte, mode calme, cacher le lapin, export/import/réinitialisation des données.

### Raccourcis et volet latéral
- **Grille de raccourcis** modifiable (ajouter, modifier, réordonner, supprimer, réinitialiser) avec validation des adresses.
- **Volet coulissant** à gauche (survol du bord ou patte 🐾) : **BrixHub** 🕵️, **Discord** 💬 et tes **sites personnalisés** — affichés **dans la page**, sans nouvel onglet.

### Petites surprises
- Code Konami, mots magiques (`oeuf`, `paques`, `magie`, `coucou`, `pluie`, `carotte`, `doudou`, `bonjour`, `42`…), triple-clic sur l'horloge ou le soleil, 12 clics sur le lapin. 👀

---

## 🚀 Installation

### Prérequis
- **Python 3** (Windows, macOS ou Linux).
- **Firefox** (ou tout autre navigateur moderne).

### Lancement rapide (Windows)
1. Télécharge / clone le dossier.
2. Double-clique sur **`lancer_page_lapin.bat`**.
3. La page s'ouvre sur **http://127.0.0.1:8765/**.

Le serveur tourne en arrière-plan, sans fenêtre. Pour l'arrêter : **`arreter_page_lapin.bat`**.

### Lancement manuel (tous systèmes)
```bash
python serveur_lapin.py
# puis ouvre http://127.0.0.1:8765/
```

Options utiles :
```bash
python serveur_lapin.py --check   # le serveur tourne déjà ? (code 0 = oui)
python serveur_lapin.py --stop    # arrêter le serveur
```

### Démarrage automatique avec Windows
Double-clique sur **`installer_demarrage_auto.bat`** : le serveur démarrera tout seul à l'ouverture de session.
Pour retirer : **`desinstaller_demarrage_auto.bat`**.

### En faire ton nouvel onglet Firefox
Firefox ne permet pas de changer nativement l'URL du nouvel onglet : installe une extension comme **New Tab Override** et indique `http://127.0.0.1:8765/`. Tu peux aussi la mettre en page d'accueil.

> 💡 Pour que **BrixHub** et **Discord** s'affichent dans la page (et pas un message de sécurité), installe l'extension Firefox **« Ignore X-Frame-Options »** : ces sites interdisent normalement d'être intégrés dans une iframe.

---

## ⌨️ Raccourcis clavier

| Touche | Action |
|---|---|
| `@` | Choisir un moteur de recherche |
| `↑` | Historique de recherche |
| `L` | Traducteur |
| `=` | Calculatrice |
| `T` | Minuteur / Pomodoro |
| `N` | Notes |
| `H` | BrixHub (dans la page) |
| `D` | Discord (dans la page) |
| `?` | Aide |
| `Échap` | Fermer le panneau / widget ouvert |

---

## 📁 Structure du projet

| Fichier | Rôle |
|---|---|
| `nouvel-onglet-lapin.html` | **Toute la page** : HTML + CSS + SVG + JavaScript, autonome. |
| `serveur_lapin.py` | Petit serveur HTTP local sur `127.0.0.1:8765` (sert uniquement cette page). |
| `lancer_page_lapin.bat` | Démarre le serveur en arrière-plan et ouvre la page. |
| `arreter_page_lapin.bat` | Arrête le serveur. |
| `installer_demarrage_auto.bat` / `.ps1` | Ajoute le lancement automatique au démarrage de Windows. |
| `desinstaller_demarrage_auto.bat` / `.ps1` | Retire ce lancement automatique. |
| `prompt-refaire-page-lapin.md` | Spécification complète de la page (design, fonctionnalités, critères de test). |
| `a-savoir-brixhub.txt` | Notes d'utilisation (volet, éditeur de sites, BrixHub, Discord…). |

---

## 🔒 Vie privée et données

- **Tout est stocké localement** dans ton navigateur (`localStorage`, clés préfixées `lapin…`) : prénom, raccourcis, sites du volet, notes, réglages, historique de calculs… Rien n'est envoyé à un serveur à moi.
- Aucun compte, aucune publicité, aucun tracker, aucun cookie tiers.
- Les seuls appels réseau externes sont ceux des services utilisés :
  - **Open-Meteo** (météo + géocodage) et **BigDataCloud** (position → ville) ;
  - **Google Traduction** quand tu utilises le traducteur ;
  - **BrixHub / Discord** uniquement si tu ouvres leur cadre ;
  - **le moteur de recherche choisi** quand tu lances une recherche.
- Le bouton **« Tout réinitialiser »** (Paramètres) efface toutes les données `lapin*` et recharge la page. Tu peux aussi exporter/importer tes réglages en JSON.

---

## 🛠️ Personnalisation

Tout est dans `nouvel-onglet-lapin.html` (fichier unique, commenté) :

- **Couleurs / polices** : variables CSS en haut du fichier (`:root`).
- **Lapin** : le SVG `#rabbitSvg` et ses animations (respiration, clignements, oreilles).
- **Raccourcis par défaut** : constante `RACCOURCIS_DEFAUT`.
- **Moteurs de recherche** : tableau des moteurs (`token`, alias, URL…).
- **Citations / mots du jour** : listes dédiées dans le script.

Après modification, recharge simplement la page (`Ctrl+R`) — le serveur sert toujours la version à jour (pas de cache).

---

## 🐙 Mettre le projet sur GitHub

Depuis le dossier `nouvel-onglet-lapin` :

```bash
git init
git add .
git commit -m "Page nouvel onglet lapin"
git branch -M main
git remote add origin https://github.com/TON-PSEUDO/nouvel-onglet-lapin.git
git push -u origin main
```

> ⚠️ Avant de publier, vérifie qu'aucune donnée personnelle ne traîne dans le dossier. Les fichiers `.bat` contiennent un chemin Python propre à ta machine : ils retombent automatiquement sur `python` si ce chemin n'existe pas, donc le projet reste utilisable ailleurs.

---

## 📄 Licence

Projet libre sous licence **MIT** — utilise-le, modifie-le et partage-le comme tu veux. 🐇
