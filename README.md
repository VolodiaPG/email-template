# Template mail
La template prête à être utilisée se trouve dans `email template.html`

## Utiliser le script `generator.rb` pour générer un mail

### Utilisation
Vous devez entrer :
```console
ruby template.html config.html result.html
```
Cela génère un fichier `result.html` en sortie avec le contenu du mail.

### Fonctionnement
Le script parcours en premier le fichier `template` à la recherche de clés de la forme `__[CLE]__`. (Attention à la case). Une fois une clé trouvée, le fichier `contenu` est parcouru. Pour chaque composant l'opération est réitérée en parcourant la `template` puis le `contenu`.

### Fichier de configuration du mail
Un fichier type est ce dernier
```html
<__HEADINGIMAGE__>URL</__HEADINGIMAGE__>
<__OBJECT__>objet</__OBJECT__>
<__SUBOBJECT__>indiquer le sous objet</__SUBOBJECT__>
<__CONTENT__>
    Tout se passe ici<br>
    on peu y mettre du code <b>HTML</b> tranquillement,<br>
    mais aussi des boutons:
    <__BUTTONIMAGE__>
        <__BUTTONLINK__>url</__BUTTONLINK__>
        <__IMAGEURL__>imgurl</__IMAGEURL__>
        <__BUTTONTEXT__>Toto</__BUTTONTEXT__>
    </__BUTTONIMAGE__>
    Niceeeeeeee, un autre bouton :
   <__BUTTONIMAGE__>
        <__BUTTONLINK__>url</__BUTTONLINK__>
        <__IMAGEURL__>imgurl</__IMAGEURL__>
        <__BUTTONTEXT__>Toto</__BUTTONTEXT__>
    </__BUTTONIMAGE__>
</__CONTENT__>
<__FIRSTNAME__>fn</__FIRSTNAME__>
<__SURNAME__>sn</__SURNAME__>
<__TEL__>tel</__TEL__>
<__CONTACTEMAIL__>email</__CONTACTEMAIL__>
<__STATUS__>Toto</__STATUS__>
<__PROMO__>Promo</__PROMO__>
```
## Générer un code minifier
- CSS inliner : `https://www.campaignmonitor.com/resources/tools/css-inliner/` (enlever le css non-utile (tout sauf les media queries))
- CSS Minifier : `https://cssminifier.com/`

Attention aux media queries qui peuvent être ignorées par les clients mails !

# Credits
Volodia PAROL-GUARINO<br>
Codé avec <3 pour l'INSA Rennes