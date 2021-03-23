#!/bin/env python3
import os

def check_o2(name, file):
    if (name[-2:] != ".h" and name[-2:] != ".c"):
        print("Erreur (O2) fichier interdit " + name)

def verif_norm(path, file_name):
    if (file_name[-2:] == ".h"):
        fd = open(path, "r")
        sto = fd.read()
        file = sto.split('\n')
        check_v1(path, file)
        fd.close()
    if (file_name[-2:] == ".c"):
        fd = open(path, "r")
        sto = fd.read()
        file = sto.split('\n')
        check_f3(path, file)
        check_f4(path, file)
        check_O3(path, file)
        check_L6(path, file)
        check_V1_file(path, file)
        check_C1(path, file)
        check_G2(path, file)
        check_G1(path, file)
        check_f6(path, file)
        check_L2(path, file)
        check_L3(path, file)
        check_L4(path, file)
        end_space(path, file)
        fd.close()
    else:
        if (file_name != "Makefile"):
            print_error(path, 0, "Type de fichier interdit.", "green")

def main():
    for (repertoire, sousRepertoires, fichiers) in os.walk("./"):
        no_verif = [".git", ".gitignore", "tests"]
        verif = True
        for name in no_verif:
            if name in repertoire.split('/'):
                verif = False
        if ("Norm.py" in fichiers):
            fichiers.remove("Norm.py")
        if verif:
            for fichier in fichiers:
                if (fichier[0] != "."):
                    verif_norm(repertoire + "/" + fichier, fichier)

def print_color(to_print, color, bold):
    print("\033[1m", end='') if bold == 1 else ""
    print("\033[31m", end='') if color == "red" else ""
    print("\033[32m", end='') if color == "green" else ""
    print("\033[36m", end='') if color == "blue" else ""
    print("\033[33m", end='') if color == "yellow" else ""
    print(to_print + "\033[0m", end='')

def print_error(file, line, info, color):
    if line != 0:
        print_color("[" + file + ":" + str(line) + "]", color, 1)
    else:
        print_color("[" + file + "]", color, 1)
    print_color(" " + info, "white", 1)
    print("")

# ------CHECK------ #

def check_V1(name, file):
    declaration = ["int ", "char ", "float ", "bool ", "_t"]
    num = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    for index, line in enumerate(file):
        for p in range(5):
            for q in range(10):
                if (declaration[p] in line and num[q] in line and "//" not in line):
                    if p == 5:
                        print_error(name, index + 1, "In your declaration of struct you have a number (" + num[q] + ")." , "yellow")
                    else:
                        print_error(name, index + 1, "In your declaration [" + declaration[p] + "] you have a number (" + num[q] + ")." , "yellow")
    for index, line in enumerate(file):
        if ("typedef" in line and "_t" not in line):
            print_error(name, index + 1, "In your declaration typedef[struct] you have a invalid name (need *_t)." , "red")

def check_f4(name, file):
    max_len = len(file)
    for i in range(len(file)):
        if file[i][:1] == '{':
            p = i + 1
            while p + 1 < max_len and file[p][:1] != '}':
                p += 1
            if ((p - i) - 1) > 20:
                print_error(name, (i+1), "Function contains more than 20 lines (" + str(((p - i) - 1)) + " > 20).", "red")

def check_f3(name, file):
    for i in range(len(file)):
        if len(file[i]) > 80:
            print_error(name, (i+1), "Too many columns (" + str(len(file[i])) + " > 80).", "red")

def check_O3(name, file):
    fonction = 0
    for i in range(len(file)):
        if file[i][:1] == '{':
            fonction += 1
    if fonction > 5:
        print_error(name, 0, "More than 5 functions in the file (" + str(fonction) + " > 5).", "red")

def check_L6(name, file):
    conteur = 0
    espace = 0
    for i in range(len(file)):
        conteur = 0
        for t in file[i]:
            if t != " ":
                conteur += 1
        if conteur == 0:
            if espace == 0:
                espace += 1
            else:
                print_error(name, (i+1), "More than 1 return line in a row.", "yellow")
        else:
            espace = 0

