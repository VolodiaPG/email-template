#!/usr/bin/ruby
# encoding: UTF-8

# Message donnant la syntaxe d'utilisation
syntaxe="Usage : #{$0} FichierTemplate.html FichierContenu.html FichierResultat.html"
$componentsRepo="./components"

# Vérification du nombre de paramètres
# Pour calculer le nombre de paramètres, on utilise la fonction ...
nbarg=ARGV.size
if (nbarg!=3) then abort syntaxe ; end

# Renommage des paramètres
(template, contenu, sortie)=ARGV

def openFile(path)
    if (!File.exist?(path))
        abort "\t[Erreur: Le fichier d'entrée #{path} n'existe pas]\n";
    end

    begin
        ret=File.open(path,"r:UTF-8") 
        rescue Errno::ENOENT
            abort "\t[Erreur: Echec d'ouverture du fichier #{path}]\n"
    end

    return ret
end

# Vérification de l'existence des fichiers
ft = openFile(template)
fc = openFile(contenu)

if (File.exist?(sortie))
	abort "\t[Erreur: Le fichier de sortie #{sortie} existe déjà]\n";
end


# Ouverture du fichier de template
# begin
# 	ft=File.open(template,"r:UTF-8") 
# 	rescue Errno::ENOENT
# 		abort "\t[Erreur: Echec d'ouverture du fichier de template #{template}]\n"
# end

# # Ouverture du fichier de contenu

# begin
# 	fc=File.open(contenu,"r:UTF-8") 
# 	rescue Errno::ENOENT
# 		abort "\t[Erreur: Echec d'ouverture du fichier de contenu #{contenu}]\n"
# end

# Ouverture du fichier de sortie

begin
	fs=File.open(sortie,"w:UTF-8") 
	rescue Errno::ENOENT
		abort "\t[Erreur: Echec d'ouverture du fichier de sortie #{sortie}]\n"
end


# Redirection du fichier de sortie vers la sortie standard dans la phase de test
# fs=STDOUT

# Modifie l'élement passé, enleve la balise
# retourne la valeur de la balise a mettre a la place de cette derniere
def parcoursBalise!(str)
    # puts "str -> #{str}"
    # str.gsub!(/<__(.+)__>(.*)<\/__#{$1}__>/, getRemplacementBalise($1, $2))

    # puts str

    while(str =~ /<__([^_\s]+)__>/)
        # puts "-->" + str

        balise = $1
        
        if (str !~ /<__(#{balise})__>(.*?)<\/__#{balise}__>/)
            abort "Balise fermante sur #{balise} manquante"
        end
        
        contenu = $2
        # puts contenu

        if (contenu =~ /<__([^_\s]+)__>/)
            # puts contenu
            #contenu nesté

            remplacement = ""

            # cas ou on est face à un composant
            file = openFile("#{$componentsRepo}/#{balise}.html")

            # iterer sur le contenu qui doit remplacer la balise -> on est plus sur le XML
            begin
                while line = file.readline
                
                    while(line =~ /__([^_\s]+)__/)
                        # puts contenu
                        temp = parcoursBalise!(contenu)                        
                        # puts contenu
                        
                        line.gsub!(/__#{$1}__/, temp)
                    end

                    remplacement += line
                
                end
            rescue EOFError
            end

            # remplacement
            # contenu = contenu.sub(/<__#{balise}__>.*?<\/__#{balise}__>/, "")
            str = str.sub(/<__#{balise}__>.*?<\/__#{balise}__>/, remplacement)
            # puts str
 
            # puts "remplacement nested"
        else
            #la balise va jsute être utilisée comme remplacement de variable
            # puts "remplacement simple"
            str.gsub!(/<__#{balise}__>.*?<\/__#{balise}__>/, "")
            return contenu
        end
    end

    return str
end

def getContent(file, keyword)
    puts "> #{keyword}"
    file.rewind
    res = ""
    level = 0
    begin
        while line=file.readline
            #one liners
            if (line =~ /<__#{keyword}__>(.*?)<\/__#{keyword}__>/)
                return $1
            end

            if (line =~ /(<__#{keyword}__>)\s*([^\s]*)\s*/)            
                if level > 0
                    res += $1
                end
                level += 1
                res += $2
            elsif (level > 0 && line =~ /^\s*([^\s].+)\s*$/)
                content = $1
                # si on a une balise fermante, est-ce la bonne cependant ?
                if (content =~ /\s*([^\s]*)\s*<\/__#{keyword}__>/)
                    # on a une balise fermante, donc un niveau de moins
                    level -= 1
                    #est-on sur la balise fermante du départ ?
                    if (level == 0)
                        res += $1
                        return res
                    end
                end

                # on ajoute la totalité de ce qu'on vient de lire dans le resultat
                res += content                
               
            end
        end
    rescue EOFError
    end
    abort "Pas de balise <__#{keyword}__>[...]</__#{keyword}__> correspondant à __#{keyword}__"
end

# Boucle de lecture du fichier template
begin
	while line=ft.readline
		# Retrait des blancs en fin de ligne
        line.gsub(/\s*$/,"")

        while (line =~ /__([^_\s]+)__/)
            temp = $1
            temp = getContent(fc, temp)
            # puts temp
            temp = parcoursBalise!(temp)
            
            line.gsub!(/__#{$1}__/, temp)
            # puts line
        end
        # line.scan(/__([^\s]+)__/).each {|corres|
        #     puts "#{corres}"
        #     line.gsub!(/__#{corres}__/, getContent(fc, corres))
        # }
        fs.print line
		
	end
rescue EOFError
end

# closing files
ft.close
fc.close
fs.close





