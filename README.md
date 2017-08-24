# KitGPEC
Base de données permettant le traitements de compétences individuelles dans une démarche GPEC



- TODO compléter/améliorer/regrouper par étapes/ ...

- Installer Docker

- Déposer le fichier **KitGPEC.xlsm** à la racine

- Ouvrir le fichier **KitGPEC.xlsm** et extraire l'onglet  **Matrice_Agent_Comp** pour en générer un fichier CSV avec des séparateurs de type points virgules. Et déposer le fichier  **Matrice_Agent_Comp.csv** dans le répertoire ``script/``

- Lancer le script script/transpose.jar sur le fichier **Matrice_Agent_Comp.csv**

  ```shell
  cd script/
  java -jar transpose.jar ./Matrice_Agent_Comp.csv
  ```

  Cela aura pour effet de générer un fichier **Matrice_Agent_Comp_final.csv** qui contiendra les même données mais transposées pour permettre aux scripts SQL de fonctionner.

- Ouvrir **Matrice_Agent_Comp_final.csv** et copier coller le contenu du premier (et unique) onglet et le coller dans l'onglet **Agents_Comp** du fichier **KitGPEC.xlsm** (normalement on se retrouve alors avec 3 colonnes et de très nombreuses lignes dans cet onglet)

- Lancer la macro **Export_CSV_Excel** contenue dans le fichier KitGPEC.xlsm ce qui aura pour effet de générer les fichiers CSV suivant à la racine qui correspondent aux N onglets du fichier KitGPEC.xlsm :
  - Agents.csv
  - Agents_Comp.csv
  - Agents_Departements.csv
  - Agents_Services.csv
  - Competences.csv
  - Departements.csv
  - Famille_Comp.csv
  - Familles.csv
  - Services.csv

- Déplacer les fichier précédement listés dans le répertoire `sql/`

- ​