# Template mail
La template prête à être utilisée se trouve dans `email template.html`

## Fonctionnement
Le script parcours en premier un fichier `template` à la recherche de clés de la forme `__[CLE]__` (eg. `__TOTO__`). (Attention à la case). Une fois une clé trouvée, le fichier `contenu` est parcouru et remplace la clé par le contenu trouvé. Pour chaque composant l'opération est réitérée en parcourant la `template` puis le `contenu`. Un dossier `components` liste également des composants plus complexes que l'on peut utiliser

## Utilisation <i>plug'n play</i>
### Setup
Ce script a été codé sous [Ruby](www.ruby-lang.org), son installation est requise, il suffit d'y suivre le guide d'[installation](www.ruby-lang.org/en/downloads/).
#### Windows
Pour windows, pour simplement utiliser le script il faut [télécharger](https://rubyinstaller.org/downloads/) la version sans `devkit`. Il suffit de suivre les instructions comme pour installer n'importe quel autre programme. Dans l'éventualité où un ajout au `PATH` est recommendé, accepté. (le `PATH` est un varibale de Windows qui indique où certains porgramme se trouve)

### Génération d'un premier mail à partir d'une template
Pour faciliter l'utilisation du script, un autre script `generator.bat` permet de ne pas avoir à passer par une console pour taper les commandes. Il suffit de l'éxécuter.<br>
Cela signifie que le nom des fichiers utilisable ne peut être choisi et qu'une liste de fichiers doivent existés :
- `email_template.html`: c'est le fichier de la template du mail
- `content.html`: c'est ici que vous pouvez configuré / personnalisé le contenu de la template, une section est dédiée.
Le résultat sort dans un fichier `output.html`.

### Personnalisation / `content.html`
Le fichier de configuration se présente comme suit. Des balises encadrent le contenu qui viendra s'insérer à la place correspondante dans le mail.<br>
Cette notation supporte le format `HTML` qui peut-être insérer entre les balises. Par exemple pour sauter un ligne il faut mettre `<br>` à l'endroit voulu.

```html
<__HEADINGIMAGE__>
    https://drive.google.com/uc?export=view&id=1tGduKEJeJue8JZCq1FRdio2vdaBipjA0
</__HEADINGIMAGE__>
<__PRIMARYCOLOR__>rgb(239, 125, 0)</__PRIMARYCOLOR__>
<__OBJECT__>Template</__OBJECT__>
<__SUBOBJECT__>indiquer le sous objet</__SUBOBJECT__>
<__CONTENT__>
    <p>
        Tout se passe ici<br>
        on peut y mettre du code <b>HTML</b> tranquillement,<br>
        créer des paragraphes : (il vaut mieux organiser tout le document en différents paragraphes)
    </p>
    <p>
        Voici un paragraphe où le texte est en <i>italique</i>
    </p>
    <p>
        Et un autre où je mets du texte en <b>gras</b>
    </p>
    <p>
        mais aussi des boutons:
    </p>
    <__BUTTONIMAGE__>
        <__LINK__>http://google.com</__LINK__>
        <__IMAGE__>
            https://drive.google.com/uc?export=view&id=1tGduKEJeJue8JZCq1FRdio2vdaBipjA0
        </__IMAGE__>
        <__TEXT__>Toto</__TEXT__>
    </__BUTTONIMAGE__>
    <p>
        Niceeeeeeee
    </p>
    <__BUTTONIMAGE__>
        <__LINK__>http://google.com</__LINK__>
        <__IMAGE__>
            https://drive.google.com/uc?export=view&id=1tGduKEJeJue8JZCq1FRdio2vdaBipjA0
        </__IMAGE__>
        <__TEXT__>titi</__TEXT__>
    </__BUTTONIMAGE__>
    <__CONTRIBUTORS__>
        <__CONTENT__>
            Volodia <br> Jeanjean
        </__CONTENT__>
    </__CONTRIBUTORS__>
</__CONTENT__>
<__FIRSTNAME__>fn</__FIRSTNAME__>
<__SURNAME__>sn</__SURNAME__>
<__TEL__>tel</__TEL__>
<__CONTACTEMAIL__>email</__CONTACTEMAIL__>
<__STATUS__>Toto</__STATUS__>
<__PROMO__>Promo</__PROMO__>
```
### Zimbra
Dans zimbra il faudra copier le contenu de `output.html` et dans le message, cliquer sur `code source`, coller. Des fois du texte se trouve avant le beau mail, il faudra le supprimer (DOCTYPE).

## Générer un code minifier
- CSS inliner : `https://www.campaignmonitor.com/resources/tools/css-inliner/` (enlever le css non-utile (tout sauf les media queries))
- CSS Minifier : `https://cssminifier.com/`

Attention aux media queries qui peuvent être ignorées par les clients mails !

# Credits
Volodia PAROL-GUARINO<br>
Codé avec <3 pour l'INSA Rennes