def check_V1_file(name, file):
    fault = 0
    for x in name.split('/')[-1][:-2]:
        if (x.isalnum()):
            if (x.isupper()):
                fault = 1
        elif (x != '_'):
            fault = 1
    if (fault == 1):
        print_error(name, 0, "The filename of the file must follow the snake case convention.", "red")

def check_C1(name, file):
    error = 0
    for index, line in enumerate(file):
        space = 0
        if (len(line) > 0):
            while (space < len(line) and line[space] == ' '):
                space += 1
            if (space > 12 and error == 0):
                error = 1
                print_error(name, index, "Too many condition or nested loop.", "yellow")
            elif (space >= 8 and "else if" in line):
                error = 1
                print_error(name, index + 1, "Too many condition or nested loop.", "yellow")
            else:
                error = 0

def check_G2(name, file):
    for i in range(len(file)):
        if (i == 0):
            i += 1
        if (file[i - 1][:1] == "}" and file[i][:1].isalnum() == True):
            print_error(name, i, "You forgot a space between 2 functions.", "yellow")

def check_G1(name, file):
    if (len(file) < 7):
        print_error(name, 0, "The file is empty or the header is not present.", "yellow")
    for i in range(6):
        if (file[i][:2] != "/*" and file[i][:2] != "**" and file[i][:2] != "*/"):
            print_error(name, 0, "The header is missing or has a problem.", "yellow")

def check_f6(name, file):
    bracket = 0
    slash = 0
    slash_etoile = 0

    for index, line in enumerate(file):
        for x in line:
            if x == '{':
                bracket += 1
            if x == '}':
                bracket -= 1
            if x == '/' and bracket > 0:
                slash += 1
                slash_etoile = 1
            elif x == '*' and slash_etoile == 1:
                slash_etoile = 2
            else:
                slash_etoile = 0
                slash = 0
            if (slash == 2 or slash_etoile == 2):
                print_error(name, index + 1, "A comment is present in a function.", "yellow")

def check_L2(name, file):
    space = 0
    for i in range(len(file)):
        space = 0
        while space < len(file[i]) and file[i][space] == ' ':
            space += 1
        if (space != 0 and space != 4 and space != 8 and space != 12 and space != 16):
            print_error(name, i + 1, "All indentations must be made up of 4 spaces.", "yellow")
    for i in range(len(file)):
        tab = 0
        for y in range(len(file[i])):
            if file[i][y] == '\t':
                print_error(name, i + 1, "Tabulations are prohibited and must be replaced by 4 spaces.", "yellow")

def check_L3(name, file):
    mot_cle = [" for(", " while(", " if(", " else(", " else if(", " return("]
    mot_cle2 = [" for ", " while ", " if ", " else", " else if ", " return "]
    mot_cle3 = ["for", "while", "if", "else", "else if", "return"]
    for index, line in enumerate(file):
        for p in range(5):
            if (mot_cle[p] in line):
                print_error(name, index + 1, "A space is missing after a [" + mot_cle3[p] + "]." , "yellow")

def check_L4(name, file):
    prochain = 0
    bracket = 0

    for index, line in enumerate(file):
        if (prochain == 1):
            i = 0
            while (len(line) > i and (line[i] == ' ' or line[i] == '{')):
                if line[i] == '{':
                    bracket = 1
                i += 1
            if bracket == 1:
                print_error(name, index, "Error in the order of curly brackets." , "yellow")
            bracket = 0
            prochain = 0
        if ' if ' in line or ' while ' in line or ' for ' in line or ' else if ' in line:
            prochain = 1

def end_space(name, file):
    for index, line in enumerate(file):
        reverse = line[::-1]
        if (len(reverse) > 0 and reverse[0] == ' '):
            print_error(name, index + 1, "You left a space at the end of the line." , "green")

main()