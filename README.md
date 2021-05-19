# README

Cette API permet d'accéder aux données d'un blog de voyage. Les visiteurs peuvent librement consulter les articles, en les listant par date de publication, par meilleur note ou par catégorie. Un utilisateur connecté (un auteur) peut maintenant publier et gérer ses articles et ses commentaires.

L'API est publique, mais une identification est nécéssaire pour certaines actions, détaillées ci dessous.

## MISE EN PLACE

### LOCAL

Pour accéder à l'API en local, il faut :
1. Cloner le repo
2. Installer les gems `$ bundle install`
3. Lancer les migrations et les seeds : `$ rails db:migrate` puis `$ rails db:seed`
4. Tester l'API sur le terminal ou postman

### IDENTIFICATION

Pour pouvoir utiliser l'API il faut des données sur l'utilisateur, qui sont rendues publiques, pour la bonne cause de l'exercice. On trouve ces données sur   
  `GET /api/v1/authors`

Choisissez un utilisateur. Son email et son token serviront dans les headers pour faire des modifications des données.

*Exemple de header*  
`X-Author-Email: allen@gerhold.com`  
`X-Author-Token: 8Lsbz1gG8SVoocKHbyt3`

*Exemple de body pour un nouvel article*  
`{ "title": "Vacances au bord de l'eau", "description": "Description de l'article", "url_cover_picture": "https://tinyurl.com/4hxxsvxb", "category_ids": [2,3]}`

*Exemple de body pour un nouveau commentaire*  
`{ "rate": 0, "comment": "LAME !!!!!"}`

## LECTURE SEULE

### ARTICLES

- Lister tous les articles, le plus récent en premier  
    `GET /api/v1/articles`
- Lister tous les articles, le mieux noté en premier  
    `GET /api/v1/articles/order`
- Voir un article  
    `GET /api/v1/articles/:id`

### CATEGORIES

- Voir toutes les catégories et les titres des articles correspondants  
    `GET /api/v1/categories` 
- Voir une catégories et ses articles complets  
    `GET /api/v1/categories/:id`

## ACTIONS UTILISATEUR

Une identification est nécessaire. On ne peut avoir une action que sur ses propres articles et ses propres commentaires. Voir plus haut pour avoir les identifiants

### ARTICLES

- Créer un nouvel article (le titre, la photo et le contenu sont obligatoires)  
      `POST   /api/v1/articles/`
- Modifier un article  
      `PATCH  /api/v1/articles/:id`
- Supprimer un article  
      `DELETE /api/v1/articles/:id`

### COMMENTAIRES

- Publier un commentaire (possible une seule fois par utilisateur par article, et pas sur ses propres articles. Le texte est facultatif, la note est obligatoire, un entier entre 0 et 5)  
    `POST /api/v1/articles/article_id:/reviews`
- Supprimer un commentaire (possible seulement si on est l'auteur du commentaire)  
    `DELETE /api/v1/articles/article_id:/:id`



A bientôt pour le debrief ! ٩(◕‿◕｡)۶	
